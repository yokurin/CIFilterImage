//
//  Filter.swift
//  CIFilterImage
//
//  Created by Tsubasa Hayashi on 2019/03/29.
//  Copyright © 2019 Tsubasa Hayashi. All rights reserved.
//

// More filters: https://developer.apple.com/library/archive/documentation/GraphicsImaging/Reference/CoreImageFilterReference/index.html

import UIKit
import CoreImage

public struct Filter {
    let name: String
    let ciFilterName: String?

    public init(name: String, ciFilterName: String?) {
        self.name = name
        self.ciFilterName = ciFilterName
    }
}

extension Filter: Equatable {
    public static func ==(lhs: Filter, rhs: Filter) -> Bool {
        return lhs.name == rhs.name
    }
}

extension Filter {
    static var all: [Filter] = [
        Filter(name: "Normal", ciFilterName: nil),
        Filter(name: "Chrome", ciFilterName: "CIPhotoEffectChrome"),
        Filter(name: "Fade", ciFilterName: "CIPhotoEffectFade"),
        Filter(name: "Instant", ciFilterName: "CIPhotoEffectInstant"),
        Filter(name: "Mono", ciFilterName: "CIPhotoEffectMono"),
        Filter(name: "Noir", ciFilterName: "CIPhotoEffectNoir"),
        Filter(name: "Process", ciFilterName: "CIPhotoEffectProcess"),
        Filter(name: "Tonal", ciFilterName: "CIPhotoEffectTonal"),
        Filter(name: "Transfer", ciFilterName: "CIPhotoEffectTransfer"),
        Filter(name: "Tone", ciFilterName: "CILinearToSRGBToneCurve"),
        Filter(name: "Linear", ciFilterName: "CISRGBToneCurveToLinear"),
        Filter(name: "Sepia", ciFilterName: "CISepiaTone"),
    ]
}

