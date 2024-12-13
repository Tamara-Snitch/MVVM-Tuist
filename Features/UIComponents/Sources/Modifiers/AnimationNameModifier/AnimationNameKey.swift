//
//  AnimationNameKey.swift
//  UIComponents
//
//  Created by Prokoptsov on 02.10.2024.
//  Copyright © 2024 TamaraSnitch. All rights reserved.
//

import Common
import SwiftUI

private struct AnimationNameKey: EnvironmentKey {
	static let defaultValue: String = .empty
}

public extension EnvironmentValues {
	var animationName: String {
		get { self[AnimationNameKey.self] }
		set { self[AnimationNameKey.self] = newValue }
	}
}
