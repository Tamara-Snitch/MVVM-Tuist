//
//  ThemeProviderAPI.swift
//  Characters
//
//  Created by Prokoptsov on 14.08.2024.
//  Copyright © 2024 TamaraSnitch. All rights reserved.
//

public protocol ThemeProviderAPI: AnyObject {
	var currentTheme: AnyTheme { get }
}
