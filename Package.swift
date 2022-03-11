// swift-tools-version:5.5
import PackageDescription

let package = Package(
    name: "CIFilterImage",
    platforms: [
		.iOS(.v12),
    ],
    products: [
        .library(
            name: "CIFilterImage",
            targets: ["CIFilterImage"]
        ),
    ],
    targets: [
		.target(
            name: "CIFilterImage",
			path: "CIFilterImage/Sources",
			exclude: [
				"CIFilterImage.h",
			],
			resources: [
				.process("CIFilterCollectionViewCell.xib")
			]
        )
    ],
    swiftLanguageVersions: [.v5]
)
