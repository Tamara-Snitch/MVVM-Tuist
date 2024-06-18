//
//  CharactersListReducer.swift
//  Characters
//
//  Created by Prokoptsov on 29.04.2024.
//  Copyright © 2024 TamaraSnitch. All rights reserved.
//

import Foundation
import CharactersAPI
import ComposableArchitecture

@Reducer
public struct CharactersListReducer: Reducer {

	// MARK: Reducer

	public enum Action {
		case toggleLoading(Bool)
		case loadCharacters
		case didLoadCharacters([CharacterDomain])
		case didUpdateTotalPages(Int)
		case didUpdateCurrentPage(Int)
		case setError(String)
	}

	@ObservableState
	public struct State: Equatable {
		var isLoading: Bool = false
		var characters: [CharacterDomain] = []
		var error: String? = nil

		fileprivate var currentPage: Int = 1
		fileprivate var totalPages: Int?

		public init() {}
	}

	// MARK: Internal properties

	// MARK: Private properties

	private let charactersService: ICharactersService

	// MARK: - Init

	public init(charactersService: ICharactersService) {
		self.charactersService = charactersService
	}

	public var body: some Reducer<State, Action> {
		Reduce {
			state,
			action in
			switch action {
			case .loadCharacters:
				guard state.currentPage < state.totalPages ?? .max else { return .none }
				let requestEffect = Effect<Action>.run { [state] send in
					await send(.toggleLoading(true))
					do {
						let response = try await fetchCharacters(currentPage: state.currentPage)
						await send(.didLoadCharacters(response.0))
						await send(.didUpdateCurrentPage(response.1))
						await send(.didUpdateTotalPages(response.2))
					} catch(let error) {
						await send(.setError(error.localizedDescription))
					}
					await send(.toggleLoading(false))
				}
				return requestEffect
			case .didLoadCharacters(let chars):
				print("@@ did load characters \(chars.count)")
				state.characters += chars
				return .none
			case .toggleLoading(let isLoading):
				state.isLoading = isLoading
				return .none
			case .setError(let error):
				state.error = error
				return .none
			case .didUpdateTotalPages(let pages):
				state.totalPages = pages
				print("@@ total pages \(pages)")
				return .none
			case .didUpdateCurrentPage(let page):
				state.currentPage = page
				print("@@ current page \(page)")
				return .none
			}
		}
	}

	private func fetchCharacters(currentPage: Int) async throws ->
	([CharacterDomain], Int, Int)
	{
		let request = GetAllCharactersRequest(page: currentPage)
		do {
			let response = try await charactersService.getAllCharacters(request: request)
			let domainItems = response.results.map {
				CharacterDomain(
					id: $0.id,
					name: $0.name,
					status: $0.status,
					species: $0.species,
					type: $0.type,
					gender: $0.gender
				)
			}
			return (domainItems, currentPage + 1, response.info.pages)
		}
	}
}
