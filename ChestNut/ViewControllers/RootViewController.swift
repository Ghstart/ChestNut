//
//  ViewController.swift
//  ChestNut
//
//  Created by 龚欢 on 2017/10/10.
//  Copyright © 2017年 龚欢. All rights reserved.
//

import UIKit

class RootViewController: UIViewController {
    
    @IBOutlet weak var fastPhotoImgTop: NSLayoutConstraint!
    private let segueFastPhotoImg = "segueFastPhotoImg"
    private let segueListPhotoImg = "segueListPhotoImg"
    var fastPhotoImgController: FastImgPhotoViewController!
    var listPhotoImgController: ListImgPhotoViewController!
    
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
        // Do any additional setup after loading the view, typically from a nib.
    }
}

extension RootViewController: ListImgControllerProtocol {
    func listScroll(sc: UIScrollView, ve: CGPoint){
        if (ve.y > 0 && self.fastPhotoImgTop.constant >= -205) {
            UIView.animate(withDuration: 0.36, animations: {
                self.fastPhotoImgTop.constant = -205
            })
        } else if (ve.y < 0 && self.fastPhotoImgTop.constant <= 0) {
            UIView.animate(withDuration: 0.36, animations: {
                self.fastPhotoImgTop.constant = 0
            })
        }
    }
}

