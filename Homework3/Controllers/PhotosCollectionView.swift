//
//  PhotosCollectionView.swift
//  Homework3
//
//  Created by detaysoft on 19.09.2022.
//  Copyright © 2022 Eda Barutçu. All rights reserved.
//

import UIKit
import Kingfisher

private let reuseIdentifier = "PhotoCell"

class PhotosCollectionView: UICollectionViewController {
    
    let photosApi = "https://jsonplaceholder.typicode.com/photos"
    var photosArr : [Photo] = []
    //  let activityIndicatorView = UIActivityIndicatorView(style: .medium)
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        getPhotosApi()
    }
    // MARK: Get Photos Api
    func getPhotosApi() {
        ApiManager.getApiResponse(urlPath: photosApi) { data, error in
            if error != nil {
                print(error!.localizedDescription)
            } else {
                if let data = data,
                   let photos = self.parseLogic(data: data) {
                    self.photosArr = photos
                    
                    DispatchQueue.main.async {
                        
                        self.collectionView.reloadData()
                    }
                }
            }
        }
    }
    
    private func parseLogic(data:Data) -> [Photo]? {
        do {
            let photosArr = try JSONDecoder().decode([Photo].self, from: data)
            
            return photosArr
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }
    
    // MARK: UICollectionViewDataSource
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return photosArr.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! PhotosCollectionViewCell
        
        let photo = photosArr[indexPath.row]
        
        cell.imageView.kf.setImage(with: URL(string: photo.thumbnailUrl))
        cell.lblName.text = photo.title
        
        return cell
    }
}
