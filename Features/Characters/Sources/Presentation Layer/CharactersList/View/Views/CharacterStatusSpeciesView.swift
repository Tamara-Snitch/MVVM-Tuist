//
//  CharacterStatusSpeciesView.swift
//  Characters
//
//  Created by Prokoptsov on 25.06.2024.
//  Copyright © 2024 TamaraSnitch. All rights reserved.
//

import ThemeManagerAPI
import CharactersAPI
import UIComponents
import SwiftUI

struct CharacterStatusSpeciesView: View {

	// MARK: - Private properties

	private let characterStatus: CharacterDomain.CharacterStatus
	private let characterSpecies: String

	@EnvironmentObject private var themeProvider: AnyThemeProvider

	// MARK: - Init

	init(characterStatus: CharacterDomain.CharacterStatus, characterSpecies: String) {
		self.characterStatus = characterStatus
		self.characterSpecies = characterSpecies
	}

	// MARK: - Body

	var body: some View {
		HStack(spacing: Padding.tiny) {
			Circle()
				.fill(characterStatus.color)
				.frame(width: Padding.extraSmall, height: Padding.extraSmall)
			Text("\(characterStatus.displayName) - \(characterSpecies)")
				.font(.system(size: 12, weight: .regular, design: .rounded))
				.foregroundStyle(themeProvider.currentTheme.colorPalette.textTertiary)
		}
	}
}
