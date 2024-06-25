//
//  CharacterGridCard.swift
//  Characters
//
//  Created by Prokoptsov on 21.06.2024.
//  Copyright © 2024 TamaraSnitch. All rights reserved.
//

import Common
import CharactersAPI
import SwiftUI

struct CharacterGridCard: View {
	private enum Constants {
		static let stackSpacing: CGFloat = 0
		static let imageHeight: CGFloat = 180
		static let cardHeight: CGFloat = 220
		static let cornerRadius: CGFloat = 8

		static let lineLimit: Int = 1
	}

	// MARK: - Private properties

	private let character: CharacterDomain

	// MARK: - Init

	init(character: CharacterDomain) {
		self.character = character
	}

	// MARK: - Body

	var body: some View {
		GeometryReader { geometry in
			VStack(spacing: Constants.stackSpacing) {
				CharacterImage(width: geometry.size.width)
				Text(character.name)
					.font(.headline)
					.lineLimit(Constants.lineLimit)
					.foregroundStyle(.white)
				CharacterStatusSpeciesView(characterStatus: character.status, characterSpecies: character.species)
				Spacer()
			}
			.frame(width: geometry.size.width, height: Constants.cardHeight)
			.background(Colors.Background.widgetPrimary)
			.clipShape(
				UnevenRoundedRectangle(
					topLeadingRadius: Constants.cornerRadius,
					topTrailingRadius: Constants.cornerRadius
				)
			)
		}
		.frame(height: Constants.cardHeight)
	}

	// MARK: - Private methods

	@ViewBuilder
	private func CharacterImage(width: CGFloat) -> some View {
		AsyncImage(url: character.imageURL) { image in
			image
				.resizable()
				.scaledToFill()
				.frame(width: width, height: Constants.imageHeight)
				.clipped()
		} placeholder: {
			ProgressView()
				.controlSize(.large)
				.tint(.white)
				.frame(width: width, height: Constants.imageHeight, alignment: .center)
				.clipped()
		}
	}
}
