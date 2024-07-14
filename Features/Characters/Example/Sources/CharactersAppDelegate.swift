//
//  CharactersAppDelegate.swift
//  CharactersExampleApp
//
//  Created by Prokoptsov on 24.06.2024.
//  Copyright © 2024 TamaraSnitch. All rights reserved.
//

import DITranquillity
import NetworkingKitAPI
import NetworkingKitTesting
import CharactersAPI
import Characters
import CharactersTesting
import SwiftUI

final class CharactersAppDelegate: NSObject, UIApplicationDelegate {
	private enum Constants {
		static let rickAndMortyURL = "rickandmortyapi.com"
	}

	// MARK: - Private properties

	private let container: DIContainer = {
		let container = DIContainer()

		container.append(framework: MockNetworkingKitFramework.self)
		container.append(framework: CharactersFramework.self)
		return container
	}()

	// MARK: - Internal methods

	func makeCharacterListView() -> any View {
		var arguments = AnyArguments()
		arguments.addArgs(
			for: MockAPIClient.self,
			args: Result<MockAPIClient.SuccessType,
			ApiError>.success(
				.mockFile(
					Bundle.charactersTesting.url(forResource: "Characters", withExtension: "json")!
				)
			)
		)


		arguments.addArgs(
			for: GetCharactersRemoteDataSource.self,
			args: Constants.rickAndMortyURL
		)

		let view: any CharactersListViewAPI = container.resolve(
			arguments: arguments
		)
		return view
	}
}
