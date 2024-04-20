//
// CategoryTestableModel.swift
// Category
//
//  Created by Kirill Prokoptsov on 20.04.2024.
//  Copyright © 2024 TamaraSnitch. All rights reserved.
//

import CategoryAPI

public struct CategoryTestableModel: ICategoryTestable {
	public func makeTest() -> String {
		// Какая-то логика
		return "makeTest"
	}
}
