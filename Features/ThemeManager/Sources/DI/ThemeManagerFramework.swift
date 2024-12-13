//
//  ThemeManagerFramework.swift
//  ThemeManager
//
//  Created by Prokoptsov on 22.08.2024.
//  Copyright © 2024 TamaraSnitch. All rights reserved.
//

import ThemeManagerAPI
import UserDefaultsServiceAPI
import DITranquillity
import SwiftUI

public final class ThemeManagerFramework: DIFramework {
	public static func load(container: DIContainer) {
		container.register { ThemeManager(userDefaultsService: $0, availableThemes: $1) }
			.as(ThemeManagerAPI.self)
			.as(ThemeManagerSystemObserverAPI.self)
			.as(ThemeManager.self)
			.lifetime(.single)

		container.register { [container] in
			let themeManager: ThemeManager = container.resolve()
			return AnyThemeProvider(themeManager)
		}
		.as(AnyThemeProvider.self)
		.lifetime(.single)
	}
}
