//
//  TableViewCell.swift
//  KomoriOto
//
//  Created by Tsukuda Hiroshi on 2021/02/02.
//

import UIKit
import AVFoundation

class TableViewCell: UITableViewCell,AVAudioPlayerDelegate {

    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var itemImageView: UIImageView!
    @IBOutlet weak var soundNameLabel: UILabel!
    @IBOutlet weak var pauseButton: UIButton!
    var player :AVAudioPlayer!
    var flg = false
    var pause: UIImage = UIImage(named: "pauseButton")!
    var indexPath = IndexPath()
    let audioSession = AVAudioSession.sharedInstance()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        containerView?.layer.cornerRadius = 30
        pauseButton?.layer.cornerRadius = 30
        pauseButton?.layer.borderWidth = 3
        pauseButton?.layer.borderColor = .init(red: 255, green: 255, blue: 255, alpha:1)

    }
    private func musicListNum(forResource: IndexPath){
        //        ["テレビの砂嵐","掃除機","洗濯機","ドライヤー","傘の雨音","トイレ","泡","せせらぎ","波","野鳥と虫","ネコ"]
        var musicList = ["tv","souziki","dryer","sentakuki","umbrella","toillet","bukubuku","ocean-wave","seseragi","bird-and-bag","cat"/*,"cat"*/]
        
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
            pauseButton.layer.backgroundColor = .init(red: 255, green: 255, blue: 255, alpha: 0)
            flg = false
            player.currentTime = 0
            player.stop()
            
        } else {
            
            pauseButton.layer.backgroundColor = .init(red: 255, green: 255, blue: 255, alpha: 0.7)
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

//        case 11:
//            musicListNum(forResource: [11])

        default:
            return
        }
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
