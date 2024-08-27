//
//  AppTheme+Typography.swift
//  ThemeManagerAPI
//
//  Created by Prokoptsov on 14.08.2024.
//  Copyright © 2024 TamaraSnitch. All rights reserved.
//

public extension AppTheme {
	var typography: AnyTypography {
		return AnyTypography(
			Typography(
				titleFont: .system(size: 18),
				textFont: .system(size: 10)
			)
		)
	}
}
