//
//  FavoriteViewController.swift
//  iOS_Weather_App
//
//  Created by Alexander George Legaspi on 10/15/19.
//  Copyright © 2019 Alexander George Legaspi. All rights reserved.
//

import UIKit

class FavoriteViewController: UIViewController {
    
    var favoriteImages = [Image]() {
        didSet {
            collectionView.reloadData()
        }
    }

    @IBOutlet var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadFavoriteImages()
    }
    
    private func loadFavoriteImages() {
        
    }
    
}

extension FavoriteViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return favoriteImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let image = favoriteImages[indexPath.item]
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FavoriteCell", for: indexPath) as? FavoriteCell else { return UICollectionViewCell() }
        
        ImageHelper.shared.getImage(urlStr: image.imgURL!) { (result) in
            DispatchQueue.main.async {
                switch result {
                case .success (let image):
                    cell.favoriteImage.image = image
                case .failure(let error):
                    print(error)
                }
            }
        }
        
        return cell
    }
    
    
}
