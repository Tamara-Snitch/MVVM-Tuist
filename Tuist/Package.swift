// swift-tools-version: 5.9
import PackageDescription

let package = Package(
	name: "Package",
	dependencies: ExternalDependency.allCases.map(\.externalDependency)
)

// MARK: - ExternalDependency

fileprivate enum ExternalDependency: CaseIterable {
	case composableArchitecture
}

// MARK: Private Properties

fileprivate extension ExternalDependency {
	/// Описание внешней зависимости в формате Package.Dependency
	var externalDependency: Package.Dependency {
		let dependency: Package.Dependency
		switch versionRequirement {
		case .from(let version):
			dependency = .package(url: stringURL, from: version)
		case .range(let versions):
			dependency = .package(url: stringURL, versions)
		case .exact(let version):
			dependency = .package(url: stringURL, exact: version)
		case .branch(let branchName):
			dependency = .package(url: stringURL, branch: branchName)
		}
		return dependency
	}

	/// Название  зависимости
	var name: String {
		let name: String
		switch self {
		case .composableArchitecture:
			name = "ComposableArchitecture"
		}
		return name
	}

	/// URL к репозиторию
	var stringURL: String {
		let url: String
		switch self {
		case .composableArchitecture:
			url = "https://github.com/pointfreeco/swift-composable-architecture"
		}
		return url
	}

	/// Требование к версии зависимости
	var versionRequirement: VersionRequirement {
		let requirement: VersionRequirement
		switch self {
		case .composableArchitecture:
			requirement = .exact("1.9.3")
		}
		return requirement
	}
}

// MARK: - VersionRequirement

fileprivate extension ExternalDependency {
	enum VersionRequirement {
		case from(Version)
		case exact(Version)
		case range(Range<Version>)
		case branch(String)
	}
}
