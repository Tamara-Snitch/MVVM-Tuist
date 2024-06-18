//
//  MockedURLSession.swift
//  NetworkingKitTesting
//
//  Created by Prokoptsov on 09.05.2024.
//  Copyright © 2024 TamaraSnitch. All rights reserved.
//

import Foundation

public extension URLSession {
	static let mockedSession: URLSession = {
		let sessionConfiguration = URLSessionConfiguration.ephemeral
		sessionConfiguration.protocolClasses = [MockURLProtocol.self]
		return .init(configuration: sessionConfiguration)
	}()
}
