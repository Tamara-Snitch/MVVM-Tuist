//
//  AnyLotties.swift
//  ThemeManagerAPI
//
//  Created by Prokoptsov on 02.10.2024.
//  Copyright © 2024 TamaraSnitch. All rights reserved.
//

public struct AnyLotties: LottiesAPI {

	// MARK: - Public properties

	public var loaderLine: String {
		return _loaderLine()
	}

	// MARK: - Private properties

	private let _loaderLine: () -> String

	// MARK: - Init

	init<T: LottiesAPI>(_ lotties: T) {
		_loaderLine = { lotties.loaderLine }
	}
}

// MARK: - Equatable

public extension AnyLotties {
	static func == (lhs: AnyLotties, rhs: AnyLotties) -> Bool {
		return lhs.loaderLine == rhs.loaderLine
	}
}
