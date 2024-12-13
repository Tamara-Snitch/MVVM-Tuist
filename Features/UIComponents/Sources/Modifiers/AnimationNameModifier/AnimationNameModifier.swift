//
//  AnimationNameModifier.swift
//  UIComponents
//
//  Created by Prokoptsov on 02.10.2024.
//  Copyright © 2024 TamaraSnitch. All rights reserved.
//

import SwiftUI

struct AnimationNameModifier: ViewModifier {
	var animationName: String

	func body(content: Content) -> some View {
		content
			.environment(\.animationName, animationName)
	}
}
