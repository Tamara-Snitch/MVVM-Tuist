//
//  CharacterStatusSpeciesView.swift
//  Characters
//
//  Created by Prokoptsov on 25.06.2024.
//  Copyright © 2024 TamaraSnitch. All rights reserved.
//

import CharactersAPI
import SwiftUI

struct CharacterStatusSpeciesView: View {
	private enum Constants {
		static let horizontalStackSpacing: CGFloat = 6
		static let circleViewSize: CGSize = CGSize(width: 8, height: 8)
	}
	
	// MARK: - Private properties

	private let characterStatus: CharacterDomain.CharacterStatus
	private let characterSpecies: String

	init(characterStatus: CharacterDomain.CharacterStatus, characterSpecies: String) {
		self.characterStatus = characterStatus
		self.characterSpecies = characterSpecies
	}

	// MARK: - Body

	var body: some View {
		HStack(spacing: Constants.horizontalStackSpacing) {
			Circle()
				.fill(characterStatus.color)
				.frame(width: Constants.circleViewSize.width, height: Constants.circleViewSize.height)
			Text("\(characterStatus.displayName) - \(characterSpecies)")
				.font(.subheadline)
				.foregroundStyle(Color.white)
		}
	}
}

fileprivate extension CharacterDomain.CharacterStatus {
	var color: Color {
		switch self {
		case .alive:
			return Color.green
		case .dead:
			return Color.red
		case .unknown:
			return Color.gray
		}
	}
}
