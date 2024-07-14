//
//  ITargetProvidable.swift
//  NetworkingKitUnitTests
//
//  Created by Prokoptsov on 09.05.2024.
//  Copyright © 2024 TamaraSnitch. All rights reserved.
//

import Testing
import NetworkingKitTesting
@testable import NetworkingKitAPI
@testable import NetworkingKit

struct ITargetProvidableTests {

	@Test func makeRequest_shouldSucceed() {
		// Given
		let mockEndpointProvider = MockRequestTarget(
			baseURL: "example.com",
			path: "/test",
			method: .get
		)
		let expectedAbsoluteStringURL = "\(mockEndpointProvider.scheme)://\(mockEndpointProvider.baseURL + mockEndpointProvider.path)"
		let expectedHttpHeaders: [String: String] = [
			"Accept": "application/json",
			"Content-Type": "application/json",
			"X-Use-Cache": "true"
		]

		// When
		let urlRequest = try? mockEndpointProvider.makeRequest()

		// Then
		#expect(urlRequest != nil)
		#expect(urlRequest?.url?.absoluteString == expectedAbsoluteStringURL)
		#expect(urlRequest?.httpMethod == mockEndpointProvider.method.rawValue)
		#expect(urlRequest?.allHTTPHeaderFields == expectedHttpHeaders)
	}

	@Test() func makeRequest_shouldFail() {
		// Given
		let mockEndpointProvider = MockRequestTarget(
			baseURL: "",
			path: "",
			method: .get
		)
		let expectedError = ApiError.urlError

		var error: Error?

		// When
		do {
			_ = try mockEndpointProvider.makeRequest()
		} catch let urlError {
			error = urlError
		}

		// Then
		#expect((error as? ApiError) == expectedError)
	}
}
