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
		makeCommonModule(),
		makeUIComponentsModule(),
		makeCategoryModule()
	]
)

// MARK: - Module

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
		targets: [.framework]
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

func makeCategoryModule() -> Module {
	Module(
		name: "Category",
		path: "Category",
		exampleAppDependencies: [],
		frameworkDependencies: [
			.target(name: "Common"),
			.target(name: "UIComponents"),
			.external(name: "ComposableArchitecture")
		],
		apiDependencies: [],
		exampleResources: [],
		frameworkResources: [],
		testResources: []
	)
}
