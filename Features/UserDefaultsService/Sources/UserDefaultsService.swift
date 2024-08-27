//
//  UserDefaultsService.swift
//  UserDefaultsService
//
//  Created by Prokoptsov on 22.08.2024.
//  Copyright © 2024 TamaraSnitch. All rights reserved.
//

import UserDefaultsServiceAPI
import Foundation

public final class UserDefaultsService: UserDefaultsServiceAPI {

	@UserDefaultsKey(key: "selectedTheme", defaultValue: "AppTheme-system")
	public var selectedTheme: String
}
