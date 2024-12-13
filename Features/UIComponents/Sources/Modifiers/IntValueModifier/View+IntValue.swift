//
//  View+IntValue.swift
//  UIComponents
//
//  Created by Prokoptsov on 03.09.2024.
//  Copyright © 2024 TamaraSnitch. All rights reserved.
//

import SwiftUI

public extension View {
	func intValue(_ value: Int) -> some View {
		modifier(IntValueModifier(intValue: value))
	}
}
