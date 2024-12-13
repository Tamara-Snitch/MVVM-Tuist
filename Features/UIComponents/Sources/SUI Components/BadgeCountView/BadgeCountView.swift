//
//  BadgeCountView.swift
//  UIComponents
//
//  Created by Prokoptsov on 02.09.2024.
//  Copyright © 2024 TamaraSnitch. All rights reserved.
//

import SwiftUI

public struct BadgeCountView: View {

	// MARK: - Private properties

	private let size: CGFloat
	private let originX: CGFloat
	private let originY: CGFloat

	@Environment(\.intValueKey) private var value: Int
	@Environment(\.customBackgroundKey) private var backgroundColor: Color
	@Environment(\.customTintKey) private var tintColor: Color

	// MARK: - Body

	public var body: some View {
		ZStack {
			Circle()
				.fill(backgroundColor)
				.frame(width: size * widthMultplier(), height: size * widthMultplier(), alignment: .topTrailing)
				.position(x: originX, y: originY)

			if hasTwoOrLessDigits() {
				Text("\(value)")
					.foregroundColor(tintColor)
					.font(.system(size: 5, weight: .medium))
					.position(x: originX, y: originY)
			} else {
				Text("99+")
					.foregroundColor(tintColor)
					.font(.system(size: 5, weight: .medium))
					.frame(width: size * widthMultplier(), height: size * widthMultplier(), alignment: .center)
					.position(x: originX, y: originY)
			}
		}
		.opacity(value == 0 ? 0 : 1)
	}

	// MARK: - Init

	public init(
		size: CGFloat = Padding.small,
		originX: CGFloat = Padding.tiny,
		originY: CGFloat = Padding.tiny
	) {
		self.size = size
		self.originX = originX
		self.originY = originY
	}

	// MARK: - Private methods

	private func hasTwoOrLessDigits() -> Bool {
		value < 100
	}

	private func widthMultplier() -> CGFloat {
		let multiplier: CGFloat
		switch value {
		case 0..<10:
			multiplier = 1.0
		case 10..<100:
			multiplier = 1.5
		default:
			multiplier = 2.0
		}
		return multiplier
	}
}
