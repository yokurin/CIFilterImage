//
//  CIFilterViewController.swift
//  CIFilterImage
//
//  Created by Tsubasa Hayashi on 2019/03/29.
//  Copyright © 2019 Tsubasa Hayashi. All rights reserved.
//

import UIKit

public protocol CIFilterViewControllerDelegate {
    func didFinish(_ image: UIImage)
    func didCancel()
}

open class CIFilterViewController: UIViewController {

    public var delegate: CIFilterViewControllerDelegate?

    public var image: UIImage!
    public var backgroundColor: UIColor = .black
    public var textColor: UIColor = .white

    private var imageView = UIImageView(frame: CGRect.zero)
    private var collectionView: UICollectionView!
    private var cancelButton = UIButton(type: .custom)
    private var doneButton = UIButton(type: .custom)

    private var selectedFilterIndex = 0
    private var smallImage = UIImage()

    override open func viewDidLoad() {
        super.viewDidLoad()
        configureLayout()
    }

    private func configureLayout() {
        view.backgroundColor = backgroundColor

        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = CGSize(width: 100, height: 144)
        flowLayout.minimumLineSpacing = 12
        flowLayout.minimumInteritemSpacing = 12
        flowLayout.sectionInset = UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 12)
        flowLayout.scrollDirection = .horizontal
        collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: flowLayout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .clear
        view.addSubview(collectionView)
        collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        collectionView.heightAnchor.constraint(equalToConstant: 144).isActive = true
        collectionView.register(UINib(nibName: "CIFilterCollectionViewCell", bundle: Bundle(for: self.classForCoder)), forCellWithReuseIdentifier: "CIFilterCollectionViewCell")
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.showsHorizontalScrollIndicator = false

        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .clear
        imageView.isUserInteractionEnabled = true
        imageView.contentMode = .scaleAspectFill
        imageView.image = image
        view.addSubview(imageView)
        let imageTop = imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor)
        imageTop.constant = 50
        imageTop.isActive = true
        imageView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        imageView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        imageView.bottomAnchor.constraint(equalTo: collectionView.topAnchor).isActive = true
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(didSwipeLeft))
        swipeLeft.direction = .left
        imageView.addGestureRecognizer(swipeLeft)
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(didSwipeRight))
        swipeRight.direction = .right
        imageView.addGestureRecognizer(swipeRight)

        cancelButton.setTitle("Cancel", for: .normal)
        cancelButton.setTitleColor(textColor, for: .normal)
        cancelButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(cancelButton)
        let cancelTop = cancelButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor)
        cancelTop.constant = 8
        cancelTop.isActive = true
        let cancelLeading = cancelButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor)
        cancelLeading.constant = 20
        cancelLeading.isActive = true
        cancelButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(cancelButtonTapped)))

        doneButton.setTitle("Done", for: .normal)
        doneButton.setTitleColor(textColor, for: .normal)
        doneButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(doneButton)
        let doneTop = doneButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor)
        doneTop.constant = 8
        doneTop.isActive = true
        let doneTrailing = doneButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        doneTrailing.constant = -20
        doneTrailing.isActive = true
        doneButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(doneButtontapped)))

        smallImage = UIImage.resize(with: image, ratio: 0.2)
    }

    @objc private func cancelButtonTapped() {
        delegate?.didCancel()
        dismiss(animated: true, completion: nil)
    }

    @objc private func doneButtontapped() {
        delegate?.didFinish(imageView.image!)
        dismiss(animated: true, completion: nil)
    }

    @objc private func didSwipeLeft() {
        if selectedFilterIndex == Filter.all.count - 1 {
            selectedFilterIndex = 0
            imageView.image = image
        } else {
            selectedFilterIndex += 1
        }
        if selectedFilterIndex != 0 {
            applyFilterImageView()
        }
        collectionView.reloadData()
        scrollTo(index: selectedFilterIndex)
    }

    @objc private func didSwipeRight() {
        if selectedFilterIndex == 0 {
            selectedFilterIndex = Filter.all.count - 1
        } else {
            selectedFilterIndex -= 1
        }
        if selectedFilterIndex != 0 {
            applyFilterImageView()
        } else {
            imageView.image = image
        }
        collectionView.reloadData()
        scrollTo(index: selectedFilterIndex)
    }

    private func applyFilterImageView() {
        let filter = Filter.all[selectedFilterIndex]
        DispatchQueue.global().async { [weak self] in
            let filterd = CIFilterService.shared.applyFilter(with: self?.image ?? UIImage(), filter: filter)
            DispatchQueue.main.async {
                self?.imageView.image = filterd
            }
        }
    }

}

extension CIFilterViewController: UICollectionViewDataSource, UICollectionViewDelegate
{
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CIFilterCollectionViewCell", for: indexPath) as! CIFilterCollectionViewCell
        let filter = Filter.all[indexPath.row]
        let isSelected = indexPath.row == selectedFilterIndex
        cell.configure(filter: filter, textColor: textColor, isSelected: isSelected)
        DispatchQueue.global().async { [weak self, weak cell] in
            var filteredImage = self?.smallImage
            filteredImage = CIFilterService.shared.applyFilter(with: filteredImage!, filter: filter)
            DispatchQueue.main.async {
                cell?.setImage(with: filteredImage)
            }
        }
        return cell
    }

    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Filter.all.count
    }

    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedFilterIndex = indexPath.row
        applyFilterImageView()
        scrollTo(index: indexPath.item)
        collectionView.reloadData()
    }
    func scrollTo(index: Int) {
        let indexPath = IndexPath(item: index, section: 0)
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
}
