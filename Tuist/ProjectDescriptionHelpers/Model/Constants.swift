import ProjectDescription

/// Константы, используемые для описания проекта
public enum Constants {
	/// Название проекта
	public static let projectName: String = "MVVM-Tuist"
	/// Название команды разработки
	public static let developmentTeam: String = "TamaraSnitch"
	/// Название организации
	public static let organizationName = "TamaraSnitch"
	/// Название бандла приложения
	public static let appBundleId = "com.\(organizationName).\(projectName)"
	/// Минимальная версия iOS
	public static let iOSTargetVersion = "16.0"
	/// Текущая версия приложения
	public static let appVersion = "1.0.0"
	/// Текущая версия билда
	public static let appVersionBuild = 1
	/// Относительный путь к модулям-фичам приложения
	public static let featuresPath: String = "Features"
	/// Минимальные версии целевых платформ
	public static let deploymentTargets: DeploymentTargets = .iOS(Constants.iOSTargetVersion)
	/// Целевые платформы
	public static let destinations: Destinations = [.iPhone]
}
