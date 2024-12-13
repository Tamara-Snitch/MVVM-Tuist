//
//  AppTheme+Lotties.swift
//  ThemeManagerAPI
//
//  Created by Prokoptsov on 02.10.2024.
//  Copyright © 2024 TamaraSnitch. All rights reserved.
//

import SwiftUI

public extension AppTheme {
	var lotties: AnyLotties {
		let lotties: any LottiesAPI
		switch self {
		case .light, .dark, .gray:
			lotties = Lotties(loaderLine: "LoaderLine-\(self.typeInfo)")
		case .system:
			lotties = UITraitCollection.current.userInterfaceStyle == .dark
			? AppTheme.dark.lotties
			: AppTheme.light.lotties
		}
		return AnyLotties(lotties)
	}
}
