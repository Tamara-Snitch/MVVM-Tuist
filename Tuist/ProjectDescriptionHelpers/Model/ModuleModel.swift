import ProjectDescription

public struct Module {
	public let name: String
	public let path: String
	public let exampleAppDependencies: [TargetDependency]
	public let frameworkDependencies: [TargetDependency]
	public let apiDependencies: [TargetDependency]
	public let exampleResources: [String]
	public let frameworkResources: [String]
	public let testResources: [String]
	public let targets: Set<FeatureTarget>

	/// Инициализатор модели Модуля
	/// - Parameters:
	///  - name: Название модуля
	///  - path: Относительный путь модуля(Относительно директории 'Features'
	///  - exampleAppDependencies: Зависимости таргета 'Example'
	///  - frameworkDependencies: Зависимости  таргета 'Framework''
	///  - apiDependencies: Зависимости таргета 'API'
	///  - exampleResources: ВРЕМЕННО НЕ ИСПОЛЬЗУЕТСЯ: Ресурсы таргета 'Example'
	///  - frameworkResources: ВРЕМЕННО НЕ ИСПОЛЬЗУЕТСЯ: Ресурсы таргета 'Framework'
	///  - testResources: ВРЕМЕННО НЕ ИСПОЛЬЗУЕТСЯ: Ресурсы для таргетов 'UnitTests' и 'UITests'
	///  - targets: Необходимые для модуля таргеты, по умолчанию создаются все согласно uFeature-архитектуре
	/// - Returns: Сконфигурированный модуль типа Module
	public init(
		name: String,
		path: String,
		exampleAppDependencies: [TargetDependency],
		frameworkDependencies: [TargetDependency],
		apiDependencies: [TargetDependency],
		exampleResources: [String],
		frameworkResources: [String],
		testResources: [String],
		targets: Set<FeatureTarget> = Set(FeatureTarget.allCases)
	) {
		self.name = name
		self.path = path
		self.exampleAppDependencies = exampleAppDependencies
		self.frameworkDependencies = frameworkDependencies
		self.apiDependencies = apiDependencies
		self.exampleResources = exampleResources
		self.frameworkResources = frameworkResources
		self.testResources = testResources
		self.targets = targets
	}
}
