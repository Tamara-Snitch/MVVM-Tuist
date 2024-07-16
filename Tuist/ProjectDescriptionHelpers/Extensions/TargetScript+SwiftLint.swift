//
//  TargetScript+SwiftLint.swift
//  ProjectDescriptionHelpers
//
//  Created by Prokoptsov on 16.07.2024.
//

import ProjectDescription

public extension TargetScript {
	static let swiftLint: TargetScript = .pre(
		path: "scripts/swiftlint.sh",
		arguments: ["$SRCROOT", "$TARGETNAME"],
		name: "SwiftLint",
		basedOnDependencyAnalysis: false
	)
}
