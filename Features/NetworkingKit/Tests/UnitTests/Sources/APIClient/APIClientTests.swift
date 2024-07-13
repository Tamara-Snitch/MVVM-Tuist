//
// NetworkingKitTests.swift
// NetworkingKit
//
//  Created by Kirill Prokoptsov on 30.04.2024.
//  Copyright © 2024 TamaraSnitch. All rights reserved.
//

import Foundation
import Testing
import NetworkingKitTesting
@testable import NetworkingKitAPI
@testable import NetworkingKit

struct NetworkingKitTests {

	// MARK: Private properties

	private let sut: APIClient

	private let mockFileURL: URL? = {
		Bundle.NetworkingKitTesting.url(forResource: "Posts", withExtension: "json")
	}()

	// MARK: - Init

	init() {
		self.sut = .init(session: .mockedSession)
	}

	// MARK: - Test methods

	@Test func getPosts_shouldSucceed() async {
		// Given
		let givenTarget = MockRequestTarget(
			baseURL: "example.com",
			path: "/test",
			method: .get,
			mockFileURL: mockFileURL
		)
		let expectedResponse = Post.mocked

		// When
		let response = try? await sut.request(target: givenTarget, response: Post.self)

		// Then
		#expect(response == expectedResponse)
	}

	@Test func getPosts_shouldFail_ResponseType() async {
		// Given
		let givenTarget = MockRequestTarget(
			baseURL: "example.com",
			path: "/test",
			method: .get,
			mockFileURL: mockFileURL
		)
		let expectedError = ApiError.decodingError

		var error: Error?

		// When
		do {
			_ = try await sut.request(target: givenTarget, response: String.self)
		} catch let requestError {
			error = requestError
		}

		// Then
		#expect((error as? ApiError) == expectedError)
	}

	@Test func getPosts_shouldFail_MockFileURL() async throws {
		// Given
		let givenTarget = MockRequestTarget(
			baseURL: "example.com",
			path: "/test",
			method: .get,
			mockFileURL: URL(string: "badURL")
		)
		let expectedError = ApiError.mockFileError

		var error: Error?

		// When
		do {
			_ = try await sut.request(target: givenTarget, response: Post.self)
		} catch let requestError {
			error = requestError
		}

		// Then
		#expect((error as? ApiError) == expectedError)
	}
}
