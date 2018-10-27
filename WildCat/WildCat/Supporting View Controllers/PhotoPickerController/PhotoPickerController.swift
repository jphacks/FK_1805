//
//  PhotoPickerController.swift
//  WildCat
//
//  Created by 山浦功 on 2018/10/27.
//  Copyright © 2018 Azuma. All rights reserved.
//

import UIKit
import Photos

protocol PhotoPickerControllerDelegate {
    func didSelectPhoto(asset: PHAsset)
}

@objc(PhotoPickerController)
class PhotoPickerController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    var delegate: PhotoPickerControllerDelegate?
    private var fetchResult: PHFetchResult<PHAsset>!
    private let imageManager = PHCachingImageManager()
    @IBOutlet weak var collectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        let cellNib = UINib(nibName: "PhotoPickerCell", bundle: nil)
        self.collectionView.register(cellNib, forCellWithReuseIdentifier: "photoCell")
        self.updateAssets()
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.fetchResult.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "photoCell", for: indexPath) as! PhotoPickerCell
        let asset = self.fetchResult.object(at: indexPath.row)
        let size = CGSize(width: asset.pixelWidth, height: asset.pixelHeight)
        imageManager.requestImage(for: asset, targetSize: size, contentMode: .aspectFit, options: nil) { (image, _) in
            let image = image ?? UIImage(named: "black")!
            cell.update(image: image)
        }
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let result = self.fetchResult.object(at: indexPath.row)
        if let delegate = self.delegate {
            delegate.didSelectPhoto(asset: result)
        }
        self.dismiss(animated: true, completion: nil)
    }

    @IBAction func dismissAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}

extension PhotoPickerController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let margin: CGFloat = 2
        let width: CGFloat = (self.view.frame.width - margin * 2) / 3
        let height = width
        return CGSize(width: width, height: height)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return CGFloat(2)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return CGFloat(2)
    }
}

extension PhotoPickerController {

    fileprivate func updateAssets() {
        let fetchOptions = PHFetchOptions()
        fetchOptions.predicate = NSPredicate(format: "title = %@", "WildCat")
        let collection = PHAssetCollection.fetchAssetCollections(with: .album, subtype: .albumRegular, options: fetchOptions)
        collection.enumerateObjects { (collection, index, stop) in
            self.fetchResult = PHAsset.fetchAssets(in: collection, options: nil)
            print(String(self.fetchResult.count))
        }
        self.collectionView.reloadData()
    }
}
