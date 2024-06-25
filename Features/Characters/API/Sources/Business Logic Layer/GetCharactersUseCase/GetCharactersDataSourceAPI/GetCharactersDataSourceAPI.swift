//
//  GetCharactersDataSourceAPI.swift
//  CharactersAPI
//
//  Created by Prokoptsov on 20.06.2024.
//  Copyright © 2024 TamaraSnitch. All rights reserved.
//

public protocol GetCharactersDataSourceAPI {
	func getCharacters(page: Int) async throws -> RAMDecodable<CharactersResponse>
}
