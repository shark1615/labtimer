//
//  ViewController.swift
//  labtimer
//
//  Created by Apple on 2018/12/13.
//  Copyright © 2018年 Apple. All rights reserved.
//

import UIKit
import AVFoundation

let images = ["1", "2", "3", "4", "5"]
var i = 0
var oldtime = "00"
class ViewController: UIViewController {
    
    @IBOutlet weak var timer: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var shark: UIImageView!
    let synthesizer = AVSpeechSynthesizer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { (_) in
            let now = Date()
            let formatter = DateFormatter()
            formatter.dateFormat = "HH:mm:ss\nyyyy.MMM.dd E"
            let time = formatter.string(from: now)
            self.timer.text="\(time)"
            
            formatter.dateFormat = "mm"
            let newtime = formatter.string(from: now)
            if newtime > oldtime || (newtime == "00" && oldtime != "00"){
                self.imageView.image = UIImage(named: images[i])
                oldtime = newtime
                i = i + 1
                if i >= 5 {
                    i = 0
                }
            }
        }
        Timer.scheduledTimer(withTimeInterval: 3600, repeats: true){ (_) in
            // speak per hour
            let now = Date()
            let formatter2 = DateFormatter()
            formatter2.dateFormat = "HH:mm:ss"
            let time = formatter2.string(from: now)
            let utterance = AVSpeechUtterance(string: "現在時間是\(time)")
            utterance.voice = AVSpeechSynthesisVoice(language: "zh-TW")
            self.synthesizer.speak(utterance)
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func pressedbutton(_ sender: Any) {
        let xorig = self.shark.center.x
        let xstart = self.shark.frame
        
        let opts: UIView.AnimationOptions = [.autoreverse , .repeat]
        UIView.animate(withDuration: 5, delay: 0, options: opts, animations: {
            self.shark.center.x += 360
        }, completion: {_ in self.shark.center.x = xorig})
        }
    }



