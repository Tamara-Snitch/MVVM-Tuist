//
//  AnyThemeProvider.swift
//  Characters
//
//  Created by Prokoptsov on 14.08.2024.
//  Copyright © 2024 TamaraSnitch. All rights reserved.
//

import ThemeManagerAPI
import SwiftUI
import Combine

// MARK: - Feature Module

public final class AnyThemeProvider: AbstractThemeProvider {

	// MARK: - Public properties

	override public var currentTheme: AnyTheme {
		_currentTheme()
	}

	public var objectWillChange: AnyPublisher<Void, Never> {
		_objectWillChange
	}

	// MARK: - Private properties

	private var _currentTheme: () -> AnyTheme
	private var _objectWillChange: AnyPublisher<Void, Never>

	// MARK: - Init

	public init<T: ThemeProviderAPI & ObservableObject>(_ themeProvider: T) {
		_currentTheme = { themeProvider.currentTheme }

		_objectWillChange = themeProvider.objectWillChange
			.map { _ in () }
			.eraseToAnyPublisher()
	}
}
