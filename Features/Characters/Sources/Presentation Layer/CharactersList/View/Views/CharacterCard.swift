//
//  CharacterCard.swift
//  Characters
//
//  Created by Prokoptsov on 27.08.2024.
//  Copyright © 2024 TamaraSnitch. All rights reserved.
//

import Common
import CharactersAPI
import ThemeManagerAPI
import UIComponents
import SwiftUI
import NukeUI

struct CharacterCard: View {
	private enum Constants {
		static let imageHeightMultiplier: CGFloat = 0.79
		static let cornerRadius: CGFloat = 10.0
		static let lineLimit: Int = 1
	}

	// MARK: - Private properties

	private let character: CharacterDomain
	private let actionClosure: () -> Void

	@EnvironmentObject private var themeProvider: AnyThemeProvider

	// MARK: - Init

	init(character: CharacterDomain, actionClosure: (@escaping () -> Void)) {
		self.character = character
		self.actionClosure = actionClosure
	}

	// MARK: - Body

	var body: some View {
		GeometryReader { geometry in
			Button {
				actionClosure()
			} label: {
				VStack(alignment: .leading, spacing: Padding.extraSmall) {
					characterImage(width: geometry.size.width, height: geometry.size.height * Constants.imageHeightMultiplier)

					characterInfo()
						.padding(.horizontal, Padding.base)
				}
				.frame(width: geometry.size.width, height: geometry.size.height)
				.background(themeProvider.currentTheme.colorPalette.backgroundSecondary)
				.clipShape(RoundedRectangle(cornerRadius: Constants.cornerRadius))
			}
			.buttonStyle(ShrinkingButtonStyle())
		}
	}

	// MARK: - Private methods

	@ViewBuilder
	private func characterImage(width: CGFloat, height: CGFloat) -> some View {
		LazyImage(url: character.imageURL) { state in
			if let image = state.image {
				image
					.resizable()
					.scaledToFill()
			} else {
				ProgressView()
					.controlSize(.large)
					.tint(themeProvider.currentTheme.colorPalette.accentPrimary)
			}
		}
		.frame(width: width, height: height, alignment: .center)
		.clipped()
	}

	@ViewBuilder
	private func characterInfo() -> some View {
		VStack(alignment: .leading, spacing: .zero) {

			Text(character.name)
				.font(.system(size: 12, weight: .regular, design: .rounded))
				.lineLimit(Constants.lineLimit)
				.foregroundStyle(themeProvider.currentTheme.colorPalette.textTertiary)

			CharacterStatusSpeciesView(
				characterStatus: character.status,
				characterSpecies: character.species
			)
			.environmentObject(themeProvider)

			Spacer()
		}
	}
}
