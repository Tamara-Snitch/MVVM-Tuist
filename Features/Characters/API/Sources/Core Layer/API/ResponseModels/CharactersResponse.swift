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
}

// MARK: - Location

public extension CharactersResponse {
	struct Location: Decodable {
		public let name: String
	}
}

