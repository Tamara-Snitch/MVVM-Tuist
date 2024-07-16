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
	//	static let swiftLint: TargetScript = .pre(
	//		script:
	// """
	// if which swiftlint >/dev/null; then
	// swiftlint lint --config .swiftlint.yml
	// else
	// echo "warning: SwiftLint not installed, download from https://github.com/realm/SwiftLint"
	// fi
	// """,
	//		name: "SwiftLint"
	//	)
}
