//
//  MockNetworkingKitFramework.swift
//  NetworkingKit
//
//  Created by Prokoptsov on 15.07.2024.
//  Copyright © 2024 TamaraSnitch. All rights reserved.
//

import NetworkingKitAPI
import DITranquillity

public final class MockNetworkingKitFramework: DIFramework {
	public static func load(container: DIContainer) {
		container.register(MockAPIClient.init) { arg($0) }
			.as(IAPIRequestable.self)
	}
}
