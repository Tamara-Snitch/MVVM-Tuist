//
//  File.swift
//  UIComponents
//
//  Created by Prokoptsov on 18.06.2024.
//  Copyright © 2024 TamaraSnitch. All rights reserved.
//

import SwiftUI

public struct EmptyStateViewModifier<EmptyContent>: ViewModifier where EmptyContent: View {
	var isEmpty: Bool
	let emptyContent: () -> EmptyContent

	public func body(content: Content) -> some View {
		if isEmpty {
			emptyContent()
		} else {
			content
		}
	}
}
