//
//  GetCharactersUseCaseAPI.swift
//  CharactersAPI
//
//  Created by Prokoptsov on 21.06.2024.
//  Copyright © 2024 TamaraSnitch. All rights reserved.
//

public protocol GetCharactersUseCaseAPI {
	var hasMoreItems: Bool { get }

	func reset()
	func execute() async -> Result<[CharactersResponse], Error>
}
