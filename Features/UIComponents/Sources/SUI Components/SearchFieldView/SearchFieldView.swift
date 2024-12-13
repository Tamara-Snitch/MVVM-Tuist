//
//  SearchFieldView.swift
//  UIComponents
//
//  Created by Prokoptsov on 28.08.2024.
//  Copyright © 2024 TamaraSnitch. All rights reserved.
//

import SwiftUI

public struct SearchFieldView: View {

	private enum Constants {
		static let textTrailingPadding: CGFloat = 34.0
		static let cornerRadius: CGFloat = 10.0

		static let glassImageSize: CGSize = CGSize(width: 18, height: 17)
		static let circleImageSize: CGSize = CGSize(width: 17, height: 17)
	}

	// MARK: - Private properties

	private let placeholderText: String

	@Environment(\.customBackgroundKey) private var backgroundColor: Color
	@Environment(\.customTintKey) private var tintColor: Color
	@Binding private var searchedText: String
	@FocusState private var isFocused: Bool

	// MARK: - Init

	public init(
		placeholder: String = "Search",
		searchedText: Binding<String>
	) {
		self.placeholderText = placeholder
		self._searchedText = searchedText
	}

	// MARK: - Body

	public var body: some View {
		HStack(spacing: isFocused ? Padding.medium : .zero) {
			textField()
				.overlay {
					HStack {
						magnifyingGlassImage()
						Spacer()
						circleRoundedButton()
					}
				}
				.animation(.easeInOut, value: isFocused)
			VStack {
				if isFocused {
					cancelButton()
				}
			}
			.animation(.easeInOut, value: isFocused)
		}
	}

	// MARK: - Private methods

	private func textFieldPlaceholder() -> Text {
		Text(placeholderText)
			.font(.system(size: 17, weight: .regular))
			.foregroundColor(tintColor.opacity(0.5)) // TODO: - Обновить цвет позже
	}

	private func textField() -> some View {
		TextField("", text: $searchedText, prompt: textFieldPlaceholder())
			.focused($isFocused)
			.font(.system(size: 17, weight: .regular))
			.foregroundStyle(tintColor)
			.submitLabel(.search)
			.padding(.leading, Padding.giant)
			.padding(.trailing, searchedText.isEmpty ? Padding.large : Constants.textTrailingPadding)
			.autocorrectionDisabled()
			.frame(maxHeight: .infinity)
			.background(backgroundColor)
			.clipShape(RoundedRectangle(cornerRadius: Constants.cornerRadius))
	}

	private func magnifyingGlassImage() -> some View {
		Image(systemName: "magnifyingglass")
			.resizable()
			.aspectRatio(contentMode: .fit)
			.frame(width: Constants.glassImageSize.width, height: Constants.glassImageSize.height)
			.foregroundStyle(tintColor)
			.padding(.leading, Padding.small)
	}

	private func circleRoundedButton() -> some View {
		Button(
			action: {
				searchedText = ""
			},
			label: {
				Image(systemName: "xmark.circle.fill")
					.resizable()
					.frame(width: Constants.circleImageSize.width, height: Constants.circleImageSize.height)
					.aspectRatio(contentMode: .fit)
					.foregroundStyle(tintColor)
					.opacity(searchedText.isEmpty ? 0 : 1)
					.scaleEffect(searchedText.isEmpty ? 0.8 : 1)
			}
		)
		.padding(.trailing, Padding.extraSmall)
		.animation(.easeInOut, value: searchedText.isEmpty)
		.disabled(searchedText.isEmpty)
	}

	private func cancelButton() -> some View {
		Button(
			action: {
				withAnimation {
					searchedText = ""
					isFocused = false
				}
			},
			label: {
				Text("cancelAction")
					.foregroundStyle(tintColor)
					.font(.system(size: 17, weight: .regular))
			}
		)
		.transition(.move(edge: .trailing))
	}
}
