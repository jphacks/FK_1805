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

class PhotoPickerController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    var delegate: PhotoPickerControllerDelegate?
    private var fetchResult: PHFetchResult<PHAsset>!
    private let imageManager = PHCachingImageManager()
    @IBOutlet weak var collectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.fetchResult.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "photoCell", for: indexPath) as! PhotoPickerCell
        let asset = self.fetchResult.object(at: indexPath.row)
        let size = CGSize(width: asset.pixelWidth, height: asset.pixelHeight)
        imageManager.requestImage(for: asset, targetSize: size, contentMode: .aspectFill, options: nil) { (image, _) in
            let image = image ?? UIImage(named: "black")!
            cell.update(image: image)
        }
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.collectionView.selectItem(at: indexPath, animated: true, scrollPosition: UICollectionView.ScrollPosition.bottom)
    }
    @IBAction func doneAction(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
    }
}
