//
//  NetworkingKitAssembly.swift
//  NetworkingKit
//
//  Created by Prokoptsov on 24.06.2024.
//  Copyright © 2024 TamaraSnitch. All rights reserved.
//

import Foundation
import NetworkingKitAPI
import DITranquillity

public final class NetworkingKitFramework: DIFramework {
	public static func load(container: DIContainer) {
		container.register { APIClient.init() }
			.as(IAPIRequestable.self)
			.lifetime(.single)
	}
}
