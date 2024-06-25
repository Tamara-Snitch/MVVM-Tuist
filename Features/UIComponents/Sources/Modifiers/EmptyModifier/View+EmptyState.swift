//
//  View+EmptyState.swift
//  UIComponents
//
//  Created by Prokoptsov on 18.06.2024.
//  Copyright © 2024 TamaraSnitch. All rights reserved.
//

import SwiftUI

public extension View {
	func emptyState<EmptyContent>(
		_ isEmpty: Bool,
		emptyContent: @escaping () -> EmptyContent
	) -> some View where EmptyContent: View {
		modifier(EmptyStateViewModifier(isEmpty: isEmpty, emptyContent: emptyContent))
	}
}
