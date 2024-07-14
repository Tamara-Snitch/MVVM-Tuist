//
//  ApiError.swift
//  NetworkingKitAPI
//
//  Created by Prokoptsov on 30.04.2024.
//  Copyright © 2024 TamaraSnitch. All rights reserved.
//

import Foundation

// MARK: - ApiError

public struct ApiError: Error, Equatable {

	// MARK: CodingKeys

	private enum CodingKeys: String, CodingKey {
		case errorCode
		case message
	}

	// MARK: Public properties

	public var statusCode: Int = 400
	public let errorCode: String
	public let message: String

	// MARK: Init

	public init(
		statusCode: Int = 400,
		errorCode: String,
		message: String
	) {
		self.statusCode = statusCode
		self.errorCode = errorCode
		self.message = message
	}
}

// MARK: - ApiError: Decodable

extension ApiError: Decodable {
	public init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)
		errorCode = try container.decode(String.self, forKey: .errorCode)
		message = try container.decode(String.self, forKey: .message)
	}
}

public extension ApiError {
	static let urlError = ApiError(
		statusCode: -1,
		errorCode: "-1",
		message: "Error forming an URL"
	)
	static let encodingBodyError = ApiError(
		statusCode: -2,
		errorCode: "-2",
		message: "Error encoding a http body"
	)

	static let decodingError = ApiError(
		statusCode: -3,
		errorCode: "-3",
		message: "Error decoding a http response"
	)

	static let mockFileError = ApiError(
		statusCode: -4,
		errorCode: "-4",
		message: "Error finding a mockFile"
	)
}

extension ApiError: LocalizedError {
	public var errorDescription: String? {
		message
	}
}
