//
//  ViewController.swift
//  SeSAC.Week14
//
//  Created by Joonhwan Jeon on 2021/12/27.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var firstBoxView: SquarBoxView!
    @IBOutlet weak var secondBoxView: SquarBoxView!
    @IBOutlet weak var therdBoxView: SquarBoxView!
    
    let redView: UIView = UIView()
    let blueView: UIView = UIView()
    let greenView: UIView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        greenView.addSubview(redView)
        view.addSubview(blueView)
        view.addSubview(greenView)
        
        greenView.clipsToBounds = true
        greenView.layer.allowsGroupOpacity = true
        //greenView.alpha = 0.5
        
        redView.frame = CGRect(x: 50, y: 50, width: 50, height: 50)
        blueView.frame = CGRect(x: 100, y: 100, width: 150, height: 150)
        greenView.frame = CGRect(x: 100, y: 100, width: 100, height: 100)
        
        redView.backgroundColor = .systemRed
        blueView.backgroundColor = .systemBlue
        greenView.backgroundColor = .systemGreen
        
        firstBoxView.label.text = "즐겨찾기"
        firstBoxView.imageView.image = UIImage(systemName: "star")
    }

    @IBAction func presentButtonClicked(_ sender: UIButton) {
        present(DetailViewController(), animated: true, completion: nil)
    }
    
}

