//
// CategoryTestingMock.swift
// Category
//
//  Created by Kirill Prokoptsov on 19.04.2024.
//  Copyright © 2024 TamaraSnitch. All rights reserved.
//

import CategoryAPI

public struct CategoryTestableMockModel: CategoryITestable {
	public func makeTest() -> String {
		"makeMockTest"
	}
}
