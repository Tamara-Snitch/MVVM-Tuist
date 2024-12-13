//
//  ColorPalette.swift
//  ThemeManagerAPI
//
//  Created by Prokoptsov on 14.08.2024.
//  Copyright © 2024 TamaraSnitch. All rights reserved.
//

import SwiftUI

public struct ColorPalette: ColorPaletteAPI, Equatable {
	public let backgroundPrimary: Color
	public let backgroundSecondary: Color
	public let backgroundSearch: Color
	public let accentPrimary: Color
	public let badgePrimary: Color
	public let textPrimary: Color
	public let textSecondary: Color
	public let textTertiary: Color
	public let divider: Color
}
