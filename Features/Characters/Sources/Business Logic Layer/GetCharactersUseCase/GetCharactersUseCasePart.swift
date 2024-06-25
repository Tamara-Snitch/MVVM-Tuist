//
//  GetCharactersUseCasePart.swift
//  Characters
//
//  Created by Prokoptsov on 24.06.2024.
//  Copyright © 2024 TamaraSnitch. All rights reserved.
//

import CharactersAPI
import DITranquillity

public final class GetCharactersUseCasePart: DIPart {
	public static func load(container: DIContainer) {
		container.register(GetCharactersRemoteDataSource.init) { arg($0) }
			.as(GetCharactersDataSourceAPI.self)

		container.register { GetCharactersRepository(remoteDataSource: $0) }
			.as(GetCharactersRepositoryAPI.self)

		container.register(GetCharactersUseCase.init)
			.as(GetCharactersUseCaseAPI.self)
	}
}
