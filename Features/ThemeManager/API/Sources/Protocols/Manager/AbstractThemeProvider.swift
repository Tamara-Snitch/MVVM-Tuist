//
//  AbstractThemeProvider.swift
//  Characters
//
//  Created by Prokoptsov on 15.08.2024.
//  Copyright © 2024 TamaraSnitch. All rights reserved.
//

import SwiftUI

open class AbstractThemeProvider: ThemeProviderAPI, ObservableObject {

	// MARK: - Open properties

	open var currentTheme: AnyTheme {
		fatalError("Subclasses must implement")
	}

	// MARK: - Init

	public init() { }
}
