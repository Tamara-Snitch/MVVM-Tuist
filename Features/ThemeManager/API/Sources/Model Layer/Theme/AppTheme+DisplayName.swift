//
//  AppTheme+DisplayName.swift
//  ThemeManagerAPI
//
//  Created by Prokoptsov on 22.08.2024.
//  Copyright © 2024 TamaraSnitch. All rights reserved.
//

import Foundation

public extension AppTheme {
	var displayName: String {
		switch self {
		case .light:
			return NSLocalizedString("appTheme.light", comment: "AppTheme-light")
		case .dark:
			return NSLocalizedString("appTheme.dark", comment: "AppTheme-dark")
		case .system:
			return NSLocalizedString("appTheme.system", comment: "AppTheme-system")
		}
	}
}
