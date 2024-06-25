//
// NetworkingKitUnitTests.swift
// NetworkingKit
//
//  Created by Kirill Prokoptsov on 30.04.2024.
//  Copyright © 2024 TamaraSnitch. All rights reserved.
//

import XCTest
import NetworkingKitTesting
@testable import NetworkingKit

final class NetworkingKitUnitTests: XCTestCase {

	// MARK: Private properties

	private var sut: APIClient!

	// MARK: - Lifecycle

	override func setUp() {
		super.setUp()
		sut = .init(session: URLSession.mockedSession)
	}

	override func tearDown() {
		super.tearDown()
		sut = nil
	}

	// MARK: - Test methods

	func testRequest_shouldSucceed() async throws {
		let bundle = Bundle(for: type(of: self))
		let mockFileURL = bundle.url(forResource: "Posts", withExtension: "json")

		// Given
		let givenTarget = MockRequestTarget(
			baseURL: "example.com",
			path: "/test",
			method: .get,
			mockFileURL: mockFileURL
		)
		let expectedResponse = Post.mocked
		// When
		let response = try await sut.request(target: givenTarget, response: Post.self)
		// Then
		XCTAssertEqual(response, expectedResponse)
	}
}
