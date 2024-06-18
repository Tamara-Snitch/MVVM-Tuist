//
//  CharactersService.swift
//  Characters
//
//  Created by Prokoptsov on 30.04.2024.
//  Copyright © 2024 TamaraSnitch. All rights reserved.
//

import Foundation
import CharactersAPI
import NetworkingKitAPI

public final class CharactersService: ICharactersService {

	// MARK: Private properties

	private let baseURL: String
	private let apiClient: IAPIRequestable

	// MARK: Init

	public init(baseURL: String, apiClient: IAPIRequestable) {
		self.baseURL = baseURL
		self.apiClient = apiClient
	}

	// MARK: Public methods

	public func getAllCharacters(request: GetAllCharactersRequest) async throws -> RAMDecodable<CharactersResponse> {
		let target = CharactersTarget.getCharacters(
			baseURL: baseURL,
			request: request
		)
		return try await apiClient.request(target: target, response: RAMDecodable<CharactersResponse>.self)
	}
}
