//
// ThemesTestingModel.swift
// ThemeManagerTesting
//
//  Created by Kirill Prokoptsov on 22.08.2024.
//  Copyright © 2024 TamaraSnitch. All rights reserved.
//

import ThemeManagerAPI

public struct ThemesTestingModel {
	public static let allThemes: [AnyTheme] = [
		AnyTheme(AppTheme.light),
		AnyTheme(AppTheme.dark),
		AnyTheme(AppTheme.system)
	]
}
