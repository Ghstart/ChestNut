//
//  FastImgPhotoViewController.swift
//  ChestNut
//
//  Created by 龚欢 on 2017/10/20.
//  Copyright © 2017年 龚欢. All rights reserved.
//

import UIKit

class FastImgPhotoViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    let fastImgCollectionCellIdentifior = "fastImgCollectionCellIdentifior"
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpCollectionView()
    }
    
    //MARK: -- Private Methods
    func setUpCollectionView() {
        collectionView.register(FastImgPhotoCell.self, forCellWithReuseIdentifier: fastImgCollectionCellIdentifior)
        collectionView.delegate = self
        collectionView.dataSource = self
    }
}

extension FastImgPhotoViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let fastImgCell = collectionView.dequeueReusableCell(withReuseIdentifier: fastImgCollectionCellIdentifior, for: indexPath) as! FastImgPhotoCell
        fastImgCell.imageView.image = UIImage(named: "\(indexPath.item)")
        return fastImgCell
    }
}
