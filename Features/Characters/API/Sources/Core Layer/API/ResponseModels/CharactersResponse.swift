//
//  CharactersResponse.swift
//  Characters
//
//  Created by Prokoptsov on 29.04.2024.
//  Copyright © 2024 TamaraSnitch. All rights reserved.
//

import Foundation.NSURL

// MARK: - CharactersResponse

public struct CharactersResponse: Decodable {
	public let id: Int
	public let name: String
	public let status: String
	public let species: String
	public let type: String
	public let gender: String
	public let image: String?
	public let location: Location

	// MARK: - Init

	public init(
		id: Int,
		name: String,
		status: String,
		species: String,
		type: String,
		gender: String,
		image: String?,
		location: Location
	) {
		self.id = id
		self.name = name
		self.status = status
		self.species = species
		self.type = type
		self.gender = gender
		self.image = image
		self.location = location
	}
}

// MARK: - Location

public extension CharactersResponse {
	struct Location: Decodable {
		public let name: String

		// MARK: - Init

		public init(name: String) {
			self.name = name
		}
	}
}
