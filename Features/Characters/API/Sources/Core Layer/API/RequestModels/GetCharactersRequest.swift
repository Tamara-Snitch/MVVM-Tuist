//
//  GetCharactersRequest.swift
//  CharactersAPI
//
//  Created by Prokoptsov on 30.04.2024.
//  Copyright © 2024 TamaraSnitch. All rights reserved.
//

public struct GetAllCharactersRequest: Encodable {
	let page: Int?

	public init(page: Int?) {
		self.page = page
	}
}
