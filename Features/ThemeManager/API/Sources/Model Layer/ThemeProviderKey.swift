//
//  ThemeProviderKey.swift
//  ThemeManagerAPI
//
//  Created by Prokoptsov on 28.08.2024.
//  Copyright © 2024 TamaraSnitch. All rights reserved.
//

import SwiftUI

private struct ThemeProviderKey: EnvironmentKey {
	static let defaultValue: AnyThemeProvider? = nil
}

extension EnvironmentValues {
	public var themeProvider: AnyThemeProvider {
		get {
			guard let value = self[ThemeProviderKey.self] else { fatalError("value is nil") }
			return value
		}
		set { self[ThemeProviderKey.self] = newValue }
	}
}
