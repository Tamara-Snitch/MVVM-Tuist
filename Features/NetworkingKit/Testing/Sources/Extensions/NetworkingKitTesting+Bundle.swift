//
//  NetworkingKitTesting+Bundle.swift
//  NetworkingKitTesting
//
//  Created by Prokoptsov on 14.07.2024.
//  Copyright © 2024 TamaraSnitch. All rights reserved.
//

import Foundation.NSBundle
import NetworkingKitTestingResources

public extension Bundle {
	static var networkingKitTesting: Bundle {
		Bundle(for: NetworkingKitTestingResourcesType.self)
	}
}
