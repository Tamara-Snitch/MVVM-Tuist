//
//  IntValueModifier.swift
//  UIComponents
//
//  Created by Prokoptsov on 03.09.2024.
//  Copyright © 2024 TamaraSnitch. All rights reserved.
//

import SwiftUI

struct IntValueModifier: ViewModifier {
	var intValue: Int
	
	func body(content: Content) -> some View {
		content
			.environment(\.intValueKey, intValue)
	}
}
