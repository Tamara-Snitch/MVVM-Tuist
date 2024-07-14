//
//  MockAPIClient.swift
//  NetworkingKitTesting
//
//  Created by Prokoptsov on 09.05.2024.
//  Copyright © 2024 TamaraSnitch. All rights reserved.
//

import Foundation

// MARK: - MockAPIClient

public class MockAPIClient: IAPIRequestable, Mockable {

	public enum SuccessType {
		case simple(Decodable)
		case mockFile(URL)
	}

	// MARK: Private properties

	private let result: Result<SuccessType, ApiError>

	// MARK: Init

	public init(result: Result<SuccessType, ApiError>) {
		self.result = result
	}

	// MARK: IAPIRequestable

	public func request<T>(target: any ITargetProvidable, response: T.Type) async throws -> T where T : Decodable {
		switch result {
		case .success(let success):
			switch success {
			case .simple(let decodableModel):
				return decodableModel as! T
			case .mockFile(let url):
				return try! loadJSON(fileURL: url, response: response)
			}
		case .failure(let error):
			throw error
		}
	}
}
