//
//  AppDelegate.swift
//  MVVM-Tuist
//
//  Created by Prokoptsov on 25.06.2024.
//  Copyright © 2024 TamaraSnitch. All rights reserved.
//

import DITranquillity
import NetworkingKit
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
		container.append(framework: NetworkingKitFramework.self)
		container.append(framework: CharactersFramework.self)
		return container
	}()

	// MARK: - Internal methods

	func makeCharacterListView() -> any View {
		let view: any CharactersListViewAPI = container.resolve(
			arguments: AnyArguments(
				for: GetCharactersRemoteDataSource.self,
				args: Constants.rickAndMortyURL
			)
		)
		return view
	}
}
