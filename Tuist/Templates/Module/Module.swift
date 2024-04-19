import Foundation
import ProjectDescription
import ProjectDescriptionHelpers

let nameAttribute: Template.Attribute = .required("name")
let authorAttribute: Template.Attribute = .optional("author", default: .string("Kirill Prokoptsov"))
let dateAttribute: Template.Attribute = .optional("date", default: .string(makeDefaultDateString()))
let yearAttribute: Template.Attribute = .optional("year", default: .string(makeDefaultYearString()))
let companyAttribute: Template.Attribute = .optional("company", default: .string(Constants.developmentTeam))

let template = Template(
	description: "Module template",
	attributes: [
		nameAttribute,
		authorAttribute,
		dateAttribute,
		yearAttribute,
		companyAttribute
	],
	items: makeTemplateItems()
)

fileprivate func makeDefaultDateString() -> String {
	let formatter = DateFormatter()
	formatter.dateFormat = "dd.MM.yyyy"
	return formatter.string(from: .init())
}

fileprivate func makeDefaultYearString() -> String {
	let formatter = DateFormatter()
	formatter.dateFormat = "yyyy"
	return formatter.string(from: .init())
}

fileprivate func makeTemplateItems() -> [Template.Item] {
	[
		// Генерация файлов Example-таргета
		.file(
			path: "\(Constants.featuresPath)/\(nameAttribute)/Example/Sources/\(nameAttribute)App.swift",
			templatePath: "App.stencil"
		),
		.file(
			path: "\(Constants.featuresPath)/\(nameAttribute)/Example/Configs/\(nameAttribute)ExampleApp-Info.plist",
			templatePath: "AppInfoPlist.stencil"
		),
		// Генерация файлов UnitTests-таргета
		.file(
			path: "\(Constants.featuresPath)/\(nameAttribute)/Tests/UnitTests/Sources/\(nameAttribute)UnitTests.swift",
			templatePath: "UnitTests.stencil"
		),
		.file(
			path: "\(Constants.featuresPath)/\(nameAttribute)/Tests/UnitTests/Configs/\(nameAttribute)UnitTests-Info.plist",
			templatePath: "DefaultInfoPlist.stencil"
		),
		// Генерация файлов UITests-таргета
		.file(
			path: "\(Constants.featuresPath)/\(nameAttribute)/Tests/UITests/Sources/\(nameAttribute)UITests.swift",
			templatePath: "UITests.stencil"
		),
		.file(
			path: "\(Constants.featuresPath)/\(nameAttribute)/Tests/UITests/Configs/\(nameAttribute)UITests-Info.plist",
			templatePath: "DefaultInfoPlist.stencil"
		),
		// Генерация файлов Testing-таргета
		.file(
			path: "\(Constants.featuresPath)/\(nameAttribute)/Testing/Sources/\(nameAttribute)Testing.swift",
			templatePath: "Testing.stencil"
		),
		.file(
			path: "\(Constants.featuresPath)/\(nameAttribute)/Testing/Configs/\(nameAttribute)Testing-Info.plist",
			templatePath: "DefaultInfoPlist.stencil"
		),
		// Генерация файлов Framework-таргета
		.file(
			path: "\(Constants.featuresPath)/\(nameAttribute)/Sources/\(nameAttribute)Feature.swift",
			templatePath: "Feature.stencil"
		),
		.file(
			path: "\(Constants.featuresPath)/\(nameAttribute)/Configs/\(nameAttribute)-Info.plist",
			templatePath: "DefaultInfoPlist.stencil"
		),
		// Генерация файлов API-таргета
		.file(
			path: "\(Constants.featuresPath)/\(nameAttribute)/API/Sources/\(nameAttribute)API.swift",
			templatePath: "API.stencil"
		),
		.file(
			path: "\(Constants.featuresPath)/\(nameAttribute)/API/Configs/\(nameAttribute)API-Info.plist",
			templatePath: "DefaultInfoPlist.stencil"
		),
	]
}
