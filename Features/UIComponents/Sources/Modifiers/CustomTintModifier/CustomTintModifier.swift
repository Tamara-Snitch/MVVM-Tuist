//
//  CustomTintModifier.swift
//  UIComponents
//
//  Created by Prokoptsov on 02.09.2024.
//  Copyright © 2024 TamaraSnitch. All rights reserved.
//

import SwiftUI

struct CustomTintModifier: ViewModifier {
	var color: Color

	func body(content: Content) -> some View {
		content
			.environment(\.customTintKey, color)
	}
}
