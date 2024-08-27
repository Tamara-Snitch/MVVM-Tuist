//
//  ColorPaletteAPI.swift
//  ThemeManagerAPI
//
//  Created by Prokoptsov on 14.08.2024.
//  Copyright © 2024 TamaraSnitch. All rights reserved.
//

import SwiftUI

public protocol ColorPaletteAPI: Equatable {
	var primaryBackground: Color { get }
	var secondaryBackground: Color { get }
	var searchBackground: Color { get }
}
