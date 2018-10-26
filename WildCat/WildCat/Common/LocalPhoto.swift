//
//  LocalPhoto.swift
//  WildCat
//
//  Created by Azuma on 2018/10/25.
//  Copyright © 2018 Azuma. All rights reserved.
//

import Foundation
import Photos

class LocalPhoto {
    class func savePhoto(_ image: UIImage, toAlbum albumName: String, completion: @escaping (String?) -> Void) {
        let imageData = image.pngData()!
        let TempFilePath = "\(NSTemporaryDirectory())temp.jpg"
        var imageID: String? = nil

        LocalPhoto.findOrCreateAlbum(name: albumName) { (album) in
            let fileURL = URL(fileURLWithPath: TempFilePath)
            try? imageData.write(to: fileURL, options: .atomic)

            if let album = album, FileManager.default.fileExists(atPath: TempFilePath) {
                PHPhotoLibrary.shared().performChanges({
                    let assetRequest = PHAssetChangeRequest.creationRequestForAssetFromImage(atFileURL: fileURL)!
                    let albumChangeRequest = PHAssetCollectionChangeRequest(for: album)
                    let placeHolder = assetRequest.placeholderForCreatedAsset
                    albumChangeRequest?.addAssets([placeHolder!] as NSArray)
                    imageID = assetRequest.placeholderForCreatedAsset?.localIdentifier
                }, completionHandler: { (isSuccess, error) in
                    if isSuccess {
                        completion(imageID)
                    } else {
                        print(error ?? "error")
                    }
                    _ = try? FileManager.default.removeItem(at: fileURL)
                })
            } else {
                _ = try? FileManager.default.removeItem(at: fileURL)
            }
        }
    }

    private class func findOrCreateAlbum(name: String, completion: @escaping (PHAssetCollection?) -> Void) {
        var assetCollection: PHAssetCollection?
        var assetCollectionPlaceholder: PHObjectPlaceholder?

        let fetchOptions = PHFetchOptions()
        fetchOptions.predicate = NSPredicate(format: "title = %@", name)
        let collection = PHAssetCollection.fetchAssetCollections(with: .album, subtype: .any, options: fetchOptions)
        if let firstObject = collection.firstObject {
            assetCollection = firstObject
            completion(assetCollection)
        } else {
            PHPhotoLibrary.shared().performChanges({
                let createRequest = PHAssetCollectionChangeRequest.creationRequestForAssetCollection(withTitle: name)
                assetCollectionPlaceholder = createRequest.placeholderForCreatedAssetCollection
            }) { (isSuccess, error) in
                if isSuccess {
                    let refetchResult = PHAssetCollection.fetchAssetCollections(withLocalIdentifiers: [assetCollectionPlaceholder!.localIdentifier], options: nil)
                    assetCollection = refetchResult.firstObject
                    completion(assetCollection)
                } else {
                    completion(nil)
                }
            }
        }
    }

    class func load(completion: @escaping ([UIImage]) -> Void) {
        var photos: [PHAsset] = []
        LocalPhoto.findOrCreateAlbum(name: "WildCat") { (album) in
            if let album = album {
                let asset = PHAsset.fetchAssets(in: album, options: nil)
                asset.enumerateObjects { (image, _, _) in
                    photos.append(image)
                }

                let manager = PHImageManager()
                var images = [UIImage]()
                for photo in photos {
                    print("width: \(photo.pixelWidth), height: \(photo.pixelHeight)")
                    manager.requestImage(for: photo, targetSize: CGSize(width: photo.pixelWidth, height: photo.pixelHeight), contentMode: .aspectFit, options: nil) { (image, info) in
                        images.append(image!)
                    }
                    completion(images)
                }
            }
        }
    }
}

extension LocalPhoto {

    class func load(path: String, complition: @escaping (UIImage) -> Void) {
        let dumyPath = "file:///Users/koyamaura/Library/Developer/CoreSimulator/Devices/D60D2A3B-5DE5-48E5-9ED3-A1D6064F45DB/data/Containers/Data/Application/5F670617-EA8B-4715-9B25-5F3F5D707F11/tmp/F5D7E81D-C777-433C-9851-021377ABE53E.jpeg"
        self.findOrCreateAlbum(name: "WildCat") { (album) in
            if let album = album {
                let asset = PHAsset.fetchAssets(in: album, options: nil)
                var photo = PHAsset()
                if let firstObject = asset.firstObject {
                    photo = firstObject
                    print("first object がありまーす")
                }
//                asset.enumerateObjects { (image, _, _) in
//                    photo = image
//                }

                let manager = PHImageManager()
                var image: UIImage? = UIImage(named: "black")
                manager.requestImage(for: photo, targetSize: CGSize(width: photo.pixelWidth, height: photo.pixelHeight), contentMode: .aspectFit, options: nil) { (imagee, info) in
                    image = imagee!
                }
                complition(image)
            }
        }
    }
}
