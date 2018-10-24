//
//  PhotosCollectionViewController.swift
//  WildCat
//
//  Created by 陰山賢太 on 2018/10/23.
//  Copyright © 2018 Azuma. All rights reserved.
//

import UIKit

class PhotosCollectionViewController: UICollectionViewController {

    private let refreshControl = UIRefreshControl()
    private var photos: [Photo] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)

        getData()
    }

    @objc private func refresh() {

    }

    @IBAction private func segmentAction(_ sender: Any) {
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
        return photos.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCell", for: indexPath) as! PhotoCell
        cell.configure(photo: photos[indexPath.item])
    
        return cell
    }

}
