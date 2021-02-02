//
//  TitleTableViewHeaderView.swift
//  KomoriOto
//
//  Created by Tsukuda Hiroshi on 2021/02/02.
//

import UIKit

class TitleTableViewHeaderView: UITableViewHeaderFooterView {

    @IBOutlet weak var imageView: UIImageView!

    func setup(image: UIImage){
        imageView.image = image
    }
}
