// swift-tools-version: 5.9
import PackageDescription

let package = Package(
	name: "Package",
	dependencies: ExternalDependency.allCases.map(\.externalDependency)
)

// MARK: - ExternalDependency

fileprivate enum ExternalDependency: CaseIterable {
	case DITranquillity
	case NukeUI
	case Lottie
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
		case .DITranquillity:
			name = "DITranquillity"
		case .NukeUI:
			name = "NukeUI"
		case .Lottie:
			name = "lottie"
		}
		return name
	}

	/// URL к репозиторию
	var stringURL: String {
		let url: String
		switch self {
		case .DITranquillity:
			url = "https://github.com/ivlevAstef/DITranquillity.git"
		case .NukeUI:
			url = "https://github.com/kean/Nuke.git"
		case .Lottie:
			url = "https://github.com/airbnb/lottie-spm.git"
		}
		return url
	}

	/// Требование к версии зависимости
	var versionRequirement: VersionRequirement {
		let requirement: VersionRequirement
		switch self {
		case .DITranquillity:
			requirement = .from("4.6.0")
		case .NukeUI:
			requirement = .from("12.7.3")
		case .Lottie:
			requirement = .from("4.5.0")
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
