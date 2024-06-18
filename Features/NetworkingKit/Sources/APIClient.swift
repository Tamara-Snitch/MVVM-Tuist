//
//  APIClient.swift
//  NetworkingKit
//
//  Created by Prokoptsov on 30.04.2024.
//  Copyright © 2024 TamaraSnitch. All rights reserved.
//

import Foundation
import NetworkingKitAPI

public final class APIClient: IAPIRequestable {

	// MARK: Private properties

	private let session: URLSession
	private let jsonDecoder: JSONDecoder

	// MARK: Init

	public init(
		session: URLSession = .APIConfigured,
		jsonDecoder: JSONDecoder = .init()
	) {
		self.session = session
		self.jsonDecoder = jsonDecoder
	}

	// MARK: Public methods

	public func request<T: Decodable>(target: ITargetProvidable, response: T.Type) async throws -> T {
		do {
			if let mockFileURL = target.mockFileURL {
				return try handleMockedAPIRequest(mockFileURL: mockFileURL, response: response)
			} else {
				let (data, response) = try await session.data(for: target.makeRequest())
				return try self.handleAPIRequest(data: data, response: response)
			}
		} catch let error as ApiError {
			throw error
		} catch {
			throw ApiError(
				errorCode: "0",
				message: "Unknown API error \(error.localizedDescription)"
			)
		}
	}

	// MARK: - Private methods

	private func handleMockedAPIRequest<T: Decodable>(mockFileURL: URL?, response: T.Type) throws -> T {
		do {
			guard let mockFileURL else {
				throw ApiError.urlError
			}
			let data = try Data(contentsOf: mockFileURL)
			return try jsonDecoder.decode(response, from: data)

		} catch {
			throw error
		}
	}

	private func handleAPIRequest<T: Decodable>(data: Data, response: URLResponse) throws -> T {
		guard let response = response as? HTTPURLResponse else {
			throw ApiError(errorCode: "0", message: "Invalid response")
		}
		switch response.statusCode {
		case 200...299:
			do {
				return try JSONDecoder().decode(T.self, from: data)
			} catch {
				print("‼️ error occured: \(error)")
				throw ApiError(errorCode: "666", message: "Error decoding data")
			}
		default:
			guard let decodedError = try? JSONDecoder().decode(ApiError.self, from: data) else {
				throw ApiError(
					statusCode: response.statusCode,
					errorCode: "ERROR-0",
					message: "Unknown backend error"
				)
			}
			throw ApiError(
				statusCode: response.statusCode,
				errorCode: decodedError.errorCode,
				message: decodedError.message
			)
		}
	}
}
