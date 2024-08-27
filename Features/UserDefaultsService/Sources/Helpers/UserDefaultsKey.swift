//
//  UserDefaultsKey.swift
//  UserDefaultsService
//
//  Created by Prokoptsov on 22.08.2024.
//  Copyright © 2024 TamaraSnitch. All rights reserved.
//

import Foundation.NSUserDefaults

@propertyWrapper
public struct UserDefaultsKey<T> {

	// MARK: - Public properties

	public var wrappedValue: T {
		get {
			return (userDefaults.object(forKey: key) as? T) ?? defaultValue
		} set {
			userDefaults.set(newValue, forKey: key)
		}
	}

	// MARK: - Internal properties

	let key: String
	let defaultValue: T
	let userDefaults: UserDefaults

	// MARK: - Init

	init(key: String, defaultValue: T, userDefaults: UserDefaults = .standard) {
		self.key = key
		self.defaultValue = defaultValue
		self.userDefaults = userDefaults
	}
}
