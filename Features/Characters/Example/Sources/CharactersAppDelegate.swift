//
//  CharactersAppDelegate.swift
//  CharactersExampleApp
//
//  Created by Prokoptsov on 24.06.2024.
//  Copyright © 2024 TamaraSnitch. All rights reserved.
//

import DITranquillity
import MockServices
import NetworkingKitAPI
import NetworkingKit
import UserDefaultsService
import ThemeManagerAPI
import ThemeManager
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
		container.register { AnyTheme.allThemes }
		container.append(framework: UserDefaultsServiceFramework.self)
		container.append(framework: ThemeManagerFramework.self)
		container.register { MockAPIClient(result: arg($0)) }
			.as(IAPIRequestable.self)
		container.append(framework: CharactersFramework.self)
		return container
	}()
	
	// MARK: - Internal methods
	
	func makeCharacterListView() -> any View {
		guard let url = Bundle.charactersTesting.url(
			forResource: "Characters",
			withExtension: "json"
		) else { return EmptyView() }
		
		var arguments = AnyArguments()
		arguments.addArgs(
			for: MockAPIClient.self,
			args: Result<MockAPIClient.SuccessType,
			ApiError>.success(.mockFile(url))
		)
		arguments.addArgs(for: GetCharactersRemoteDataSource.self, args: Constants.rickAndMortyURL)
		
		let view: any CharactersListViewAPI = container.resolve(arguments: arguments)
		return view
	}
}
