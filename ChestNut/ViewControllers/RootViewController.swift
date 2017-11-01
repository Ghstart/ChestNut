//
//  ViewController.swift
//  ChestNut
//
//  Created by 龚欢 on 2017/10/10.
//  Copyright © 2017年 龚欢. All rights reserved.
//

import UIKit
import LeanCloud

class RootViewController: UIViewController {
    
    @IBOutlet weak var fastPhotoImgTop: NSLayoutConstraint!
    
    private let segueFastPhotoImg = "segueFastPhotoImg"
    private let segueListPhotoImg = "segueListPhotoImg"
    
    var fastPhotoImgController: FastImgPhotoViewController!
    var listPhotoImgController: ListImgPhotoViewController!
    var lastScorllIndex: CGFloat?
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let identifior = segue.identifier else { return }
        
        switch identifior {
        case segueFastPhotoImg:
            guard let destination = segue.destination as? FastImgPhotoViewController else {
                fatalError("Invalid destination viewController.")
            }
            fastPhotoImgController = destination
        case segueListPhotoImg:
            guard let destination = segue.destination as? ListImgPhotoViewController else {
                fatalError("Invalid destination viewController.")
            }
            destination.delegate = self
            listPhotoImgController = destination
        default:
            break
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

    }
}

extension RootViewController: ListImgControllerProtocol {
    func listScroll(sc: UIScrollView) {
        if let scorllIndex = self.lastScorllIndex {
            if (sc.contentOffset.y > scorllIndex && self.fastPhotoImgTop.constant >= -205) {// 上滑动
               self.fastPhotoImgTop.constant = -205
            } else if (sc.contentOffset.y < scorllIndex && self.fastPhotoImgTop.constant <= 0){// 下滑动
                self.fastPhotoImgTop.constant = 0
            }
        }
        self.lastScorllIndex = sc.contentOffset.y
    }
}


