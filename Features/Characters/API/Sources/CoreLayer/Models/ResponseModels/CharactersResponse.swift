//
//  CharactersResponse.swift
//  Characters
//
//  Created by Prokoptsov on 29.04.2024.
//  Copyright © 2024 TamaraSnitch. All rights reserved.
//


public struct CharactersResponse: Decodable {
	public let id: Int
	public let name: String
	public let status: String
	public let species: String
	public let type: String
	public let gender: String
}

public struct CharacterDomain: Identifiable, Equatable {
	public let id: Int
	public let name: String
	public let status: CharacterStatus
	public let species: String
	public let type: String
	public let gender: CharacterGender
	
	public init(
		id: Int,
		name: String,
		status: String,
		species: String,
		type: String,
		gender: String
	) {
		self.id = id
		self.name = name
		self.status = CharacterStatus(rawValue: status) ?? .unknown
		self.species = species
		self.type = type
		self.gender = CharacterGender(rawValue: gender) ?? .unknown
	}
}


public enum CharacterStatus: String, Equatable {
	case alive = "Alive"
	case dead = "Dead"
	case unknown = "unknown"
}

public enum CharacterGender: String, Equatable {
	case female = "Female"
	case male = "Male"
	case genderless = "Genderless"
	case unknown = "unknown"
}
