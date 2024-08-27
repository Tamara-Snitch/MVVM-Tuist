//
//  CharactersFramework.swift
//  Characters
//
//  Created by Prokoptsov on 24.06.2024.
//  Copyright © 2024 TamaraSnitch. All rights reserved.
//

import CharactersAPI
import DITranquillity

public final class CharactersFramework: DIFramework {
	public static func load(container: DIContainer) {
		container.append(part: GetCharactersUseCasePart.self)

		container.register { CharactersListViewModel(getCharactersUseCase: $0, themeManager: $1) }
		
		container.register { CharactersListView(viewModel: $0, themeProvider: $1) }
			.as((any CharactersListViewAPI).self)
	}
}
