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

	enum Action {
		case resetAndLoad
		case loadCharacters
	}

	struct State {
		var isLoading: Bool = false
		var characters: [CharacterDomain] = []
		var error: Error?
		var selectedGridStyle: GridStyle = .list
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

	// MARK: - Internal methods

	func performAction(_ action: Action) async {
		switch action {
		case .resetAndLoad:
			getCharactersUseCase.reset()
			await fetchCharacters()
		case .loadCharacters:
			await fetchCharacters()
		}
	}

	// MARK: - Private methods

	@MainActor
	private func fetchCharacters() async {
		defer {
			state.isLoading = false
		}
		guard hasMoreItems else { return }
		state.isLoading = true

		let result = await getCharactersUseCase.execute()
		switch result {
		case .success(let charactersResponse):
			state.characters = charactersResponse.map(CharacterDomain.init(from:))
		case .failure(let error):
			state.error = error
		}
	}
}
