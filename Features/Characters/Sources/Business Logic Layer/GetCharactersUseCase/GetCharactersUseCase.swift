//
//  GetCharactersUseCase.swift
//  Characters
//
//  Created by Prokoptsov on 20.06.2024.
//  Copyright © 2024 TamaraSnitch. All rights reserved.
//

import Common
import CharactersAPI

public final class GetCharactersUseCase: GetCharactersUseCaseAPI {

	// MARK: - GetCharactersUseCaseAPI properties

	public var hasMoreItems: Bool {
		repository.hasMoreItems
	}

	// MARK: - Private properties

	private let repository: GetCharactersRepositoryAPI

	// MARK: - Init

	public init(repository: GetCharactersRepositoryAPI) {
		self.repository = repository
	}

	// MARK: - GetCharactersUseCaseAPI methods

	public func execute() async -> Result<[CharactersResponse], Error> {
		await repository.getCharacters()
	}

	public func reset() {
		repository.reset()
	}
}
