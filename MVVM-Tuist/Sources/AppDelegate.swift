//
//  AppDelegate.swift
//  MVVM-Tuist
//
//  Created by Prokoptsov on 25.06.2024.
//  Copyright © 2024 TamaraSnitch. All rights reserved.
//

import DITranquillity
import NetworkingKit
import UserDefaultsService
import ThemeManagerAPI
import ThemeManager
import CharactersAPI
import Characters
import SwiftUI

final class AppDelegate: NSObject, UIApplicationDelegate {
	private enum Constants {
		static let rickAndMortyURL = "rickandmortyapi.com"
	}

	// MARK: - Private properties

	// TODO: - Временное решение
	private let container: DIContainer = {
		let container = DIContainer()
		container.register { AnyTheme.allThemes }
		container.append(framework: UserDefaultsServiceFramework.self)
		container.append(framework: ThemeManagerFramework.self)
		container.append(framework: NetworkingKitFramework.self)
		container.append(framework: CharactersFramework.self)
		return container
	}()
}

// MARK: - CharacterListView

extension AppDelegate {
	func makeCharacterListView() -> any View {
		let arguments = AnyArguments(for: GetCharactersRemoteDataSource.self, args: Constants.rickAndMortyURL)
		let view: any CharactersListViewAPI = container.resolve(
			arguments: arguments
		)
		return view
	}
}
