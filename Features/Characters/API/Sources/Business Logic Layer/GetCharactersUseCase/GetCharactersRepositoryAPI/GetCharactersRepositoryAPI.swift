//
//  GetCharactersRepositoryAPI.swift
//  CharactersAPI
//
//  Created by Prokoptsov on 20.06.2024.
//  Copyright © 2024 TamaraSnitch. All rights reserved.
//

public protocol GetCharactersRepositoryAPI {
	var hasMoreItems: Bool { get }

	func reset()
	func getCharacters() async -> Result<[CharactersResponse], Error>
}
