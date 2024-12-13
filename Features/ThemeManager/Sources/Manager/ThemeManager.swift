//
//  ThemeManager.swift
//  Characters
//
//  Created by Prokoptsov on 14.08.2024.
//  Copyright © 2024 TamaraSnitch. All rights reserved.
//

import UserDefaultsServiceAPI
import ThemeManagerAPI
import SwiftUI

public final class ThemeManager: ThemeManagerAPI, ThemeManagerSystemObserverAPI, ObservableObject {
	
	// MARK: - Public properties
	
	@Published public var currentTheme: AnyTheme
	
	// MARK: - Private properties
	
	private let availableThemes: [AnyTheme]
	private var userDefaultsService: UserDefaultsServiceAPI
	
	// MARK: - Init
	
	init?(
		userDefaultsService: UserDefaultsServiceAPI,
		availableThemes: [AnyTheme]
	) {
		guard let firstTheme = availableThemes.first else {
			return nil
		}
		self.userDefaultsService = userDefaultsService
		self.availableThemes = availableThemes
		self.currentTheme = availableThemes.first(where: { $0.typeInfo == userDefaultsService.selectedTheme }) ?? firstTheme
		
		self.userDefaultsService.selectedTheme = currentTheme.typeInfo
	}
	
	// MARK: - PubThemeManagerAPIlic methods
	
	public func applyTheme(theme: AnyTheme) async {
		await MainActor.run {
			currentTheme = theme
			userDefaultsService.selectedTheme = theme.typeInfo
			updateAppearance(theme)
		}
	}

	// MARK: - ThemeManagerSystemObserverAPI methods
	
	public func checkForSystemThemeUpdate() async {
		guard currentTheme.typeInfo == AppTheme.system.typeInfo else { return }
		await applyTheme(theme: AnyTheme(AppTheme.system))
	}

	// MARK: - Private methods

	private func updateAppearance(_ theme: AnyTheme) {
		let appearance = UINavigationBarAppearance()
		appearance.configureWithOpaqueBackground()
		appearance.backgroundColor = UIColor(theme.colorPalette.backgroundPrimary)
		appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
		appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]

		UINavigationBar.appearance().standardAppearance = appearance
		UINavigationBar.appearance().scrollEdgeAppearance = appearance
		UINavigationBar.appearance().compactAppearance = appearance

		UITabBar.appearance().barTintColor = UIColor(theme.colorPalette.backgroundPrimary)
		UITabBar.appearance().tintColor = UIColor(theme.colorPalette.accentPrimary)
		UITabBar.appearance().unselectedItemTintColor = .lightGray
	}
}
