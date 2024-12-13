//
//  CustomTintKey.swift
//  UIComponents
//
//  Created by Prokoptsov on 02.09.2024.
//  Copyright © 2024 TamaraSnitch. All rights reserved.
//

import SwiftUI

private struct CustomTintKey: EnvironmentKey {
	static let defaultValue: Color = .black
}

public extension EnvironmentValues {
	var customTintKey: Color {
		get { self[CustomTintKey.self] }
		set { self[CustomTintKey.self] = newValue }
	}
}
