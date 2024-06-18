//
// CharactersApp.swift
// Characters
//
//  Created by Kirill Prokoptsov on 20.04.2024.
//  Copyright © 2024 TamaraSnitch. All rights reserved.
//

import Characters
import NetworkingKitAPI
import NetworkingKit
import ComposableArchitecture
import SwiftUI

@main
struct CharactersApp: App {
	var body: some Scene {
		WindowGroup {
			CharactersListView(
				store: Store(
					initialState: CharactersListReducer.State(),
					reducer: {
						CharactersListReducer(
							charactersService: CharactersService(
								baseURL: "rickandmortyapi.com",
								apiClient: APIClient()
							)
						)
						._printChanges()
					})
			)
		}
	}
}
