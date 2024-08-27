//
//  CharactersGridView.swift
//  Characters
//
//  Created by Prokoptsov on 21.06.2024.
//  Copyright © 2024 TamaraSnitch. All rights reserved.
//

import CharactersAPI
import SwiftUI

struct CharactersGridView: View {
	private enum Constants {
		static let horizontalColumnSpacing: CGFloat = 12.0
		static let verticalColumnSpacing: CGFloat = 2.0
	}
	
	// MARK: - Internal properties
	
	let listStyle: GridStyle
	let characters: [CharacterDomain]
	
	@Binding var shouldLoadNextPage: Bool
	
	// MARK: - Body
	
	var body: some View {
		switch listStyle {
		case .grid:
			return AnyView(gridView)
		case .list:
			return AnyView(listView)
		}
	}
	
	// MARK: - Private properties
	
	private var content: some View {
		switch listStyle {
		case .grid:
			return AnyView(gridView)
		case .list:
			return AnyView(listView)
		}
	}
	
	private var gridView: some View {
		LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: Constants.horizontalColumnSpacing) {
			ForEach(Array(characters.enumerated()), id: \.element.id) { index, character in
				CharacterGridCard(character: character)
					.onAppear {
						shouldLoadNextPage = index >= characters.count - 4
					}
			}
		}
	}
	
	private var listView: some View {
		LazyVGrid(columns: [GridItem(.flexible())]) {
			ForEach(Array(characters.enumerated()), id: \.element.id) { index, character in
				CharacterListCard(character: character) { } // TODO: - Прокинуть Action
					.padding(.vertical, Constants.verticalColumnSpacing)
					.onAppear {
						shouldLoadNextPage = index >= characters.count - 3
					}
			}
		}
	}
}
