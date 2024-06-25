//
//  MVVM-TuistApp.swift
//  MVVM-Tuist
//
//  Created by Prokoptsov on 21.06.2024.
//  Copyright © 2024 TamaraSnitch. All rights reserved.
//

import SwiftUI

@main
struct MVVMTuistApp: App {

	@UIApplicationDelegateAdaptor var appDelegate: AppDelegate

	var body: some Scene {
		WindowGroup { 
			AnyView(appDelegate.makeCharacterListView())
		}
	}
}
