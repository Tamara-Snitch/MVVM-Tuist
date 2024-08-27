//
// ThemeManagerSomeViewModelTests.swift
// ThemeManagerUnitTests
//
//  Created by Kirill Prokoptsov on 22.08.2024.
//  Copyright © 2024 TamaraSnitch. All rights reserved.
//

import Testing
import UserDefaultsServiceAPI
import ThemeManagerAPI
import ThemeManagerTesting
import MockServices
@testable import ThemeManager

final class ThemeManagerTests {

	// MARK: - Private properties

	private var sut: ThemeManager!
	private let themes: [AnyTheme] = ThemesTestingModel.allThemes

	// MARK: - Test methods

	@Test func selectFirstThemeFromArray_shouldSucceed() {
		self.sut = ThemeManager(
			userDefaultsService: ThemeUserDefaultsMock(),
			availableThemes: themes
		)

		do {
			// Given
			let firstTheme = try #require(themes.first)

			// Then
			#expect(firstTheme == sut.currentTheme)
		} catch {
			Issue.record()
		}
	}

	@Test func selectTheme_shouldSucceed() {
		self.sut = ThemeManager(
			userDefaultsService: ThemeUserDefaultsMock(),
			availableThemes: themes
		)

		do {
			// Given
			let nextSelectedTheme = try #require(themes.last)
			try #require(sut.currentTheme != nextSelectedTheme)

			// When
			sut.applyTheme(theme: nextSelectedTheme)

			// Then
			#expect(nextSelectedTheme == sut.currentTheme)
		} catch {
			Issue.record()
		}
	}

	@Test func initWithoutThemes_shouldReturnNil() {
		// Given
		let givenThemes: [AnyTheme] = []

		// When
		self.sut = ThemeManager(
			userDefaultsService: ThemeUserDefaultsMock(),
			availableThemes: givenThemes
		)

		// Then
		#expect(sut == nil)
	}

	@Test func selectTheme_shouldUpdateUserDefaultsService() {
		// Given
		let userDefaultsService: UserDefaultsServiceAPI = ThemeUserDefaultsMock()
		self.sut = ThemeManager(
			userDefaultsService: userDefaultsService,
			availableThemes: themes
		)

		do {
			let nextSelectedTheme = try #require(themes.last)
			#expect(userDefaultsService.selectedTheme != nextSelectedTheme.typeInfo)

			// When
			sut.applyTheme(theme: nextSelectedTheme)

			// Then
			#expect(userDefaultsService.selectedTheme == nextSelectedTheme.typeInfo)
		} catch {
			Issue.record()
		}
	}

	@Test func initWithSelectedTheme_shouldSucceed() {
		// Given
		do {
			let selectedTheme = try #require(themes.last)

			var userDefaultsService: UserDefaultsServiceAPI = ThemeUserDefaultsMock()
			userDefaultsService.selectedTheme = selectedTheme.typeInfo

			// When
			self.sut = ThemeManager(
				userDefaultsService: userDefaultsService,
				availableThemes: themes
			)

			// Expect
			#expect(sut.currentTheme == selectedTheme)
		} catch {
			Issue.record()
		}
	}
}
