//
//  CharactersTesting+Bundle.swift
//  CharactersTesting
//
//  Created by Prokoptsov on 14.07.2024.
//  Copyright © 2024 TamaraSnitch. All rights reserved.
//

import Foundation.NSBundle
import CharactersTestingResources

public extension Bundle {
	static var charactersTesting: Bundle {
		Bundle(for: CharactersTestingResourcesType.self)
	}
}
