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

	public var primaryBackground: Color {
		return _primaryBackground()
	}

	public var secondaryBackground: Color {
		return _secondaryBackground()
	}

	public var searchBackground: Color {
		return _searchBackground()
	}

	// MARK: - Private properties

	private let _primaryBackground: () -> Color
	private let _secondaryBackground: () -> Color
	private let _searchBackground: () -> Color

	// MARK: - Init

	init<T: ColorPaletteAPI>(_ palette: T) {
		_primaryBackground = { palette.primaryBackground }
		_secondaryBackground = { palette.secondaryBackground }
		_searchBackground = { palette.searchBackground }
	}
}

// MARK: - Equatable

public extension AnyColorPalette {
	static func == (lhs: AnyColorPalette, rhs: AnyColorPalette) -> Bool {
		return lhs.primaryBackground == rhs.primaryBackground
		&& lhs.secondaryBackground == rhs.secondaryBackground
		&& lhs.searchBackground == rhs.searchBackground
	}
}
