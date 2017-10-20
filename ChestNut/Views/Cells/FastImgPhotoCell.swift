//
//  FastImgPhotoCell.swift
//  ChestNut
//
//  Created by 龚欢 on 2017/10/20.
//  Copyright © 2017年 龚欢. All rights reserved.
//

import UIKit

class FastImgPhotoCell: UICollectionViewCell {
    
    lazy var imageView: UIImageView = {
       let imageView = UIImageView()
        imageView.clipsToBounds = true
        return imageView
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if imageView.superview == nil {
            imageView.frame = bounds
            imageView.layer.cornerRadius = layer.cornerRadius
            addSubview(imageView)
        }
    }
}
