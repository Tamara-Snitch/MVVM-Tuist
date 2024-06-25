//
//  Color+Init.swift
//  Common
//
//  Created by Prokoptsov on 20.06.2024.
//  Copyright © 2024 TamaraSnitch. All rights reserved.
//

import SwiftUI

public extension Color {
	init(
		red: Int,
		green: Int,
		blue: Int,
		opacity: CGFloat = 1.0
	) {
		self.init(
			red: Double(red) / 255,
			green: Double(green) / 255,
			blue: Double(blue) / 255,
			opacity: opacity
		)
	}
}
