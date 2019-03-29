//
//  CIFilterService.swift
//  CIFilterImage
//
//  Created by Tsubasa Hayashi on 2019/03/29.
//  Copyright © 2019 Tsubasa Hayashi. All rights reserved.
//

import UIKit
import CoreImage

final class CIFilterService {

    static let shared: CIFilterService = .init()

    private init () {}

    private let context = CIContext(options: nil)

    func applyFilter(with image: UIImage, filter: Filter) -> UIImage {
        guard let ciFilterName = filter.ciFilterName else {
            return image
        }

        let sourceImage = CIImage(image: image)
        let filter = CIFilter(name: ciFilterName)
        filter?.setDefaults()
        filter?.setValue(sourceImage, forKey: kCIInputImageKey)
        let outputCGImage = context.createCGImage((filter?.outputImage!)!, from: (filter?.outputImage!.extent)!)
        let filteredImage = UIImage(cgImage: outputCGImage!)

        return filteredImage
    }
}

extension UIImage {
    static func resize(with image: UIImage, ratio: CGFloat = 0.2) -> UIImage {
        let resizedSize = CGSize(width: Int(image.size.width * ratio), height: Int(image.size.height * ratio))
        UIGraphicsBeginImageContext(resizedSize)
        image.draw(in: CGRect(x: 0, y: 0, width: resizedSize.width, height: resizedSize.height))
        let resizedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return resizedImage!
    }
}
