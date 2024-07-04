//
//  CharactersListView.swift
//  Characters
//
//  Created by Prokoptsov on 29.04.2024.
//  Copyright © 2024 TamaraSnitch. All rights reserved.
//

import Common
import CharactersAPI
import UIComponents
import SwiftUI

struct CharactersListView: CharactersListViewAPI {
	private enum Constants {
		static let scrollHorizontalSpacing: CGFloat = 16.0
		static let pickerWidth: CGFloat = 100
		static let progressScale: CGFloat = 1.5
	}

	// MARK: - Internal properties

	@StateObject var viewModel: CharactersListViewModel
	@State var shouldLoadNextPage: Bool = false

	// MARK: - Public properties

	var body: some View {
		VStack {
			collectionTypePicker
			charactersScrollView
		}
		.onAppear {
			viewModel.performAction(.loadCharacters)
		}
		.onChange(of: shouldLoadNextPage) { isNextPageNeeded in
			guard isNextPageNeeded else { return }
			viewModel.performAction(.loadCharacters)
		}
	}

	// MARK: - Private properties

	private var collectionTypePicker: some View {
		Picker("", selection: $viewModel.state.selectedGridStyle) {
			ForEach(GridStyle.allCases, id: \.self) { style in
				Image(systemName: style.imageName)
			}
		}
		.pickerStyle(.segmented)
		.frame(width: Constants.pickerWidth)
	}

	private var charactersScrollView: some View {
		ScrollView {
			CharactersGridView(
				listStyle: viewModel.state.selectedGridStyle,
				characters: viewModel.state.characters,
				shouldLoadNextPage: $shouldLoadNextPage
			)
			.emptyState(viewModel.state.characters.isEmpty) {
				Text("characters.emptyResponse")
					.multilineTextAlignment(.center)
			}
		}
		.scrollIndicators(.hidden)
		.padding(.horizontal, Constants.scrollHorizontalSpacing)
		.overlay {
			if viewModel.state.isLoading {
				ProgressView()
					.progressViewStyle(CircularProgressViewStyle(tint: .green))
					.scaleEffect(Constants.progressScale, anchor: .center)
			}
		}
		.refreshable {
			viewModel.performAction(.reset(.loadCharacters))
		}
	}
}
