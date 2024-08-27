//
//  MockAPICLient.swift
//  MockServices
//
//  Created by Prokoptsov on 27.08.2024.
//  Copyright © 2024 TamaraSnitch. All rights reserved.
//

import Foundation
import NetworkingKitAPI

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

	public func request<T>(target: any ITargetProvidable, response: T.Type) async throws -> T where T: Decodable {
		switch result {
		case .success(let success):
			switch success {
			case .simple(let decodableModel):
				// swiftlint:disable:next force_cast
				return decodableModel as! T
			case .mockFile(let url):
				// swiftlint:disable:next force_try
				return try! loadJSON(fileURL: url, response: response)
			}
		case .failure(let error):
			throw error
		}
	}
}
