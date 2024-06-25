//
//  GetCharactersRepository.swift
//  Characters
//
//  Created by Prokoptsov on 20.06.2024.
//  Copyright © 2024 TamaraSnitch. All rights reserved.
//

import Common
import CharactersAPI

public final class GetCharactersRepository: GetCharactersRepositoryAPI {

	// MARK: - GetCharactersRepositoryAPI properties

	public var hasMoreItems: Bool {
		currentPage <= (totalPages ?? .max)
	}

	// MARK: - Private properties

	private let remoteDataSource: GetCharactersDataSourceAPI
	private let initialPage: Int

	private var items: [CharactersResponse] = []

	private var currentPage: Int
	private var totalPages: Int?

	// MARK: - Init

	public init(
		remoteDataSource: GetCharactersDataSourceAPI,
		initialPage: Int = 1
	) {
		self.remoteDataSource = remoteDataSource
		self.initialPage = initialPage
		self.currentPage = initialPage
	}

	// MARK: - GetCharactersRepositoryAPI

	public func getCharacters() async -> Result<[CharactersResponse], Error> {
		do {
			guard hasMoreItems else { return .success(items) }
			let response = try await remoteDataSource.getCharacters(page: currentPage)
			self.updatePaginationValues(response)
			return .success(items)
		} catch {
			return .failure(error)
		}
	}

	public func reset() {
		currentPage = initialPage
		items = []
		totalPages = nil
	}

	// MARK: - Private methods

	private func updatePaginationValues(_ response: RAMDecodable<CharactersResponse>) {
		self.currentPage += 1
		self.totalPages = response.info.pages
		self.items += response.results
	}
}
