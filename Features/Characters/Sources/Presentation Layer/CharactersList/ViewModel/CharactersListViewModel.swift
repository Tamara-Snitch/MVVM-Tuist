//
//  CharactersListViewModel.swift
//  Characters
//
//  Created by Prokoptsov on 29.04.2024.
//  Copyright © 2024 TamaraSnitch. All rights reserved.
//

import Foundation
import Common
import CharactersAPI

final class CharactersListViewModel: ObservableObject {

	indirect enum Action {
		case reset(Action?)
		case loadCharacters
	}

	struct State {
		var isLoading: Bool
		var characters: [CharacterDomain]
		var errorMessage: String?
		var selectedGridStyle: GridStyle = .list

		public init() {
			isLoading = false
			characters = []
			errorMessage = nil
		}
	}

	// MARK: - Internal properties

	@Published var state: State = .init()

	var hasMoreItems: Bool { getCharactersUseCase.hasMoreItems }

	// MARK: - Private properties

	private let getCharactersUseCase: GetCharactersUseCaseAPI

	// MARK: - Init

	init(
		getCharactersUseCase: GetCharactersUseCaseAPI
	) {
		self.getCharactersUseCase = getCharactersUseCase
	}

	// MARK: Internal methods

	func performAction(_ action: Action) {
		switch action {
		case .reset(let action):
			getCharactersUseCase.reset()
			if let action {
				performAction(action)
			}
		case .loadCharacters:
			Task {
				await fetchCharacters()
			}
		}
	}

	// MARK: - Private methods

	@MainActor
	private func fetchCharacters() async {
		defer {
			state.isLoading = false
		}
		guard getCharactersUseCase.hasMoreItems else { return }
		state.isLoading = true

		let result = await getCharactersUseCase.execute()
		switch result {
		case .success(let charactersResponse):
			state.characters = charactersResponse.map(CharacterDomain.init(from:))
		case .failure(let error):
			state.errorMessage = error.localizedDescription
		}
	}
}
