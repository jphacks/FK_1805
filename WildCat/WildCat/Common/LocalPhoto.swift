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
    class func savePhoto(_ image: UIImage, toAlbum albumName: String, completion: @escaping (String) -> Void) {
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
                        completion(imageID!)
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

                let manager = PHCachingImageManager()
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

    class func load(localIdentifer: String, complition: @escaping (UIImage?) -> Void) {
        let imageManager = PHCachingImageManager()
        guard let asset = PHAsset.fetchAssets(withLocalIdentifiers: [localIdentifer], options: nil).firstObject else { return }
        let size = CGSize(width: asset.pixelWidth, height: asset.pixelHeight)
        imageManager.requestImage(for: asset, targetSize: size, contentMode: .aspectFill, options: nil) { (image, _) in
            complition(image)
        }
    }
}
