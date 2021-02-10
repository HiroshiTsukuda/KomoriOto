//
//  TableViewCell.swift
//  KomoriOto
//
//  Created by Tsukuda Hiroshi on 2021/02/02.
//

import UIKit
import AVFoundation

protocol CellDelegate: class {
    func adButtonTapped(_ tag: Int)
}

class TableViewCell: UITableViewCell,AVAudioPlayerDelegate {

    weak var cellDelegate: CellDelegate?
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var itemImageView: UIImageView!
    @IBOutlet weak var soundNameLabel: UILabel!
    @IBOutlet weak var pauseButton: UIButton!
    @IBOutlet weak var adButton: UIButton!
    
    var player :AVAudioPlayer!
    var flg = false
    var adFlg = false
    var pause: UIImage = UIImage(named: "pauseButton")!
    var indexPath = IndexPath()
    let audioSession = AVAudioSession.sharedInstance()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        containerView?.layer.cornerRadius = 30
//        containerView?.layer.borderColor = .init(red: 254, green: 254, blue: 230, alpha:1)
        containerView?.layer.borderWidth = 3
        pauseButton?.layer.cornerRadius = 30
        pauseButton?.layer.borderWidth = 3
       //ボタン背景色設定
        pauseButton?.layer.borderColor = UIColor(red: 255/255, green: 245/255, blue: 210/255, alpha: 1).cgColor
        adButton?.layer.cornerRadius = 30
        adButton.titleEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 30);
        
//        if adFlg == false{
//            if indexPath.row > 6 {
//                adButton.isHidden = true
//
//            }
//            else {
//                adButton.isHidden = false
//            }
//        }

    }
    
//    private func adLimitCntl(){
//        if adFlg == true{
//            if indexPath < 7 {
//                adButton.isHidden = true
//            } else {
//                adButton.isHidden = false
////                adButton.addTarget(self, action: #selector(tapCellButton), for: .touchUpInside)
//            }
//        }
//    }
    
    private func musicListNum(forResource: IndexPath){
        //        ["テレビの砂嵐","掃除機","洗濯機","ドライヤー","傘の雨音","トイレ","泡","せせらぎ","波","野鳥と虫","ネコ"]
        var musicList = ["tv","car","souziki","dryer","sentakuki","umbrella","toillet","bukubuku","ocean-wave","heart_beat","seseragi","bird-and-bag"]
        
        print(indexPath.row)
        
        let soundFilePath = Bundle.main.path(forResource: musicList[indexPath.row], ofType: "mp3")!
        let sound:URL = URL(fileURLWithPath: soundFilePath)
        do {
            player = try AVAudioPlayer(contentsOf: sound, fileTypeHint: nil)
        } catch {
            print("インスタンス化作成エラー")
        }
        
        do {
            // AVAudioPlayerのインスタンス化
            player = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: soundFilePath))
            // デリゲートの設定
            player!.delegate = self
            // マナーモードでも音を鳴らすようにする
            try audioSession.setCategory(.playback)

        } catch {
            print("Audio Setting Failed.")
            return
        }
        
        if flg {
            //画像なし
            self.pauseButton.setImage(nil, for: UIControl.State())
            pauseButton.layer.backgroundColor = .init(red: 255, green: 245, blue: 210, alpha: 0)
            flg = false
            player.currentTime = 0
            player.stop()
            
        } else {
            pauseButton.layer.backgroundColor = .init(red: 255, green: 245, blue: 25, alpha: 0.7)
            pauseButton.setImage(pause, for: UIControl.State())
            flg = true
            player.numberOfLoops = -1
            player.play()
        }

    }
    
    @IBAction func changeImagePressButton(_ sender: Any) {
        
        switch indexPath.row {
        case 0:
            musicListNum(forResource: [0])
            
        case 1:
            musicListNum(forResource: [1])
            
        case 2:
            musicListNum(forResource: [2])
            
        case 3:
            musicListNum(forResource: [3])
            
        case 4:
            musicListNum(forResource: [4])
            
        case 5:
            musicListNum(forResource: [5])
            
        case 6:
            musicListNum(forResource: [6])
            
        case 7:
            musicListNum(forResource: [7])
            
        case 8:
            musicListNum(forResource: [8])
            
        case 9:
            musicListNum(forResource: [9])

        case 10:
            musicListNum(forResource: [10])
//            adController()

        case 11:
            musicListNum(forResource: [11])
//            adController()

        default:
            return
        }
        
    }
        private func endAdController() {

            let indexPathOfAd = ["7","8","9","10","11"]
            print(indexPath.row)

//            UserDefaults.standard.set(adFlg, forKey: indexPathOfAd[indexPath.row])
            
            if adFlg {
    
                adFlg = false
                adButton.isHidden = false
            } else {
                adFlg = true
                adButton.isHidden = true
            }
            
        }
    
    @IBAction func pressAdButton(_ sender: UIButton) {
        
//        print(indexPath.row,"Button Tap")

//        endAdController()
        switch sender.tag {

        case 7:
            endAdController()


        case 8:
            endAdController()

        case 9:
            endAdController()

        case 10:
            endAdController()

        case 11:
            endAdController()

        default:
            return
        }
        cellDelegate?.adButtonTapped(sender.tag)
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
