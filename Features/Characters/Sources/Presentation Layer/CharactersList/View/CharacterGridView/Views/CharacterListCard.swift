//
//  CharacterCardView.swift
//  Characters
//
//  Created by Prokoptsov on 20.06.2024.
//  Copyright © 2024 TamaraSnitch. All rights reserved.
//

import Common
import CharactersAPI
import UIComponents
import SwiftUI
import NukeUI

struct CharacterListCard: View {
	private enum Constants {
		static let stackSpacing: CGFloat = 12
		static let cornerRadius: CGFloat = 8

		static let imageWidth: CGFloat = 140
	}

	// MARK: Private properties

	private let character: CharacterDomain
	private let action: () -> Void

	// MARK: Init

	init(
		character: CharacterDomain,
		action: @escaping () -> Void
	) {
		self.character = character
		self.action = action
	}

	// MARK: - Body

	var body: some View {
		Button(action: action) {
			HStack(spacing: Constants.stackSpacing) {
				characterImage
				characterInfo
			}
			.background(Colors.Background.widgetPrimary)
			.clipShape(RoundedRectangle(cornerRadius: Constants.cornerRadius))
		}
		.buttonStyle(ShrinkingButtonStyle())
	}

	// MARK: - Private properties

	@MainActor
	@ViewBuilder
	private var characterImage: some View {
		LazyImage(url: character.imageURL) { imageState in
			if let image = imageState.image {
				image
					.resizable()
					.scaledToFill()
					.frame(maxWidth: Constants.imageWidth, alignment: .top)
					.clipped()
			} else {
				ProgressView()
					.controlSize(.large)
					.tint(.white)
					.frame(width: Constants.imageWidth, alignment: .center)
			}
		}
	}

	private var characterInfo: some View {
		HStack {
			VStack(alignment: .leading) {
				Spacer()
				Text(character.name)
					.font(.headline)
					.foregroundStyle(Color.white)
				CharacterStatusSpeciesView(characterStatus: character.status, characterSpecies: character.species)
				Spacer()
				Text("characters.lastLocationTitle")
					.font(.subheadline)
					.foregroundColor(.gray)
				Text(character.locationName)
					.font(.footnote)
					.foregroundStyle(Color.white)
				Spacer()
				Text("characters.genderTitle")
					.font(.footnote)
					.foregroundColor(.gray)
				Text(character.gender)
					.font(.footnote)
					.foregroundStyle(Color.white)
				Spacer()
			}
			Spacer()
		}
	}
}
