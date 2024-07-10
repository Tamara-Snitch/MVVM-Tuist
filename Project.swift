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
		"DITranquillity"
	],
	targetDependencies: [],
	moduleTargets: [
		makeNetworkingKitModule(),
		makeCommonModule(),
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
			.external(name:"DITranquillity")
		],
		apiDependencies: [],
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
			.target(name: "NetworkingKit")
		],
		frameworkDependencies: [
			.target(name: "UIComponents"),
			.external(name:"DITranquillity")
		],
		apiDependencies: [
			.target(name: "NetworkingKitAPI"),
			.target(name: "Common"),
		],
		isExampleTargetNeedsResources: true
	)
}
