//
//  GetCharactersRemoteDataSource.swift
//  Characters
//
//  Created by Prokoptsov on 20.06.2024.
//  Copyright © 2024 TamaraSnitch. All rights reserved.
//

import NetworkingKitAPI
import CharactersAPI

public final class GetCharactersRemoteDataSource: GetCharactersDataSourceAPI {

	// MARK: Private properties

	private let baseURL: String
	private let apiClient: IAPIRequestable

	// MARK: Init

	public init(baseURL: String, apiClient: IAPIRequestable) {
		self.baseURL = baseURL
		self.apiClient = apiClient
	}

	// MARK: Public methods

	public func getCharacters(page: Int) async throws -> RAMDecodable<CharactersResponse> {
		let target = CharactersTarget.getCharacters(
			baseURL: baseURL,
			request: .init(page: page)
		)
		return try await apiClient.request(
			target: target,
			response: RAMDecodable<CharactersResponse>.self
		)
	}
}
