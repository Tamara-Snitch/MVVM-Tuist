//
//  ShrinkingButtonStyle.swift
//  UIComponents
//
//  Created by Prokoptsov on 22.08.2024.
//  Copyright © 2024 TamaraSnitch. All rights reserved.
//

import SwiftUI

public struct ShrinkingButtonStyle: ButtonStyle {
	/// scaleEffect при нажатии на кнопку
	private let scaleEffect: CGFloat

	// MARK: - Init

	public init(scaleEffect: CGFloat = 0.98) {
		self.scaleEffect = scaleEffect
	}

	// MARK: Public methods
	
	public func makeBody(configuration: Configuration) -> some View {
		configuration.label
			.scaleEffect(configuration.isPressed ? scaleEffect : 1.0)
	}
}
