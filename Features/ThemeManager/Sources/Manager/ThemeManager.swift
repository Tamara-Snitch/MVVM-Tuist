//
//  dsad.swift
//  Characters
//
//  Created by Prokoptsov on 14.08.2024.
//  Copyright © 2024 TamaraSnitch. All rights reserved.
//

import UserDefaultsServiceAPI
import ThemeManagerAPI
import SwiftUI

public final class ThemeManager: ThemeManagerAPI, ObservableObject {

	// MARK: - Public properties

	@Published public var currentTheme: AnyTheme

	// MARK: - Private properties

	private var userDefaultsService: UserDefaultsServiceAPI
	private let availableThemes: [AnyTheme]

	// MARK: - Init

	init?(
		userDefaultsService: UserDefaultsServiceAPI,
		availableThemes: [AnyTheme]
	) {
		guard let firstTheme = availableThemes.first else {
			return nil
		}
		self.userDefaultsService = userDefaultsService
		self.availableThemes = availableThemes
		self.currentTheme = availableThemes.first(where: { $0.typeInfo == userDefaultsService.selectedTheme }) ?? firstTheme

		self.userDefaultsService.selectedTheme = currentTheme.typeInfo
	}

	// MARK: - Public methods

	public func applyTheme(theme: AnyTheme) {
		currentTheme = theme
		userDefaultsService.selectedTheme = theme.typeInfo
	}
}
