//
//  FavoriteViewController.swift
//  iOS_Weather_App
//
//  Created by Alexander George Legaspi on 10/15/19.
//  Copyright © 2019 Alexander George Legaspi. All rights reserved.
//

import UIKit

class FavoriteViewController: UIViewController {
    
    var favorites = [Favorite]() {
        didSet {
            collectionView.reloadData()
        }
    }
    
    @IBOutlet var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadFavoriteImages()
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        collectionView.reloadData()
    }
    
    private func loadFavoriteImages() {
        print("load images function")
        do {
            favorites = try FavoritePersistenceHelper.manager.getFavorites()
        } catch {
            print("FVC could not load images: \(error)")
        }
    }
    
    
}

extension FavoriteViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print(favorites.count)
        return favorites.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let image = favorites[indexPath.item]
        print(image)
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FavoriteCell", for: indexPath) as? FavoriteCell else {
            return UICollectionViewCell()
        }
        
        cell.favoriteImage.image = UIImage(data: image.imageData)
        
        return cell
    }
    
    
}
