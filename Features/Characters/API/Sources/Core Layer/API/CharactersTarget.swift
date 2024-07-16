//
//  CharactersTarget.swift
//  NetworkingKit
//
//  Created by Prokoptsov on 30.04.2024.
//  Copyright © 2024 TamaraSnitch. All rights reserved.
//

import Foundation
import Common
import NetworkingKitAPI

public enum CharactersTarget: ITargetProvidable {
	case getCharacters(
		baseURL: String,
		request: GetAllCharactersRequest
	)
}

extension CharactersTarget {
	public var baseURL: String {
		switch self {
		case .getCharacters(let baseURL, _):
			return baseURL
		}
	}

	public var path: String {
		switch self {
		case .getCharacters:
			return "/api/character/"
		}
	}

	public var method: APIMethod {
		switch self {
		case .getCharacters:
			return .get
		}
	}

	public var queryItems: [String: Any]? {
		switch self {
		case .getCharacters(_, let request):
			return request.toDictionary
		}
	}

	public var body: [String: Any]? {
		switch self {
		case .getCharacters:
			return nil
		}
	}
}
