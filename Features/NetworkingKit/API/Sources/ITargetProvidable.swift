//
//  ITargetProvidable.swift
//  NetworkingKitAPI
//
//  Created by Prokoptsov on 30.04.2024.
//  Copyright © 2024 TamaraSnitch. All rights reserved.
//

import Foundation

// MARK: - ITargetProvidable

public protocol ITargetProvidable {
	var scheme: String { get }
	var baseURL: String { get }
	var path: String { get }
	var method: APIMethod { get }
	var token: String? { get }
	var queryItems: [String: Any]? { get }
	var body: [String: Any]? { get }
	var mockFileURL: URL? { get }
}

public extension ITargetProvidable {

	var scheme: String {
		"https"
	}

	var token: String? {
		nil
	}

	var mockFileURL: URL? {
		nil
	}

	func makeRequest() throws -> URLRequest {

		var urlComponents = URLComponents()
		urlComponents.scheme = scheme
		urlComponents.host =  baseURL
		urlComponents.path = path
		if let queryItems = queryItems {
			urlComponents.queryItems = queryItems.compactMap { item -> URLQueryItem? in
				let value = "\(item.value)"
				guard !value.isEmpty else { return nil }
				return .init(name: item.key, value: value)
			}
		}
		guard let url = urlComponents.url,
					isURLValid(url) else {
			throw ApiError.urlError
		}

		var urlRequest = URLRequest(url: url)
		urlRequest.httpMethod = method.rawValue
		urlRequest.addValue("application/json", forHTTPHeaderField: "Accept")
		urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
		urlRequest.addValue("true", forHTTPHeaderField: "X-Use-Cache")

		if let token,
			 !token.isEmpty {
			urlRequest.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
		}
		if let body {
			do { urlRequest.httpBody = try JSONSerialization.data(withJSONObject: body, options: []) }
			catch { throw ApiError.encodingBodyError }
		}
		return urlRequest
	}
}
