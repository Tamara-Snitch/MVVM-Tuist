//
//  ThemeManagerAPI.swift
//  ThemeManagerAPI
//
//  Created by Prokoptsov on 14.08.2024.
//  Copyright © 2024 TamaraSnitch. All rights reserved.
//

import SwiftUI

public protocol ThemeManagerAPI: ThemeProviderAPI, AnyObject {
	func applyTheme(theme: AnyTheme) async
}
