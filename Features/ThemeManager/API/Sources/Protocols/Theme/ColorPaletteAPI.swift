//
//  ColorPaletteAPI.swift
//  ThemeManagerAPI
//
//  Created by Prokoptsov on 14.08.2024.
//  Copyright © 2024 TamaraSnitch. All rights reserved.
//

import SwiftUI

public protocol ColorPaletteAPI: Equatable {
	var backgroundPrimary: Color { get }
	var backgroundSecondary: Color { get }
	var backgroundSearch: Color { get }
	var accentPrimary: Color { get }
	var badgePrimary: Color { get }
	var textPrimary: Color { get }
	var textSecondary: Color { get }
	var textTertiary: Color { get }
	var divider: Color { get }
}
