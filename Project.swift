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
	destinations: .iOS,
	deploymentTargets: Constants.getDeploymentTarget(),
	externalDependencies: [],
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
		frameworkDependencies: [],
		apiDependencies: [],
		exampleResources: [],
		frameworkResources: [],
		testResources: [],
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
		exampleResources: [],
		frameworkResources: [],
		testResources: [],
		targets: [.api]
	)
}

func makeUIComponentsModule() -> Module {
	Module(
		name: "UIComponents",
		path: "UIComponents",
		exampleAppDependencies: [],
		frameworkDependencies: [],
		apiDependencies: [],
		exampleResources: [],
		frameworkResources: [],
		testResources: [],
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
			.external(name: "ComposableArchitecture")
		],
		apiDependencies: [
			.target(name: "NetworkingKitAPI"),
			.target(name: "Common"),
		],
		exampleResources: [],
		frameworkResources: [],
		testResources: []
	)
}
