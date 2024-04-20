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
		makeCategoryModule()
	]
)


// MARK: - Module

func makeCategoryModule() -> Module {
	Module(
		name: "Category",
		path: "Category",
		exampleAppDependencies: [],
		frameworkDependencies: [],
		apiDependencies: [],
		exampleResources: [],
		frameworkResources: [],
		testResources: []
	)
}
