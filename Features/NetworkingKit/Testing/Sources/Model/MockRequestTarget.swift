//
//  MockRequestTarget.swift
//  NetworkingKitTesting
//
//  Created by Prokoptsov on 09.05.2024.
//  Copyright © 2024 TamaraSnitch. All rights reserved.
//

import Foundation.NSURL
import NetworkingKitAPI

public struct MockRequestTarget: ITargetProvidable {

	public let baseURL: String
	public let path: String
	public let method: NetworkingKitAPI.APIMethod
	public let queryItems: [String : Any]?
	public let body: [String : Any]?
	public let mockFileURL: URL?

	public init(
		baseURL: String,
		path: String,
		method: NetworkingKitAPI.APIMethod,
		queryItems: [String : Any]? = nil,
		body: [String : Any]? = nil,
		mockFileURL: URL? = nil
	) {
		self.baseURL = baseURL
		self.path = path
		self.method = method
		self.queryItems = queryItems
		self.body = body
		self.mockFileURL = mockFileURL
	}
}

