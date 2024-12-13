//
//  View+AnimationNameModifier.swift
//  UIComponents
//
//  Created by Prokoptsov on 02.10.2024.
//  Copyright © 2024 TamaraSnitch. All rights reserved.
//

import SwiftUI

public extension View {
	func animationName(_ name: String) -> some View {
		modifier(AnimationNameModifier(animationName: name))
	}
}
