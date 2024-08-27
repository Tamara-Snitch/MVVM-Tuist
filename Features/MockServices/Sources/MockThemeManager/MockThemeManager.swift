//
//  MockThemeManager.swift
//  MockServices
//
//  Created by Prokoptsov on 27.08.2024.
//  Copyright © 2024 TamaraSnitch. All rights reserved.
//

import ThemeManagerAPI
import SwiftUI

public final class MockThemeManager: ThemeManagerAPI, ObservableObject {

	// MARK: - Public properties

	@Published public var currentTheme: AnyTheme

	// MARK: - Init

	public init(currentTheme: AnyTheme) {
		self.currentTheme = currentTheme
	}

	// MARK: - Public methods

	public func applyTheme(theme: AnyTheme) {
		currentTheme = theme
	}
}
