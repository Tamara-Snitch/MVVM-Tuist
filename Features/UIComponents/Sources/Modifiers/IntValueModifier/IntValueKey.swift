//
//  IntValueKey.swift
//  UIComponents
//
//  Created by Prokoptsov on 03.09.2024.
//  Copyright © 2024 TamaraSnitch. All rights reserved.
//

import SwiftUI

private struct IntValueKey: EnvironmentKey {
	static let defaultValue: Int = .zero
}

public extension EnvironmentValues {
	var intValueKey: Int {
		get { self[IntValueKey.self] }
		set { self[IntValueKey.self] = newValue }
	}
}
