//
//  AnyThemeProvider.swift
//  ThemeManagerAPI
//
//  Created by Prokoptsov on 15.08.2024.
//  Copyright © 2024 TamaraSnitch. All rights reserved.
//

import SwiftUI
import Combine

public final class AnyThemeProvider: ThemeProviderAPI, ObservableObject {

	// MARK: - Public properties

	public var currentTheme: AnyTheme {
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
