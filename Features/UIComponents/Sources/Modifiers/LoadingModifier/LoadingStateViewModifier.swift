//
//  LoadingStateViewModifier.swift
//  UIComponents
//
//  Created by Prokoptsov on 18.06.2024.
//  Copyright © 2024 TamaraSnitch. All rights reserved.
//

import SwiftUI

public struct LoadingStateViewModifier<LoadingContent: View>: ViewModifier {
	var isLoading: Bool
	let loadingContent: () -> LoadingContent

	public func body(content: Content) -> some View {
		if isLoading {
			loadingContent()
		} else {
			content
		}
	}
}
