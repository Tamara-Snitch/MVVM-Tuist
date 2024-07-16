//
//  Mockable.swift
//  NetworkingKitTesting
//
//  Created by Prokoptsov on 09.05.2024.
//  Copyright © 2024 TamaraSnitch. All rights reserved.
//

import Foundation

// MARK: - Mockable

public protocol Mockable: AnyObject {
	var bundle: Bundle { get }
	func loadJSON<T: Decodable>(fileURL: URL, response: T.Type) throws -> T
}

// MARK: - Mockable extension

public extension Mockable {
	
	var bundle: Bundle {
		Bundle(for: type(of: self))
	}
	
	func loadJSON<T: Decodable>(fileURL: URL, response: T.Type) throws -> T {
		do {
			let data = try Data(contentsOf: fileURL)
			let decodedObject = try JSONDecoder().decode(response, from: data)
			
			return decodedObject
		} catch {
			throw ApiError.decodingError
		}
	}
}
