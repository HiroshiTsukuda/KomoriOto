//
//  ViewController.swift
//  KomoriOto
//
//  Created by Tsukuda Hiroshi on 2021/02/02.
//

import UIKit
import AVFoundation


class ViewController: UIViewController,AVAudioPlayerDelegate {

    @IBOutlet weak var tableView: UITableView!
    var images = [#imageLiteral(resourceName: "PCディスプレイのアイコン素材 2"),#imageLiteral(resourceName: "掃除機の無料アイコン素材 3"),#imageLiteral(resourceName: "ドライヤーのアイコン素材 4"),#imageLiteral(resourceName: "ドラム式洗濯機のイラストアイコン素材 4 (1)"),#imageLiteral(resourceName: "引越しのマーク　水濡れ厳禁のアイコン素材 1"),#imageLiteral(resourceName: "トイレのフリーアイコン素材 3"),#imageLiteral(resourceName: "泡のアイコン3"),#imageLiteral(resourceName: "波のアイコン1"),#imageLiteral(resourceName: "川の無料アイコン1-1"),#imageLiteral(resourceName: "小鳥のアイコン (1)")]
    var namesList = ["テレビの砂嵐","掃除機","ドライヤー","洗濯機","傘の雨音","トイレ","泡","波","せせらぎ","野鳥と虫"]
    var player :AVAudioPlayer!
    var flg = false
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableView.dataSource = self
        tableView.delegate = self
        player?.delegate = self
        
        UIApplication.shared.statusBarStyle = .lightContent
        
        tableView.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "tableViewCell")
        tableView.register(UINib(nibName: "TitleTableViewHeaderView", bundle: nil),forHeaderFooterViewReuseIdentifier: "TitleTableViewHeaderView")
        
    }

}

extension ViewController: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return images.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableViewCell", for: indexPath) as! TableViewCell
        cell.itemImageView.image = images[indexPath.row]
        cell.soundNameLabel.text = namesList[indexPath.row]
        
        cell.indexPath = indexPath
        
        //選択時の背景（灰色への変換）の無効化
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: "TitleTableViewHeaderView")
        if let headerView = view as? TitleTableViewHeaderView {
            headerView.setup(image: #imageLiteral(resourceName: "astronomy-1867616_1280") )
        }
        return view
    }
    
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 80
    }
    
    
}

