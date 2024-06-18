//
//  ApiError.swift
//  NetworkingKitAPI
//
//  Created by Prokoptsov on 30.04.2024.
//  Copyright © 2024 TamaraSnitch. All rights reserved.
//

// MARK: - ApiError

public struct ApiError: Error {
	
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
		statusCode: 0,
		errorCode: "0",
		message: "URL error"
	)
	static let encodingBodyError = ApiError(
		statusCode: 0,
		errorCode: "0",
		message: "Error encoding http body"
	)
}
