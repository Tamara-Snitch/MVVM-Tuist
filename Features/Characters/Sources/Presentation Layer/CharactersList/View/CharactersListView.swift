//
//  CharactersListView.swift
//  Characters
//
//  Created by Prokoptsov on 29.04.2024.
//  Copyright © 2024 TamaraSnitch. All rights reserved.
//

import UIComponents
import SwiftUI
import ComposableArchitecture

public struct CharactersListView: View {

	// MARK: - Private properties

	@Perception.Bindable
	private var store: StoreOf<CharactersListReducer>

	public init(store: StoreOf<CharactersListReducer>) {
		self.store = store
	}

	public var body: some View {
		WithPerceptionTracking {
			VStack {
				Button("Press me") {
					store.send(.loadCharacters)
				}
				List {
					ForEach(store.characters) { item in
						Text(item.name)
					}
				}
				.emptyState(store.characters.isEmpty) {
					Text("EmptyCharacters")
				}
			}
			.loadingState(store.isLoading, loadingContent: {
				ProgressView()
					.progressViewStyle(CircularProgressViewStyle(tint: .green))
					.scaleEffect(1.5, anchor: .center)
			})
			.task {
				await store.send(.loadCharacters).finish()
			}
		}
	}
}
