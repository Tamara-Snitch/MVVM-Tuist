//
//  NetworkingKitTesting+Bundle.swift
//  NetworkingKitTesting
//
//  Created by Prokoptsov on 13.07.2024.
//  Copyright © 2024 TamaraSnitch. All rights reserved.
//

import Foundation

fileprivate final class ReferenceType { }

public extension Bundle {
	static var NetworkingKitTesting: Bundle {
		Bundle(for: ReferenceType.self)
	}
}
