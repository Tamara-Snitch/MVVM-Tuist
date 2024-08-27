import ProjectDescription

public struct Module {
	public let name: String
	public let path: String
	public let exampleAppDependencies: [TargetDependency]
	public let frameworkDependencies: [TargetDependency]
	public let apiDependencies: [TargetDependency]
	public let testingDependencies: [TargetDependency]
	public let targetsWithResources: Set<FeatureTarget>
	public let targets: Set<FeatureTarget>

	/// Инициализатор модели Модуля
	/// - Parameters:
	///  - name: Название модуля
	///  - path: Относительный путь модуля(Относительно директории 'Features'
	///  - exampleAppDependencies: Зависимости таргета 'Example'
	///  - frameworkDependencies: Зависимости  таргета 'Framework''
	///  - testingDependencies: Зависимости таргета 'Testing'
	///  - apiDependencies: Зависимости таргета 'API'
	///  - targetsWithResources: Таргеты модули, для которых необходимо генерации директории для ресурсов
	///  - targets: Необходимые для модуля таргеты, по умолчанию создаются все согласно uFeature-архитектуре
	/// - Returns: Сконфигурированный модуль типа Module
	public init(
		name: String,
		path: String,
		exampleAppDependencies: [TargetDependency],
		frameworkDependencies: [TargetDependency],
		apiDependencies: [TargetDependency],
		testingDependencies: [TargetDependency] = [],
		targetsWithResources: Set<FeatureTarget> = [],
		targets: Set<FeatureTarget> = Set(FeatureTarget.allCases)
	) {
		self.name = name
		self.path = path
		self.exampleAppDependencies = exampleAppDependencies
		self.frameworkDependencies = frameworkDependencies
		self.apiDependencies = apiDependencies
		self.testingDependencies = testingDependencies
		self.targetsWithResources = targetsWithResources
		self.targets = targets
	}
}
