//
//  UserDefaultsServiceFramework.swift
//  UserDefaultsService
//
//  Created by Prokoptsov on 22.08.2024.
//  Copyright © 2024 TamaraSnitch. All rights reserved.
//

import UserDefaultsServiceAPI
import DITranquillity

public final class UserDefaultsServiceFramework: DIFramework {
	public static func load(container: DIContainer) {
		container.register { UserDefaultsService() }
			.as(UserDefaultsServiceAPI.self)
	}
}
