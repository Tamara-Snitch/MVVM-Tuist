//
//  ITargetProvidable.swift
//  NetworkingKitUnitTests
//
//  Created by Prokoptsov on 09.05.2024.
//  Copyright © 2024 TamaraSnitch. All rights reserved.
//

import XCTest
import NetworkingKitTesting
@testable import NetworkingKit

final class ITargetProvidableTests: XCTestCase {

	func testMakeRequest_shouldSucceed() {
		// Given
		let mockEndpointProvider = MockRequestTarget(
			baseURL: "example.com",
			path: "/test",
			method: .get
		)

		// When
		let urlRequest = try? mockEndpointProvider.makeRequest()

		// Then
		XCTAssertNotNil(urlRequest)
		XCTAssertEqual(urlRequest?.url?.absoluteString, "\(mockEndpointProvider.scheme)://\(mockEndpointProvider.baseURL + mockEndpointProvider.path)")
		XCTAssertEqual(urlRequest?.httpMethod, mockEndpointProvider.method.rawValue)
		XCTAssertEqual(urlRequest?.allHTTPHeaderFields?["Accept"], "application/json")
		XCTAssertEqual(urlRequest?.allHTTPHeaderFields?["Content-Type"], "application/json")
		XCTAssertEqual(urlRequest?.allHTTPHeaderFields?["X-Use-Cache"], "true")
	}

	func testMakeRequest_shouldFail() {
		// Given

		let mockEndpointProvider = MockRequestTarget(
			baseURL: "",
			path: "",
			method: .get
		)

		// When
		let urlRequest = try? mockEndpointProvider.makeRequest()
		
		// Then
		XCTAssertNil(urlRequest)
	}
}
