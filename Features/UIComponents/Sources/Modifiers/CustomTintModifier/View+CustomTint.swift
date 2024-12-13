//
//  View+CustomTint.swift
//  UIComponents
//
//  Created by Prokoptsov on 02.09.2024.
//  Copyright © 2024 TamaraSnitch. All rights reserved.
//

import SwiftUI

public extension View {
	func customTint(_ color: Color) -> some View {
		modifier(CustomTintModifier(color: color))
	}
}
