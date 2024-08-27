//
//  MockUserDefaultsService.swift
//  MockServices
//
//  Created by Prokoptsov on 27.08.2024.
//  Copyright © 2024 TamaraSnitch. All rights reserved.
//

import Foundation
import UserDefaultsServiceAPI

public final class ThemeUserDefaultsMock: UserDefaultsServiceAPI {

	// MARK: - Public properties

	public var selectedTheme: String = ""

	// MARK: - Init

	public init() { }
}
