//
//  PublishContentsViewController.swift
//  ChestNut
//
//  Created by 龚欢 on 2017/11/1.
//  Copyright © 2017年 龚欢. All rights reserved.
//

import UIKit

class PublishContentsViewController: UIViewController {

    @IBOutlet weak var fastBtnBG: UIView!
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    
    // MARK: -- Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViews()
        setUpNotification()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        removeNotification()
    }
    
    // MARK: -- Private Methods
    
    private func setUpViews() {
        self.title = "略记..."
        self.fastBtnBG.layer.borderColor = UIColor.lightGray.cgColor
        self.fastBtnBG.layer.borderWidth = 0.5
    }
    
    private func setUpNotification() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(PublishContentsViewController.keyBoardWillChange(_:)),
                                               name: .UIKeyboardWillChangeFrame,
                                               object: nil)
    }
    
    private func removeNotification() {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc private func keyBoardWillChange(_ notification: Notification) {
        if let userInfo = notification.userInfo,
            let value = userInfo[UIKeyboardFrameEndUserInfoKey] as? NSValue,
            let duration = userInfo[UIKeyboardAnimationDurationUserInfoKey] as? Double,
            let curve = userInfo[UIKeyboardAnimationCurveUserInfoKey] as? UInt {
            
            let frame = value.cgRectValue
            let intersection = frame.intersection(self.view.frame)
            
            //self.view.setNeedsLayout()
            //改变下约束
            self.bottomConstraint.constant = intersection.height
            
            UIView.animate(withDuration: duration, delay: 0.0,
                           options: UIViewAnimationOptions(rawValue: curve), animations: {
                            self.view.layoutIfNeeded()
            }, completion: nil)
        }
    }

    // MARK: -- Action Methods
    @IBAction func publishActionPressed(_ sender: Any) {
        
    }
    
    @IBAction func dissKeyBoardBtnPressed(_ sender: Any) {
        self.view.endEditing(true)
    }
    
    @IBAction func chooseImgBtnPressed(_ sender: Any) {
    }
    
    @IBAction func backToRootActionPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
