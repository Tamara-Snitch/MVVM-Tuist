//
//  View+CustomBackgroundModifier.swift
//  UIComponents
//
//  Created by Prokoptsov on 02.09.2024.
//  Copyright © 2024 TamaraSnitch. All rights reserved.
//

import SwiftUI

public extension View {
	func customBackground(_ color: Color) -> some View {
		modifier(CustomBackgroundModifier(color: color))
	}
}
