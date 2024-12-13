//
//  CustomBackgroundKey.swift
//  UIComponents
//
//  Created by Prokoptsov on 02.09.2024.
//  Copyright © 2024 TamaraSnitch. All rights reserved.
//

import SwiftUI

private struct CustomBackgroundKey: EnvironmentKey {
	static let defaultValue: Color = .white
}

public extension EnvironmentValues {
	var customBackgroundKey: Color {
		get { self[CustomBackgroundKey.self] }
		set { self[CustomBackgroundKey.self] = newValue }
	}
}
