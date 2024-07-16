//
//  Post.swift
//  NetworkingKitTesting
//
//  Created by Prokoptsov on 09.05.2024.
//  Copyright © 2024 TamaraSnitch. All rights reserved.
//

public struct Post: Decodable, Equatable {

	public let userId: Int
	public let id: Int
	public let title: String
	public let body: String
}

public extension Post {
	static let mocked: Post = {
		.init(
			userId: 1,
			id: 2,
			title: "sunt aut facere repellat provident occaecati excepturi optio reprehenderit",
			// swiftlint:disable:next line_length
			body: "quia et suscipit\nsuscipit recusandae consequuntur expedita et cum\nreprehenderit molestiae ut ut quas totam\nnostr rerum est autem sunt rem eveniet architecto"
		)
	}()
}
