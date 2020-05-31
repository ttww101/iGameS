//
//  GameVC.swift
//  iGameS
//
//  Created by Apple on 5/7/19.
//  Copyright © 2019 whitelok.com. All rights reserved.
//

import UIKit

class GameVC: UIViewController {

    @IBOutlet weak var startBtn: UIButton!
    @IBOutlet weak var GameView: UIView!
    @IBOutlet weak var recordView: UIView!
    @IBOutlet weak var lScore: UILabel!
    @IBOutlet weak var RScore: UILabel!
    @IBOutlet weak var rLScore: UILabel!
    @IBOutlet weak var rRScore: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var lImage: UIImageView!
    @IBOutlet weak var rImage: UIImageView!
    @IBOutlet weak var lexplosion: UIImageView!
    @IBOutlet weak var rexplosion: UIImageView!
    
    var startReciprocal = 3 {
        didSet {
            if startReciprocal > -1 {
                timeLabel.text = "\(startReciprocal)"
            }
        }
    }
    var gameReciprocal = 60 {
        didSet {
            timeLabel.text = gameReciprocal.toTimeString()
        }
    }
    var leftScore = 0 {
        didSet {
            if leftScore < 0 { leftScore = 0; return }
            lScore.text = "\(leftScore)"
            rLScore.text = "\(leftScore)"
        }
    }
    var rightScore = 0 {
        didSet {
            if rightScore < 0 { rightScore = 0; return }
            RScore.text = "\(rightScore)"
            rRScore.text = "\(rightScore)"
        }
    }
    var monsterAppear = 0 {
        didSet {
            switch monsterAppear {
            case 0:
                lImage.image = nil
                rImage.image = nil
            case 1:
                lImage.image = UIImage(named: "monster.png")
                rImage.image = nil
            case 2:
                lImage.image = nil
                rImage.image = UIImage(named: "monster.png")
            case 3:
                lImage.image = UIImage(named: "monster.png")
                rImage.image = UIImage(named: "monster.png")
            default:
                return
            }
        }
    }
    var timer: Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.orientation = .landscape
        
        lexplosion.animationImages = [UIImage(named: "explosion1.png"), UIImage(named: "explosion2.png"), UIImage(named: "explosion3.png")] as! [UIImage]
        lexplosion.animationDuration = 0.3
        lexplosion.animationRepeatCount = 1
        rexplosion.animationImages = [UIImage(named: "explosion1.png"), UIImage(named: "explosion2.png"), UIImage(named: "explosion3.png")] as! [UIImage]
        rexplosion.animationDuration = 0.3
        rexplosion.animationRepeatCount = 1
    }
    @IBAction func startClick(_ sender: UIButton) {
        startBtn.isHidden = true
        GameView.isHidden = false
        resetGame()
    }
    @IBAction func attackClick(_ sender: UIButton) {
        if gameReciprocal == 0 { return }
        switch sender.tag {
        case 0:
            lexplosion.startAnimating()
            if monsterAppear == 1 || monsterAppear == 3 {
                leftScore += 1
            } else {
                leftScore -= 1
            }
        case 1:
            rexplosion.startAnimating()
            if monsterAppear == 2 || monsterAppear == 3 {
                rightScore += 1
            } else {
                rightScore -= 1
            }
        default:
            return
        }
    }
    
    func resetGame() {
        startReciprocal = 3
        leftScore = 0
        rightScore = 0
        monsterAppear = 0
        registerTimer()
    }
    
    func registerTimer() {
        self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(runGameTime(_:)), userInfo: nil, repeats: true)
    }
    @objc func runGameTime(_ timer: Timer) -> Void {
        if startReciprocal == 0{
            gameReciprocal = 60
        } else if startReciprocal < 0 {
            gameReciprocal -= 1
            monsterAppear = Int.random(in: 0...3)
            if gameReciprocal == 0 {
                self.timer?.invalidate()
                self.timer = nil
                recordView.isHidden = false
            }
        }
        startReciprocal -= 1
    }
    @IBAction func againClick(_ sender: UIButton) {
        recordView.isHidden = true
        resetGame()
    }
    
    @IBAction func leaveClick(_ sender: UIButton) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.orientation = .portrait
        self.dismiss(animated: true, completion: nil)
    }
    
}
