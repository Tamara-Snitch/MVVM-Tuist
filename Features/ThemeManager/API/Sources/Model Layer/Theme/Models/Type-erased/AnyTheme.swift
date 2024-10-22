//
//  AnyTheme.swift
//  ThemeManagerAPI
//
//  Created by Prokoptsov on 14.08.2024.
//  Copyright © 2024 TamaraSnitch. All rights reserved.
//

public struct AnyTheme: Theme {

	// MARK: - Public properties

	public var displayName: String {
		return _displayName()
	}

	public var typeInfo: String {
		return _typeInfo()
	}

	public var colorPalette: AnyColorPalette {
		return _colorPalette()
	}

	public var typography: AnyTypography {
		return _typography()
	}

	// MARK: - Private properties

	private let _displayName: () -> String
	private let _typeInfo: () -> String
	private let _colorPalette: () -> AnyColorPalette
	private let _typography: () -> AnyTypography

	// MARK: - Init

	public init<T: Theme>(_ theme: T) {
		self._displayName = { theme.displayName }
		self._typeInfo = { theme.typeInfo }
		self._colorPalette = { theme.colorPalette }
		self._typography = { theme.typography }
	}
}

// MARK: - Equatable

public extension AnyTheme {
	static func == (lhs: AnyTheme, rhs: AnyTheme) -> Bool {
		return lhs.typeInfo == rhs.typeInfo &&
		lhs.colorPalette == rhs.colorPalette &&
		lhs.typography == rhs.typography
	}
}

extension AnyTheme {
	public static let allThemes: [AnyTheme] = [
		AnyTheme(AppTheme.light),
		AnyTheme(AppTheme.dark),
		AnyTheme(AppTheme.system)
	]
}
