//
//  PhotosCollectionViewController.swift
//  WildCat
//
//  Created by 陰山賢太 on 2018/10/23.
//  Copyright © 2018 Azuma. All rights reserved.
//

import UIKit
import SKPhotoBrowser

class PhotosCollectionViewController: UICollectionViewController {

    private let refreshControl = UIRefreshControl()

    // Twitter
    private var photos = [Photo]()
    private var skPhotos = [SKPhoto]()
    private var status = SegmentStatus.Twitter

    // Save
    private var savePhotos = [Photo]()
    private var saveSKPhotos = [SKPhoto]()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.collectionView.refreshControl = refreshControl
        self.refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)

        for _ in 0..<25 {
            skPhotos.append(SKPhoto.photoWithImage(UIImage(named: "black")!))
        }
        SKPhotoBrowserOptions.displayBackAndForwardButton = false
        SKPhotoBrowserOptions.displayAction = false
        getData()
    }

    @objc private func refresh() {

    }

    @IBAction private func segmentAction(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            self.status = .Twitter
            self.collectionView.refreshControl = refreshControl
            self.collectionView.reloadData()
        } else {
            self.status = .Save
            self.collectionView.refreshControl = nil
            self.collectionView.reloadData()
        }
    }

    private func getData() {
        guard let path = Bundle.main.path(forResource: "Photo", ofType: "json") else { return }
        let url = URL(fileURLWithPath: path)
        do {
            let data = try Data(contentsOf: url)
            let photos = try
                JSONDecoder().decode([Photo].self, from: data)
            self.photos = photos
            self.collectionView.reloadData()
        } catch  {
            print(error)
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch status {
        case .Twitter:
            return photos.count
        case .Save:
            return savePhotos.count
        }
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCell", for: indexPath) as! PhotoCell
        switch status {
        case .Twitter:
            cell.configure(photo: photos[indexPath.item]) { (image) in
                if let image = image {
                    let skImage = SKPhoto.photoWithImage(image)
                    self.skPhotos[indexPath.item] = skImage
                }
            }
        case .Save:
            break
        }
    
        return cell
    }

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! PhotoCell
        let originImage = cell.imageView.image
        var images = [SKPhoto]()

        switch status {
        case .Twitter:
            images = skPhotos
        case .Save:
            images = saveSKPhotos
        }

        let browser = SKPhotoBrowser(originImage: originImage ?? UIImage(), photos: images, animatedFromView: cell)
        let addImage = UIImageView(image: UIImage(named: "Add"))
        addImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(save)))
        addImage.translatesAutoresizingMaskIntoConstraints = false
        browser.view.addSubview(addImage)
        let customMargins = browser.view.layoutMarginsGuide
        addImage.trailingAnchor.constraint(equalTo: customMargins.trailingAnchor, constant: -16).isActive = true
        addImage.bottomAnchor.constraint(equalTo: customMargins.bottomAnchor, constant: -40).isActive = true
        addImage.heightAnchor.constraint(equalToConstant: 20.0).isActive = true
        addImage.widthAnchor.constraint(equalToConstant: 40.0).isActive = true
        browser.initializePageIndex(indexPath.item)
        present(browser, animated: true, completion: nil)
    }

    @objc private func save(sender: UITapGestureRecognizer) {
        print("save")
    }

}
