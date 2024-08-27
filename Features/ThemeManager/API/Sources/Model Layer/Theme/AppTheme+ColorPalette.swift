//
//  AppTheme+ColorPalette.swift
//  ThemeManagerAPI
//
//  Created by Prokoptsov on 14.08.2024.
//  Copyright © 2024 TamaraSnitch. All rights reserved.
//

import SwiftUI

public extension AppTheme {
	var colorPalette: AnyColorPalette {
		let colorPallette: any ColorPaletteAPI
		switch self {
		case .light:
			colorPallette = ColorPalette(
				primaryBackground: .white,
				secondaryBackground: .gray,
				searchBackground: .blue
			)
		case .dark:
			colorPallette = ColorPalette(
				primaryBackground: .black,
				secondaryBackground: .brown,
				searchBackground: .white
			)
		case .system:
			colorPallette = UITraitCollection.current.userInterfaceStyle == .dark
			? AppTheme.dark.colorPalette
			: AppTheme.light.colorPalette
		}
		return AnyColorPalette(colorPallette)
	}
}
