//
// Optional<String>+isNilOrEmpty.swift
// Common
//
//  Created by Kirill Prokoptsov on 22.04.2024.
//  Copyright © 2024 TamaraSnitch. All rights reserved.
//

public extension Optional where Wrapped == String {
	var isNilOrEmpty: Bool {
		if case .some(let text) = self {
			return text.isEmpty
		}
		return true
	}
}
