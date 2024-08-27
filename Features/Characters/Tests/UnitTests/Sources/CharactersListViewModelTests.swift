//
//  CharactersListViewModelTests.swift
//  CharactersUnitTests
//
//  Created by Prokoptsov on 13.07.2024.
//  Copyright © 2024 TamaraSnitch. All rights reserved.
//

import Foundation
import Testing
import NetworkingKitAPI
import ThemeManagerAPI
import CharactersAPI
import CharactersTesting
import MockServices
@testable import Characters

final class CharactersListViewModelTests {

	// MARK: - Private properties

	private var sut: CharactersListViewModel!

	private let mockFileURL: URL! = {
		Bundle.charactersTesting.url(forResource: "Characters", withExtension: "json")
	}()

	// MARK: - Test methods

	@Test func fetchCharacters_shouldSucceed() async {
		// Given
		let expectedCharacters = RAMDecodable<CharactersResponse>.stub
			.results
			.map(CharacterDomain.init(from:))

		sut = CharactersListViewModel(
			getCharactersUseCase: GetCharactersUseCase(
				repository: GetCharactersRepository(
					remoteDataSource: GetCharactersRemoteDataSource(
						baseURL: "",
						apiClient: MockAPIClient(result: .success(.mockFile(mockFileURL)))
					)
				)
			),
			themeManager: MockThemeManager(currentTheme: AnyTheme(AppTheme.dark))
		)

		#expect(sut.hasMoreItems == true)
		#expect(sut.state.isLoading == false)

		// When
		await sut.performAction(.loadCharacters)

		// Then
		#expect(sut.state.characters == expectedCharacters)
		#expect(sut.state.isLoading == false)
		#expect(sut.hasMoreItems == false)
	}

	@Test func fetchCharacters_shouldFail() async {
		// Given
		let expectedError = ApiError.decodingError

		sut = CharactersListViewModel(
			getCharactersUseCase: GetCharactersUseCase(
				repository: GetCharactersRepository(
					remoteDataSource: GetCharactersRemoteDataSource(
						baseURL: "",
						apiClient: MockAPIClient(result: .failure(expectedError)))
				)
			),
			themeManager: MockThemeManager(currentTheme: AnyTheme(AppTheme.dark))
		)

		#expect(sut.hasMoreItems == true)
		#expect(sut.state.isLoading == false)

		// When
		await sut.performAction(.loadCharacters)

		// Then
		#expect((try? #require(sut.state.error as? ApiError)) == expectedError)
		#expect(sut.state.isLoading == false)
	}

	@Test func fetchCharactersAndPullToRefresh_shouldSucceed() async {
		// Initial Fetching
		await fetchCharacters_shouldSucceed()

		// Given
		let expectedHasMoreItems: Bool = false
		let expectedRefreshedResponse = RAMDecodable<CharactersResponse>.stub
			.results
			.map(CharacterDomain.init(from:))

		try? #require(sut.hasMoreItems == false)

		// When
		await sut.performAction(.resetAndLoad)

		// Then
		#expect(sut.state.characters == expectedRefreshedResponse)
		#expect(sut.hasMoreItems == expectedHasMoreItems)
	}
}
