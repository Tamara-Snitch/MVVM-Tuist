//
//  AnyTypography.swift
//  ThemeManagerAPI
//
//  Created by Prokoptsov on 14.08.2024.
//  Copyright © 2024 TamaraSnitch. All rights reserved.
//

import SwiftUI

public struct AnyTypography: TypographyAPI {

	// MARK: - Public properties

	public var titleFont: Font {
		return _titleFont()
	}

	public var textFont: Font {
		return _textFont()
	}

	// MARK: - Private properties

	private let _titleFont: () -> Font
	private let _textFont: () -> Font

	// MARK: - Init

	init<T: TypographyAPI>(_ typography: T) {
		_titleFont = { typography.titleFont }
		_textFont = { typography.textFont }
	}
}

// MARK: - Equatable

public extension AnyTypography {
	static func == (lhs: AnyTypography, rhs: AnyTypography) -> Bool {
		return lhs.titleFont == rhs.titleFont
		&& lhs.textFont == rhs.textFont
	}
}
