//
//  RickAndMortyCommon.swift
//  CharactersAPI
//
//  Created by Prokoptsov on 29.04.2024.
//  Copyright © 2024 TamaraSnitch. All rights reserved.
//

public struct ResponseInfo: Decodable {
	public let count: Int
	public let pages: Int
	public let next: String?
	public let prev: String?
}


public struct RAMDecodable<T: Decodable>: Decodable {
	public let info: ResponseInfo
	public let results: [T]
}
