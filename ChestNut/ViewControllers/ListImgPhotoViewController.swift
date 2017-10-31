//
//  ListImgPhotoViewController.swift
//  ChestNut
//
//  Created by 龚欢 on 2017/10/20.
//  Copyright © 2017年 龚欢. All rights reserved.
//

import UIKit

protocol ListImgControllerProtocol: class {
    func listScroll(sc: UIScrollView)
}

class ListImgPhotoViewController: UIViewController {

    @IBOutlet weak var listImgTableView: UITableView!
    
    let listImgTableViewCellIdentifior = "listImgTableViewCellIdentifior"
    weak var delegate: ListImgControllerProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTableView()
    }

    func setUpTableView() {
        listImgTableView.delegate   = self
        listImgTableView.dataSource = self
        listImgTableView.bounces    = false
        listImgTableView.estimatedRowHeight = 120
        listImgTableView.tableFooterView = UIView()
    }
}

extension ListImgPhotoViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: listImgTableViewCellIdentifior) as! ListImgCell
        cell.userImageView.image = UIImage(named: "\(indexPath.row)")
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension;
    }
}

extension ListImgPhotoViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.delegate?.listScroll(sc: scrollView)
    }
}
