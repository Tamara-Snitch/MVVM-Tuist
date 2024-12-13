//
//  Theme.swift
//  ThemeManagerAPI
//
//  Created by Prokoptsov on 14.08.2024.
//  Copyright © 2024 TamaraSnitch. All rights reserved.
//

import Foundation

public protocol Theme: Equatable {
	var displayName: String { get }
	var typeInfo: String { get }

	var colorPalette: AnyColorPalette { get }
	var typography: AnyTypography { get }
	var lotties: AnyLotties { get }
}

public extension Theme {
	var typeInfo: String {
		return "\(type(of: self))-\(self)"
	}
}
