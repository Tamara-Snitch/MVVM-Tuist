//
//  isValidURL.swift
//  NetworkingKitAPI
//
//  Created by Prokoptsov on 13.07.2024.
//  Copyright © 2024 TamaraSnitch. All rights reserved.
//

import Foundation

public func isURLValid(_ url: URL) -> Bool {
	let absoluteURLString = url.absoluteString
	let types: NSTextCheckingResult.CheckingType = [.link]
	let detector = try? NSDataDetector(types: types.rawValue)
	guard let detector,
				!absoluteURLString.isEmpty else { return false }
	return detector.numberOfMatches(
		in: absoluteURLString,
		options: NSRegularExpression.MatchingOptions(rawValue: .zero),
		range: NSMakeRange(.zero, absoluteURLString.count)
	) > 0
}
