//
//  AppTheme+ColorPalette.swift
//  ThemeManagerAPI
//
//  Created by Prokoptsov on 14.08.2024.
//  Copyright © 2024 TamaraSnitch. All rights reserved.
//

import Common
import SwiftUI

public extension AppTheme {
	var colorPalette: AnyColorPalette {
		let colorPallette: any ColorPaletteAPI
		switch self {
		case .light:
			colorPallette = ColorPalette(
				backgroundPrimary: Color(hex: "FFFFFF"),
				backgroundSecondary: Color(hex: "F7F7F7"),
				backgroundSearch: Color(hex: "F5F7F3"),
				accentPrimary: Color(hex: "8DBE28"),
				badgePrimary: Color(hex: "ACE832"),
				textPrimary: Color(hex: "3B3B3B"),
				textSecondary: Color(hex: "445D10"),
				textTertiary: Color(hex: "3B3B3B"),
				divider: Color(hex: "B4EA46")
			)
		case .dark:
			colorPallette = ColorPalette(
				backgroundPrimary: Color(hex: "2D2E30"),
				backgroundSecondary: Color(hex: "4C4C4C"),
				backgroundSearch: Color(hex: "505153"),
				accentPrimary: Color(hex: "DDDDDD"),
				badgePrimary: Color(hex: "CFF189"),
				textPrimary: Color(hex: "C0C0C0"),
				textSecondary: Color(hex: "C1D29D"),
				textTertiary: Color(hex: "FFFFFF"),
				divider: Color(hex: "5F5E5E")
			)
		case .gray:
			colorPallette = ColorPalette(
				backgroundPrimary: Color(hex: "F8F9FA"),
				backgroundSecondary: Color(hex: "F7F7F7"),
				backgroundSearch: Color(hex: "E6E8EA"),
				accentPrimary: Color(hex: "343A40"),
				badgePrimary: Color(hex: "7F7F7F"),
				textPrimary: Color(hex: "33373B"),
				textSecondary: Color(hex: "21294F"),
				textTertiary: Color(hex: "363A4C"),
				divider: Color(hex: "DADCDE")
			)
		case .system:
			colorPallette = UITraitCollection.current.userInterfaceStyle == .dark
			? AppTheme.dark.colorPalette
			: AppTheme.light.colorPalette
		}
		return AnyColorPalette(colorPallette)
	}
}
