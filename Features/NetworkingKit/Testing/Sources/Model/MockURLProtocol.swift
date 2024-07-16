//
//  MockURLProtocol.swift
//  NetworkingKitTesting
//
//  Created by Prokoptsov on 09.05.2024.
//  Copyright © 2024 TamaraSnitch. All rights reserved.
//

import Foundation

final class MockURLProtocol: URLProtocol {
	
	// MARK: Static properties
	
	static var requestHandler: ((URLRequest) throws -> (HTTPURLResponse, Data))?
	
	// MARK: URLProtocol methods
	
	override static func canInit(with request: URLRequest) -> Bool {
		true
	}
	
	override static func canonicalRequest(for request: URLRequest) -> URLRequest {
		request
	}

	override func stopLoading() { }

	override func startLoading() {
		guard let handler = MockURLProtocol.requestHandler else { return }
		do {
			let (response, data) = try handler(request)
			client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
			client?.urlProtocol(self, didLoad: data)
			client?.urlProtocolDidFinishLoading(self)
		} catch {
			client?.urlProtocol(self, didFailWithError: error)
		}
	}
}
