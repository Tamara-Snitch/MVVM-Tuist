//
//  IAPIRequestable.swift
//  NetworkingKitAPI
//
//  Created by Prokoptsov on 30.04.2024.
//  Copyright © 2024 TamaraSnitch. All rights reserved.
//

// MARK: - IAPIRequestable

public protocol IAPIRequestable {
	func request<T: Decodable>(target: ITargetProvidable, response: T.Type) async throws -> T
}
