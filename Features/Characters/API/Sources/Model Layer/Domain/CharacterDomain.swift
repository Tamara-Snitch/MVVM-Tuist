//
//  CharacterDomain.swift
//  CharactersAPI
//
//  Created by Prokoptsov on 25.06.2024.
//  Copyright © 2024 TamaraSnitch. All rights reserved.
//

import Foundation
import Common
import SwiftUI

public struct CharacterDomain: Identifiable, Equatable {
	public let id: Int
	public let name: String
	public let status: CharacterStatus
	public let species: String
	public let type: String
	public let gender: String
	public let locationName: String
	public let imageURL: URL?

	// MARK: - Init

	init(
		id: Int,
		name: String,
		status: CharacterStatus,
		species: String,
		type: String,
		gender: String,
		locationName: String,
		imageURL: URL?
	) {
		self.id = id
		self.name = name
		self.status = status
		self.species = species
		self.type = type
		self.gender = gender
		self.locationName = locationName
		self.imageURL = imageURL
	}

	public init(from response: CharactersResponse) {
		self.init(
			id: response.id,
			name: response.name,
			status: (CharacterStatus(rawValue: response.status) ?? .unknown),
			species: response.species,
			type: response.type,
			gender: response.gender.capitalized,
			locationName: response.location.name,
			imageURL: URL(string: response.image ?? "")
		)
	}
}

// MARK: - CharacterStatus

public extension CharacterDomain {
	enum CharacterStatus: String, Equatable {
		case alive = "Alive"
		case dead = "Dead"
		case unknown = "unknown"

		public var displayName: String {
			self.rawValue.capitalized
		}

		public var color: Color {
			switch self {
			case .alive:
				Colors.CharacterStatus.alive
			case .dead:
				Colors.CharacterStatus.dead
			case .unknown:
				Colors.CharacterStatus.unknown
			}
		}
	}
}
