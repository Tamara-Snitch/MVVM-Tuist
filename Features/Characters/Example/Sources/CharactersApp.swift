//
// CharactersApp.swift
// Characters
//
//  Created by Kirill Prokoptsov on 20.04.2024.
//  Copyright © 2024 TamaraSnitch. All rights reserved.
//

import Characters
import NetworkingKit
import SwiftUI

@main
struct CharactersApp: App {
	@UIApplicationDelegateAdaptor(CharactersAppDelegate.self) var appDelegate

	var body: some Scene {
		WindowGroup {
			AnyView(appDelegate.makeCharacterListView())
		}
	}
}
