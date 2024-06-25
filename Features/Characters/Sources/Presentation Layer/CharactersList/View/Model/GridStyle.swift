//
//  GridStyle.swift
//  Characters
//
//  Created by Prokoptsov on 21.06.2024.
//  Copyright © 2024 TamaraSnitch. All rights reserved.
//

enum GridStyle: Int, CaseIterable {
	case grid
	case list
}

extension GridStyle {
	var imageName: String {
		switch self {
		case .grid:
			return "rectangle.grid.2x2.fill"
		case .list:
			return "rectangle.grid.1x2.fill"
		}
	}
}
