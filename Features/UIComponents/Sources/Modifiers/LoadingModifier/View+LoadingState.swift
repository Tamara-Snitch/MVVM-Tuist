//
//  View+LoadingState.swift
//  UIComponents
//
//  Created by Prokoptsov on 18.06.2024.
//  Copyright © 2024 TamaraSnitch. All rights reserved.
//

import SwiftUI

public extension View {
	func loadingState<LoadingContent>(
		_ isLoading: Bool,
		loadingContent: @escaping () -> LoadingContent
	) -> some View where LoadingContent: View {
		modifier(LoadingStateViewModifier(isLoading: isLoading, loadingContent: loadingContent))
	}
}

