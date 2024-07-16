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
	///  - externalDependencies: Внешние зависимости
	///  - targetDependencies: Внутренние зависимости(Модули/таргеты проекта)
	///  - scripts: Используемые основным таргетом скрипты
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
		externalDependencies: [TargetDependency],
		scripts: [TargetScript],
		targetDependencies: [TargetDependency],
		moduleTargets: [Module]
	) -> Project {
		var dependencies = moduleTargets.map { TargetDependency.target(name: $0.name) }
		dependencies.append(contentsOf: targetDependencies)
		dependencies.append(contentsOf: externalDependencies)

		var targets = makeAppTargets(
			name: name,
			destinations: destinations,
			deploymentTargets: deploymentTargets,
			dependencies: dependencies,
			scripts: scripts
		)

		targets += moduleTargets.flatMap({
			makeFrameworkTargets(
				module: $0,
				destinations: destinations,
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
	///  - scripts: Используемые скрипты
	/// - Returns: Сконфигурированные основные таргеты проекта
	private static func makeAppTargets(
		name: String,
		destinations: Destinations,
		deploymentTargets: DeploymentTargets?,
		dependencies: [TargetDependency],
		scripts: [TargetScript]
	) -> [Target] {
		let mainTarget: Target = .target(
			name: name,
			destinations: destinations,
			product: .app,
			bundleId: Constants.appBundleId,
			deploymentTargets: deploymentTargets,
			infoPlist: "\(name)/Configs/\(Constants.projectName)-Info.plist",
			sources: ["\(name)/Sources/**"],
			resources: ["\(name)/Resources/**"],
			scripts: scripts,
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

		let frameworks = module.targets.flatMap { uFeatureTarget in
			let isResourcesNeeded = module.targetsWithResources.contains(uFeatureTarget)
			var targets: [Target]
			switch uFeatureTarget {
			case .exampleApp:
				let resourcesPath: ResourceFileElements? = isResourcesNeeded
				? ["\(frameworkPath)/Example/Resources/**"] : nil

				let dependencies = module.exampleAppDependencies
				+
				[
					.target(name: module.name),
					.target(name: "\(module.name)Testing")
				]
				targets = [
					.target(
						name: "\(module.name)ExampleApp",
						destinations: destinations,
						product: .app,
						bundleId: "\(Constants.appBundleId).\(module.name)ExampleApp",
						deploymentTargets: deploymentTargets,
						infoPlist: "\(frameworkPath)/Example/Configs/\(module.name)ExampleApp-Info.plist",
						sources: ["\(frameworkPath)/Example/Sources/**"],
						resources: resourcesPath,
						dependencies: dependencies
					)
				]
			case .unitTests:
				let resourcesPath: ResourceFileElements? = isResourcesNeeded
				? ["\(frameworkPath)/Tests/UnitTests/Resources/**"] : nil

				targets = [
					.target(
						name: "\(module.name)UnitTests",
						destinations: destinations,
						product: .unitTests,
						bundleId: "\(Constants.appBundleId).\(module.name)UnitTests",
						deploymentTargets: deploymentTargets,
						infoPlist: "\(frameworkPath)/Tests/UnitTests/Configs/\(module.name)UnitTests-Info.plist",
						sources: ["\(frameworkPath)/Tests/UnitTests/**"],
						resources: resourcesPath,
						dependencies: [.target(name: module.name), .target(name: "\(module.name)Testing")]
					)
				]
			case .uiTests:
				let resourcesPath: ResourceFileElements? = isResourcesNeeded
				? ["\(frameworkPath)/Tests/UITests/Resources/**"] : nil

				targets = [
					.target(
						name: "\(module.name)UITests",
						destinations: destinations,
						product: .uiTests,
						bundleId: "\(Constants.appBundleId).\(module.name)UITests",
						deploymentTargets: deploymentTargets,
						infoPlist: "\(frameworkPath)/Tests/UITests/Configs/\(module.name)UITests-Info.plist",
						sources: ["\(frameworkPath)/Tests/UITests/**"],
						resources: resourcesPath,
						dependencies: [.target(name: module.name), .target(name: "\(module.name)Testing")]
					)
				]
			case .testing:
				targets = [
					.target(
						name: "\(module.name)Testing",
						destinations: destinations,
						product: .staticFramework,
						bundleId: "\(Constants.appBundleId).\(module.name)Testing",
						deploymentTargets: deploymentTargets,
						infoPlist: "\(frameworkPath)/Testing/Configs/\(module.name)Testing-Info.plist",
						sources: ["\(frameworkPath)/Testing/Sources/**"],
						dependencies: [
							.target(name: "\(module.name)API"),
							isResourcesNeeded ? .target(name: "\(module.name)TestingResources") : nil
						].compactMap { $0 }
					)
				]

				if isResourcesNeeded {
					targets.append(
						.target(
							name: "\(module.name)TestingResources",
							destinations: destinations,
							product: .framework,
							bundleId: "\(Constants.appBundleId).\(module.name)TestingResources",
							deploymentTargets: deploymentTargets,
							infoPlist: "\(frameworkPath)/TestingResources/Configs/\(module.name)TestingResources-Info.plist",
							sources: ["\(frameworkPath)/TestingResources/Sources/**"],
							resources: ["\(frameworkPath)/TestingResources/Resources/**"]
						)
					)
				}
			case .framework:
				let resourcesPath: ResourceFileElements? = isResourcesNeeded
				? ["\(frameworkPath)/Resources/**"] : nil

				var dependencies = module.frameworkDependencies
				if module.targets.contains(.api) {
					dependencies.append(.target(name: "\(module.name)API"))
				}

				targets = [
					.target(
						name: module.name,
						destinations: destinations,
						product: .staticFramework,
						bundleId: "\(Constants.appBundleId).\(module.name)",
						deploymentTargets: deploymentTargets,
						infoPlist: "\(frameworkPath)/Configs/\(module.name)-Info.plist",
						sources: ["\(frameworkPath)/Sources/**"],
						resources: resourcesPath,
						dependencies: dependencies
					)
				]
			case .api:
				let moduleName = module.targets.count > 1 ? "\(module.name)API" : module.name
				targets = [
					.target(
						name: moduleName,
						destinations: destinations,
						product: .staticFramework,
						bundleId: "\(Constants.appBundleId).\(moduleName)",
						deploymentTargets: deploymentTargets,
						infoPlist: "\(frameworkPath)/API/Configs/\(moduleName)-Info.plist",
						sources: ["\(frameworkPath)/API/Sources/**"],
						dependencies: module.apiDependencies
					)
				]
			}
			return targets
		}

		return frameworks
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
