//
//  ViewController.swift
//  KomoriOto
//
//  Created by Tsukuda Hiroshi on 2021/02/02.
//

import UIKit
import AVFoundation
import NendAd


class ViewController: UIViewController,AVAudioPlayerDelegate,NADViewDelegate, NADInterstitialVideoDelegate,CellDelegate{
    func adButtonTapped(_ tag: Int) {
        
        print("pressed a button with a tag: \(tag)")
        
        adFlg = true
        tableView.reloadData()
    }

    let interstitialVideo = NADInterstitialVideo(spotID: 1024744, apiKey: "94b3093282245ea22e0ce3fbc36f6dccaf0b7f26")
    @IBOutlet weak var nadView: NADView!
    @IBOutlet weak var tableView: UITableView!
    var images = [#imageLiteral(resourceName: "薄型テレビとBlu-rayの無料アイコン素材 1"),#imageLiteral(resourceName: "横向きの自動車のフリーアイコン 1"),#imageLiteral(resourceName: "掃除機の無料アイコン素材 1"),#imageLiteral(resourceName: "ドライヤーのアイコン素材 6"),#imageLiteral(resourceName: "洗濯機アイコン5 (1)"),#imageLiteral(resourceName: "カサのピクトアイコン4"),#imageLiteral(resourceName: "トイレのフリーアイコン素材 3 (1)"),#imageLiteral(resourceName: "泡のアイコン3 (1)"),#imageLiteral(resourceName: "波アイコン1"),#imageLiteral(resourceName: "心臓のイラスト素材1"),#imageLiteral(resourceName: "川の無料アイコン1 (1)"),#imageLiteral(resourceName: "鳥のシンボルアイコン素材 1")]
    var namesList = ["テレビの砂嵐","車","掃除機","ドライヤー","洗濯機","傘の雨音","トイレ","泡","波","心臓","せせらぎ","野鳥と虫"]
    var player :AVAudioPlayer!
    var flg = false
    var adFlg = false
    let userDefault = UserDefaults.standard
    var indexPath = IndexPath()
    
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        player?.delegate = self
        
        UIApplication.shared.statusBarStyle = .lightContent
        
        tableView.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "tableViewCell")
        tableView.register(UINib(nibName: "TitleTableViewHeaderView", bundle: nil),forHeaderFooterViewReuseIdentifier: "TitleTableViewHeaderView")
        
        nadView.setNendID(1024570, apiKey: "4e66a573744fa1828667534cf057731cc9a11358")
        nadView.delegate = self
        nadView.load()
        
        interstitialVideo.delegate = self
        interstitialVideo.loadAd()
        
//        if UserDefaults.standard.object(forKey: "7") != nil {
//            adFlg7 = false
//            print("次回から広告は表示されません")
//        } else {
//            //まだ押されていない場合
//            adFlg7 = true
//            print("広告を流す必要があります")
//        }
        
    }
    
    func nadViewDidFinishLoad(_ adView: NADView!) {
        print("delegate nadViewDidFinishLoad:")
    }
    
    func nadViewDidReceiveAd(_ adView: NADView!) {
        print("delegate nadViewDidReceiveAd")
    }
    
    func nadViewDidFail(toReceiveAd adView: NADView!) {
        // エラーごとに処理を分岐する場合
        let error: NSError = adView.error as NSError
        //        デバッグの時に必要
        switch (error.code) {
        case NADViewErrorCode.NADVIEW_AD_SIZE_TOO_LARGE.rawValue:
            // 広告サイズがディスプレイサイズよりも大きい
            break
        case NADViewErrorCode.NADVIEW_INVALID_RESPONSE_TYPE.rawValue:
            // 不明な広告ビュータイプ
            break
        case NADViewErrorCode.NADVIEW_FAILED_AD_REQUEST.rawValue:
            // 広告取得失敗
            break
        case NADViewErrorCode.NADVIEW_FAILED_AD_DOWNLOAD.rawValue:
            // 広告画像の取得失敗
            break
        case NADViewErrorCode.NADVIEW_AD_SIZE_DIFFERENCES.rawValue:
            // リクエストしたサイズと取得したサイズが異なる
            break
        default:
            break
        }
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
        
        cell.adButton.tag = indexPath.row
        cell.cellDelegate = self
        
        //選択時の背景（灰色への変換）の無効化
        cell.selectionStyle = .none
        
        if adFlg == false{
            if indexPath.row > 6 {
                cell.adButton.isHidden = false
//                cell.adButton.addTarget(self, action: #selector(tapCellButton(sender:)), for: .touchUpInside)
            }
            else {
                cell.adButton.isHidden = true
            }
        } else {
            if indexPath.row > 6 {
                cell.adButton.isHidden = true
                
            }
        }
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: "TitleTableViewHeaderView")
        if let headerView = view as? TitleTableViewHeaderView {
            headerView.setup(image: #imageLiteral(resourceName: "アートボード 2") )
        }
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 80
    }
    
//    @objc private func tapCellButton( sender: UIButton){
//        print("Button is tapped")
//        adFlg = false
//
//        //動画広告を表示
//        if interstitialVideo.isReady{
//            interstitialVideo.showAd(from: self)
//        }
//        tableView.reloadData()
//    }
    
}

