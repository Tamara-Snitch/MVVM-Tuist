//
//  TypographyAPI.swift
//  ThemeManagerAPI
//
//  Created by Prokoptsov on 14.08.2024.
//  Copyright © 2024 TamaraSnitch. All rights reserved.
//

import SwiftUI

public protocol TypographyAPI: Equatable {
	var titleFont: Font { get }
	var textFont: Font { get }
}
