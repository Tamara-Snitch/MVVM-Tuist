//
//  GetCharactersUseCasePart.swift
//  Characters
//
//  Created by Prokoptsov on 24.06.2024.
//  Copyright © 2024 TamaraSnitch. All rights reserved.
//

import CharactersAPI
import DITranquillity

final class GetCharactersUseCasePart: DIPart {
	static func load(container: DIContainer) {
		container.register { GetCharactersRemoteDataSource(baseURL: arg($0), apiClient: $1) }
			.as(GetCharactersDataSourceAPI.self)

		container.register { GetCharactersRepository(remoteDataSource: $0) }
			.as(GetCharactersRepositoryAPI.self)
		
		container.register { GetCharactersUseCase(repository: $0) }
			.as(GetCharactersUseCaseAPI.self)
	}
}
