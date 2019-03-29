//
//  ViewController.swift
//  CIFilterImage-Example
//
//  Created by Tsubasa Hayashi on 2019/03/29.
//  Copyright © 2019 Tsubasa Hayashi. All rights reserved.
//

import UIKit
import CIFilterImage

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 100, height: 30))
        button.center = view.center
        button.setTitle("ShowFilter", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(buttonTapped)))
        view.addSubview(button)
    }

    @objc func buttonTapped(_ sender: Any) {
        let vc = CIFilterViewController()
        vc.image = UIImage(named: "sample")
        vc.backgroundColor = .white
        vc.textColor = .black
        vc.delegate = self
        present(vc, animated: true, completion: nil)
    }
}

extension ViewController: CIFilterViewControllerDelegate {
    func didFilter(_ image: UIImage) {
        print("image", image)
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFit
        imageView.frame = CGRect(x: 0, y: 60, width: 200, height: 200)
        imageView.center.x = view.center.x
        view.addSubview(imageView)
    }

    func didCancel() {
        print("did Cancel")
    }
}

