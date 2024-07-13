//
// CharactersTesting+Bundle.swift
// CharactersTesting
//
//  Created by Kirill Prokoptsov on 20.04.2024.
//  Copyright © 2024 TamaraSnitch. All rights reserved.
//

import Foundation

fileprivate final class ReferenceType { }

public extension Bundle {
	static var CharactersTesting: Bundle {
		Bundle(for: ReferenceType.self)
	}
}
