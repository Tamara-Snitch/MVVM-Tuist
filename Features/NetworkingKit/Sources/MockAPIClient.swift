//
//  MockAPIClient.swift
//  NetworkingKitTesting
//
//  Created by Prokoptsov on 09.05.2024.
//  Copyright © 2024 TamaraSnitch. All rights reserved.
//

import Foundation
import NetworkingKitAPI

// MARK: - MockAPIClient

public class MockAPIClient: IAPIRequestable, Mockable {

	// MARK: Private properties

	private let error: Error?
	private let localMockFileURL: URL?

	// MARK: Init

	init(error: Error? = nil, localMockFileURL: URL? = nil) {
		self.error = error
		self.localMockFileURL = localMockFileURL
	}

	// MARK: IAPIRequestable

	public func request<T>(target: any ITargetProvidable, response: T.Type) async throws -> T where T : Decodable {
		if let error {
			throw error
		} else {
			let mockFileURL = (localMockFileURL ?? target.mockFileURL)!
			return loadJSON(fileURL: mockFileURL, response: response)
		}
	}
}
