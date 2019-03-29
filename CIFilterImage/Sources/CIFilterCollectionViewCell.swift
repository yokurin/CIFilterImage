//
//  CIFilterCollectionViewCell.swift
//  CIFilterImage
//
//  Created by Tsubasa Hayashi on 2019/03/29.
//  Copyright © 2019 Tsubasa Hayashi. All rights reserved.
//

import UIKit

class CIFilterCollectionViewCell: UICollectionViewCell {

    @IBOutlet private var filterNameLabel: UILabel!
    @IBOutlet private var imageView: UIImageView!

    override func prepareForReuse() {
        imageView.image = nil
        super.prepareForReuse()
    }

    func configure(filter: Filter, textColor: UIColor, isSelected: Bool) {
        filterNameLabel.text = filter.name
        filterNameLabel.textColor = textColor
        filterNameLabel.font = isSelected ? UIFont.boldSystemFont(ofSize: 14) : UIFont.systemFont(ofSize: 14, weight: .thin)
    }

    func setImage(with image: UIImage?) {
        imageView.image = image
    }
}
