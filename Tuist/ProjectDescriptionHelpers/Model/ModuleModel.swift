import ProjectDescription

public struct Module {
	public let name: String
	public let path: String
	public let exampleAppDependencies: [TargetDependency]
	public let frameworkDependencies: [TargetDependency]
	public let apiDependencies: [TargetDependency]
	public let isExampleTargetNeedsResources: Bool
	public let isFrameworkTargetNeedsResources: Bool
	public let isTestTargetsNeedsResources: Bool
	public let targets: Set<FeatureTarget>

	/// Инициализатор модели Модуля
	/// - Parameters:
	///  - name: Название модуля
	///  - path: Относительный путь модуля(Относительно директории 'Features'
	///  - exampleAppDependencies: Зависимости таргета 'Example'
	///  - frameworkDependencies: Зависимости  таргета 'Framework''
	///  - apiDependencies: Зависимости таргета 'API'
	///  - isExampleTargetNeedsResources: Флаг необходимости генерации директории для ресурсов таргета 'Example'
	///  - isFrameworkTargetNeedsResources: Флаг необходимости генерации директории для ресурсов таргета  'Framework'
	///  - isTestTargetsNeedsResources: Флаг необходимости генерации директории для ресурсов таргетов 'UnitTests' и 'UITests'
	///  - targets: Необходимые для модуля таргеты, по умолчанию создаются все согласно uFeature-архитектуре
	/// - Returns: Сконфигурированный модуль типа Module
	public init(
		name: String,
		path: String,
		exampleAppDependencies: [TargetDependency],
		frameworkDependencies: [TargetDependency],
		apiDependencies: [TargetDependency],
		isExampleTargetNeedsResources: Bool = false,
		isFrameworkTargetNeedsResources: Bool = false,
		isTestTargetsNeedsResources: Bool = false,
		targets: Set<FeatureTarget> = Set(FeatureTarget.allCases)
	) {
		self.name = name
		self.path = path
		self.exampleAppDependencies = exampleAppDependencies
		self.frameworkDependencies = frameworkDependencies
		self.apiDependencies = apiDependencies
		self.isExampleTargetNeedsResources = isExampleTargetNeedsResources
		self.isFrameworkTargetNeedsResources = isFrameworkTargetNeedsResources
		self.isTestTargetsNeedsResources = isTestTargetsNeedsResources
		self.targets = targets
	}
}
