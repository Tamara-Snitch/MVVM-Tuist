//
//  RAMDecodable+CharactersStub.swift
//  CharactersTesting
//
//  Created by Prokoptsov on 13.07.2024.
//  Copyright © 2024 TamaraSnitch. All rights reserved.
//

import CharactersAPI

public extension RAMDecodable where T == CharactersResponse {
	static let stub: Self = .init(
		info: .init(
			count: 5,
			pages: 1,
			next: nil,
			prev: nil
		),
		results: [
			CharactersResponse(
				id: 1,
				name: "Rick Sanchez",
				status: "Alive",
				species: "Human",
				type: "",
				gender: "Male",
				image: "https://rickandmortyapi.com/api/character/avatar/1.jpeg",
				location: CharactersResponse.Location(name: "Citadel of Ricks")
			),
			CharactersResponse(
				id: 2,
				name: "Morty Smith",
				status: "Alive",
				species: "Human",
				type: "",
				gender: "Male",
				image: "https://rickandmortyapi.com/api/character/avatar/2.jpeg",
				location: CharactersResponse.Location(name: "Citadel of Ricks")
			),
			CharactersResponse(
				id: 3,
				name: "Summer Smith",
				status: "Alive",
				species: "Human",
				type: "",
				gender: "Female",
				image: "https://rickandmortyapi.com/api/character/avatar/3.jpeg",
				location: CharactersResponse.Location(name: "Earth (Replacement Dimension)")
			),
			CharactersResponse(
				id: 4,
				name: "Beth Smith",
				status: "Alive",
				species: "Human",
				type: "",
				gender: "Female",
				image: "https://rickandmortyapi.com/api/character/avatar/4.jpeg",
				location: CharactersResponse.Location(name: "Earth (Replacement Dimension)")
			),
			CharactersResponse(
				id: 5,
				name: "Jerry Smith",
				status: "Alive",
				species: "Human",
				type: "",
				gender: "Male",
				image: "https://rickandmortyapi.com/api/character/avatar/5.jpeg",
				location: CharactersResponse.Location(name: "Earth (Replacement Dimension)")
			)
		]
	)
}
