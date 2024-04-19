import ProjectDescription

public extension Project {
	/// Вспомогательный метод для создания экземпляра Project
	/// - Parameters:
	///  - name: Название проекта
	///  - organizationName: Название организации
	///  - developmentTeam: Название команды разработки
	///  - appVersion: Актуальная версия проекта
	///  - appVersionBuild: Актуальная версия билда
	///  - destinations: Целевые платформы
	///  - deploymentTargets: Минимальные версии целевых платформ
	///  - externalDependencies: Внешние зависимости(Передаются только названия)
	///  - targetDependencies: Внутренние зависимости(Модули/таргеты проекта)
	///  - moduleTargets: Модули проекта
	/// - Returns: Сконфигурированный проект типа Project
	static func app(
		name: String,
		organizationName: String,
		developmentTeam: String,
		appVersion: String,
		appVersionBuild: String,
		destinations: Destinations,
		deploymentTargets: DeploymentTargets?,
		externalDependencies: [String],
		targetDependencies: [TargetDependency],
		moduleTargets: [Module]
	) -> Project {
		var dependencies = moduleTargets.map { TargetDependency.target(name: $0.name) }
		dependencies.append(contentsOf: targetDependencies)

		let externalTargetDependencies = externalDependencies.map {
			TargetDependency.external(name: $0)
		}
		dependencies.append(contentsOf: externalTargetDependencies)

		var targets = makeAppTargets(
			name: name,
			destinations: destinations,
			deploymentTargets: deploymentTargets,
			dependencies: dependencies
		)

		targets += moduleTargets.flatMap({
			makeFrameworkTargets(
				module: $0,
				destinations: .iOS,
				deploymentTargets: deploymentTargets
			)
		})

		return Project(
			name: name,
			organizationName: organizationName,
			settings: makeSettings(
				developmentTeam: developmentTeam,
				appVersion: appVersion,
				appVersionBuild: appVersionBuild
			),
			targets: targets,
			schemes: []
		)
	}
}

private extension Project {
	/// Вспомогательный метод для создания основных таргетов приложения
	/// - Parameters:
	///  - name: Название таргета
	///  - destinations: Целевые платформы
	///  - deploymentTargets: Минимальные версии целевых платформ
	///  - dependencies: Зависимости: внутренние и внешние
	/// - Returns: Сконфигурированные основные таргеты проекта
	private static func makeAppTargets(
		name: String,
		destinations: Destinations,
		deploymentTargets: DeploymentTargets?,
		dependencies: [TargetDependency]
	) -> [Target] {
		let mainTarget: Target = .target(
			name: name,
			destinations: .iOS,
			product: .app,
			bundleId: Constants.appBundleId,
			deploymentTargets: deploymentTargets,
			infoPlist: "\(name)/Configs/\(Constants.projectName)-Info.plist",
			sources: ["\(name)/Sources/**"],
			resources: ["\(name)/Resources/**"],
//			scripts: [
//				.post(
//					path: "scripts/swiftlint.sh",
//					arguments: [
//						"$SRCROOT",
//						"$TARGETNAME"
//					],
//					name: "SwiftLint"
//				)
//			],
			dependencies: dependencies
		)

		return [mainTarget]
	}

	/// Вспомогательный метод для создания таргетов модуля
	/// - Parameters:
	///  - module: Модель, создаваемого модуля
	///  - destinations: Целевые платформы
	///  - deploymentTargets: Минимальные версии целевых платформ
	/// - Returns: Таргеты модуля согласно uFeature-архитектуре
	static func makeFrameworkTargets(
		module: Module,
		destinations: Destinations,
		deploymentTargets: DeploymentTargets?
	) -> [Target] {
		let frameworkPath = "\(Constants.featuresPath)/\(module.path)"

		let targets = module.targets.map { uFeatureTarget in
			let target: Target
			switch uFeatureTarget {
			case .exampleApp:
				target = .target(
					name: "\(module.name)ExampleApp",
					destinations: destinations,
					product: .app,
					bundleId: "\(Constants.appBundleId).\(module.name)ExampleApp",
					deploymentTargets: deploymentTargets,
					infoPlist: "\(frameworkPath)/Example/Configs/\(module.name)ExampleApp-Info.plist",
					sources: ["\(Constants.featuresPath)/\(module.path)/Example/Sources/**"],
					dependencies: [.target(name: module.name), .target(name: "\(module.name)Testing")]
				)
			case .unitTests:
				target = .target(
					name: "\(module.name)UnitTests",
					destinations: destinations,
					product: .unitTests,
					bundleId: "\(Constants.appBundleId).\(module.name)UnitTests",
					deploymentTargets: nil,
					infoPlist: "\(frameworkPath)/Tests/UnitTests/Configs/\(module.name)UnitTests-Info.plist",
					sources: ["\(frameworkPath)/Tests/UnitTests/**"],
					dependencies: [.target(name: module.name), .target(name: "\(module.name)Testing")]
				)
			case .uiTests:
				target = .target(
					name: "\(module.name)UITests",
					destinations: destinations,
					product: .uiTests,
					bundleId: "\(Constants.appBundleId).\(module.name)UITests",
					deploymentTargets: nil,
					infoPlist: "\(frameworkPath)/Tests/UITests/Configs/\(module.name)UITests-Info.plist",
					sources: ["\(frameworkPath)/Tests/UITests/**"],
					dependencies: [.target(name: module.name), .target(name: "\(module.name)Testing")]
				)
			case .testing:
				target = .target(
					name: "\(module.name)Testing",
					destinations: destinations,
					product: .framework,
					bundleId: "\(Constants.appBundleId).\(module.name)Testing",
					deploymentTargets: deploymentTargets,
					infoPlist: "\(frameworkPath)/Testing/Configs/\(module.name)Testing-Info.plist",
					sources: ["\(frameworkPath)/Testing/Sources/**"],
					dependencies: [.target(name: "\(module.name)API")]
				)
			case .framework:
				target = .target(
					name: module.name,
					destinations: destinations,
					product: .framework,
					bundleId: "\(Constants.appBundleId).\(module.name)",
					deploymentTargets: deploymentTargets,
					infoPlist: "\(frameworkPath)/Configs/\(module.name)-Info.plist",
					sources: ["\(frameworkPath)/Sources/**"],
					dependencies: module.frameworkDependencies + [.target(name: "\(module.name)API")]
				)
			case .api:
				target = .target(
					name: "\(module.name)API",
					destinations: destinations,
					product: .framework,
					bundleId: "\(Constants.appBundleId).\(module.name)API",
					deploymentTargets: deploymentTargets,
					infoPlist: "\(frameworkPath)/API/Configs/\(module.name)API-Info.plist",
					sources: ["\(frameworkPath)/API/Sources/**"],
					dependencies: module.frameworkDependencies
				)
			}
			return target
		}
		return targets
	}

	/// Вспомогательный метод для создания настроек проекта
	/// - Parameters:
	///  - developmentTeam: Название команды разработки
	///  - appVersion: Актуальная версия проекта
	///  - appVersionBuild: Актуальная версия билда
	/// - Returns: Сконфигуриованные настройке типа Settings
	static func makeSettings(
		developmentTeam: String,
		appVersion: String,
		appVersionBuild: String
	) -> Settings {
		.settings(
			base: [
				"DEVELOPMENT_TEAM": "\(developmentTeam)",
				"MARKETING_VERSION": "\(appVersion)",
				"CURRENT_PROJECT_VERSION": "\(appVersionBuild)"
			],
			configurations: [
				.debug(name: .debug),
				.release(name: .release)
			]
		)
	}
}
