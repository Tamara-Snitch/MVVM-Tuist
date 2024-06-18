//
//  ICharactersService.swift
//  CharactersAPI
//
//  Created by Prokoptsov on 30.04.2024.
//  Copyright © 2024 TamaraSnitch. All rights reserved.
//

public protocol ICharactersService {
	func getAllCharacters(request: GetAllCharactersRequest) async throws -> RAMDecodable<CharactersResponse>
}
