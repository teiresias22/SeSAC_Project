//
//  ViewController.swift
//  SSAC.Netflex
//
//  Created by Joonhwan Jeon on 2021/09/28.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var imgPreview1: UIImageView!
    @IBOutlet weak var imgPreview2: UIImageView!
    @IBOutlet weak var imgPreview3: UIImageView!
    @IBOutlet var imgMoviePoster: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        imgPreview1.layer.cornerRadius = 50.0
        imgPreview1.layer.masksToBounds = true
        imgPreview2.layer.cornerRadius = 50.0
        imgPreview2.layer.masksToBounds = true
        imgPreview3.layer.cornerRadius = 50.0
        imgPreview3.layer.masksToBounds = true
        // Do any additional setup after loading the view.
    }
    var moviePoster = ["7번방의선물.png", "겨울왕국2.png", "광해.png", "괴물.png", "국제시장.png", "극한직업.png", "도둑들.png", "명량.png", "베테랑.png", "부산행.png", "신과함께인과연.png", "신과함께죄와벌.png", "아바타.png", "알라딘.png", "암살.png", "어벤저스앤드게임.png", "왕의남자.png", "태극기휘날리몈.png", "택시운전사.png", "해운대.png"]
    @IBAction func btnPlay(_ sender: UIButton) {
        let randomNumber = Int.random(in: 1...moviePoster.count-1)
        let randomImage = UIImage(named: moviePoster[randomNumber])
        imgMoviePoster.image = randomImage
    }
    

}

