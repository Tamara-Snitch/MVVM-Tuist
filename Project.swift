import ProjectDescription
import ProjectDescriptionHelpers

// MARK: - Project

// Создание проекта
let project = Project.app(
	name: Constants.projectName,
	organizationName: Constants.organizationName,
	developmentTeam: Constants.developmentTeam,
	appVersion: Constants.appVersion,
	appVersionBuild: Constants.appVersionBuild.description,
	destinations: Constants.destinations,
	deploymentTargets: Constants.deploymentTargets,
	externalDependencies: [
		.external(name: "DITranquillity")
	],
	scripts: [.swiftLint],
	targetDependencies: [],
	moduleTargets: [
		makeNetworkingKitModule(),
		makeCommonModule(),
		makeMockServicesModule(),
		makeUserDefaultsServiceModule(),
		makeThemeManagerModule(),
		makeUIComponentsModule(),
		makeCharactersModule()
	]
)

// MARK: - Module

func makeNetworkingKitModule() -> Module {
	Module(
		name: "NetworkingKit",
		path: "NetworkingKit",
		exampleAppDependencies: [],
		frameworkDependencies: [
			.external(name: "DITranquillity")
		],
		apiDependencies: [],
		testingDependencies: [
			.target(name: "MockServices")
		],
		targetsWithResources: [.testing],
		targets: [
			.api,
			.framework,
			.testing,
			.unitTests
		]
	)
}

func makeCommonModule() -> Module {
	Module(
		name: "Common",
		path: "Common",
		exampleAppDependencies: [],
		frameworkDependencies: [],
		apiDependencies: [],
		targets: [.api]
	)
}

func makeMockServicesModule() -> Module {
	Module(
		name: "MockServices",
		path: "MockServices",
		exampleAppDependencies: [],
		frameworkDependencies: [
			.target(name: "NetworkingKitAPI"),
			.target(name: "ThemeManagerAPI"),
			.target(name: "CharactersAPI")
		],
		apiDependencies: [],
		targets: [.framework]
	)
}

func makeUserDefaultsServiceModule() -> Module {
	Module(
		name: "UserDefaultsService",
		path: "UserDefaultsService",
		exampleAppDependencies: [],
		frameworkDependencies: [
			.external(name: "DITranquillity")
		],
		apiDependencies: [],
		targets: [.api, .framework]
	)
}

func makeThemeManagerModule() -> Module {
	Module(
		name: "ThemeManager",
		path: "ThemeManager",
		exampleAppDependencies: [],
		frameworkDependencies: [
			.external(name: "DITranquillity")
		],
		apiDependencies: [
			.target(name: "Common"),
			.target(name: "UserDefaultsServiceAPI")
		],
		testingDependencies: [
			.target(name: "MockServices")
		],
		targets: [.api, .framework, .testing, .unitTests]
	)
}

func makeUIComponentsModule() -> Module {
	Module(
		name: "UIComponents",
		path: "UIComponents",
		exampleAppDependencies: [],
		frameworkDependencies: [
			.external(name: "NukeUI")
		],
		apiDependencies: [],
		targets: [
			.uiTests,
			.testing,
			.framework,
			.api
		]
	)
}

func makeCharactersModule() -> Module {
	Module(
		name: "Characters",
		path: "Characters",
		exampleAppDependencies: [
			.target(name: "NetworkingKit"),
			.target(name: "NetworkingKitTesting")
		],
		frameworkDependencies: [
			.target(name: "UIComponents"),
			.external(name: "DITranquillity")
		],
		apiDependencies: [
			.target(name: "NetworkingKitAPI"),
			.target(name: "Common")
		],
		testingDependencies: [
			.target(name: "MockServices")
		],
		targetsWithResources: [.exampleApp, .testing]
	)
}
