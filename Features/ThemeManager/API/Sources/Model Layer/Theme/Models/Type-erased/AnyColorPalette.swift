//
//  AnyColorPalette.swift
//  ThemeManagerAPI
//
//  Created by Prokoptsov on 14.08.2024.
//  Copyright © 2024 TamaraSnitch. All rights reserved.
//

import SwiftUI

public struct AnyColorPalette: ColorPaletteAPI {

	// MARK: - Public properties
	
	public var backgroundPrimary: Color {
		return _backgroundPrimary()
	}

	public var backgroundSecondary: Color {
		return _backgroundSecondary()
	}

	public var backgroundSearch: Color {
		return _backgroundSearch()
	}

	public var accentPrimary: Color {
		return _accentPrimary()
	}

	public var badgePrimary: Color {
		return _badgePrimary()
	}

	public var textPrimary: Color {
		return _textPrimary()
	}

	public var textSecondary: Color {
		return _textSecondary()
	}

	public var textTertiary: Color {
		return _textTertiary()
	}

	public var divider: Color {
		return _divider()
	}

	// MARK: - Private properties

	private let _backgroundPrimary: () -> Color
	private let _backgroundSecondary: () -> Color
	private let _backgroundSearch: () -> Color
	private let _accentPrimary: () -> Color
	private let _badgePrimary: () -> Color
	private let _textPrimary: () -> Color
	private let _textSecondary: () -> Color
	private let _textTertiary: () -> Color
	private let _divider: () -> Color

	// MARK: - Init

	init<T: ColorPaletteAPI>(_ palette: T) {
		_backgroundPrimary = { palette.backgroundPrimary }
		_backgroundSecondary = { palette.backgroundSecondary }
		_backgroundSearch = { palette.backgroundSearch }
		_accentPrimary = { palette.accentPrimary }
		_badgePrimary = { palette.badgePrimary }
		_textPrimary = { palette.textPrimary }
		_textSecondary = { palette.textSecondary }
		_textTertiary = { palette.textTertiary }
		_divider = { palette.divider }
	}
}

// MARK: - Equatable

public extension AnyColorPalette {
	static func == (lhs: AnyColorPalette, rhs: AnyColorPalette) -> Bool {
		return lhs.backgroundPrimary == rhs.backgroundPrimary
		&& lhs.backgroundSecondary == rhs.backgroundSecondary
		&& lhs.backgroundSearch == rhs.backgroundSearch
		&& lhs.accentPrimary == rhs.accentPrimary
		&& lhs.badgePrimary == rhs.badgePrimary
		&& lhs.textPrimary == rhs.textPrimary
		&& lhs.textSecondary == rhs.textSecondary
		&& lhs.textTertiary == rhs.textTertiary
		&& lhs.divider == rhs.divider
	}
}
