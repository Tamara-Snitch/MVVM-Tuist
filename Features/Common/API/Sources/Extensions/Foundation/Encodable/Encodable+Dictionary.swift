//
//  Encodable+Dictionary.swift
//  Common
//
//  Created by Prokoptsov on 30.04.2024.
//  Copyright © 2024 TamaraSnitch. All rights reserved.
//

import Foundation

public extension Encodable {
	var toDictionary: [String: Any]? {
		guard let data = try? JSONEncoder().encode(self) else { return nil }
		return (try? JSONSerialization.jsonObject(with: data, options: .allowFragments)).flatMap { $0 as? [String: Any] }
	}
}
