//
//  CharactersListScreen.swift
//  Characters
//
//  Created by Prokoptsov on 29.04.2024.
//  Copyright © 2024 TamaraSnitch. All rights reserved.
//

import Common
import CharactersAPI
import ThemeManagerAPI
import UIComponents
import SwiftUI

struct CharactersListScreen: CharactersListScreenAPI {

	private enum Constants {
		static let searchHeight: CGFloat = 36.0
		static let cardHeightMultiplier: CGFloat = 0.246
		static let loaderLineHeight: CGFloat = 5.0

		static let progressScale: CGFloat = 1.5
	}

	// MARK: - Private properties

	@StateObject private var viewModel: CharactersListViewModel
	@StateObject private var themeProvider: AnyThemeProvider

	@State private var shouldLoadNextPage: Bool = false
	@State private var text: String = ""

	// MARK: - Public properties

	var body: some View {
		GeometryReader { geometry in
			NavigationStack {
				VStack {
					HStack {
						Spacer()
						filtersButton()
					}
					.padding(.horizontal, Padding.large)

					loaderView(width: geometry.size.width - Padding.giant)

					charactersScrollView(height: geometry.size.height * Constants.cardHeightMultiplier)
				}
				.background(themeProvider.currentTheme.colorPalette.backgroundPrimary)
				.onAppear {
					Task {
						await viewModel.performAction(.loadCharacters)
					}
				}
				.onChange(of: shouldLoadNextPage) { isNextPageNeeded in
					guard isNextPageNeeded else { return }
					Task {
						await viewModel.performAction(.loadCharacters)
					}
				}
				.toolbar {
					searchBar(width: geometry.size.width - Padding.giant)
				}
			}
			.background(themeProvider.currentTheme.colorPalette.backgroundPrimary)
		}
		.ignoresSafeArea(.keyboard)
	}

	// MARK: - Init

	init(
		viewModel: CharactersListViewModel,
		themeProvider: AnyThemeProvider
	) {
		self._viewModel = .init(wrappedValue: viewModel)
		self._themeProvider = .init(wrappedValue: themeProvider)
	}

	// MARK: - Private methods

	private func searchBar(width: CGFloat) -> some View {
		VStack {
			SearchFieldView(
				placeholder: "Search",
				searchedText: $text
			)
			.customBackground(themeProvider.currentTheme.colorPalette.backgroundSearch)
			.customTint(themeProvider.currentTheme.colorPalette.accentPrimary)
			.frame(width: width, height: Constants.searchHeight)

			Spacer()
		}
	}

	private func filtersButton() -> some View {
		Button {
			Task {
				await viewModel.performAction(.toggleIsFilterNeeded)
			}
		} label: {
			HStack(spacing: Padding.one) {
				Text("characters.filtersTitle")
					.font(.system(size: 12, weight: .regular))
					.foregroundStyle(themeProvider.currentTheme.colorPalette.textTertiary)

				Image(Icons.filterIcon)
					.resizable()
					.renderingMode(.template)
					.scaledToFit()
					.frame(width: Padding.base, height: Padding.large, alignment: .center)
					.foregroundStyle(themeProvider.currentTheme.colorPalette.textTertiary)
					.overlay(alignment: .topTrailing) {
						if !viewModel.state.filters.isEmpty {
							BadgeCountView(
								size: Padding.small,
								originX: Padding.base,
								originY: .zero
							)
							.intValue(viewModel.state.filters.count)
							.customBackground(themeProvider.currentTheme.colorPalette.badgePrimary)
							.customTint(themeProvider.currentTheme.colorPalette.backgroundPrimary)
						}
					}
			}
		}
		.buttonStyle(ShrinkingButtonStyle())
	}

	private func loaderView(width: CGFloat) -> some View {
		LoaderLineView(isLoading: $viewModel.state.isLoading)
			.animationName(themeProvider.currentTheme.lotties.loaderLine)
			.frame(width: width, height: Constants.loaderLineHeight)
	}

	private func charactersScrollView(height: CGFloat) -> some View {
		ScrollView {
			LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: Padding.base) {
				ForEach(Array(viewModel.state.characters.enumerated()), id: \.element.id) { index, character in
					CharacterCard(character: character) { [weak viewModel, character] in
						Task {
							await viewModel?.performAction(.didSelectCharacter(character))
						}
					}
					.environmentObject(themeProvider)
					.frame(
						maxWidth: .infinity,
						idealHeight: height
					)
					.onAppear {
						shouldLoadNextPage = index >= viewModel.state.characters.count - 2
					}
				}
			}
		}
		.scrollIndicators(.hidden)
		.padding(.horizontal, Padding.large)
		.overlay {
			if viewModel.state.isLoading {
				ProgressView()
					.progressViewStyle(CircularProgressViewStyle(tint: themeProvider.currentTheme.colorPalette.accentPrimary))
					.scaleEffect(Constants.progressScale, anchor: .center)
			}
		}
		.refreshable {
			Task {
				await viewModel.performAction(.resetAndLoad)
			}
		}
	}
}
