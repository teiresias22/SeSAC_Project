//
//  SquarBoxView.swift
//  SeSAC.Week14
//
//  Created by Joonhwan Jeon on 2022/01/02.
//

import UIKit

class SquarBoxView: TapAnimationView {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var label: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        loadView()
        loadUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        loadView()
        loadUI()
    }
    
    func loadView() {
        //let view2 = Bundle.main.loadNibNamed("SquarBoxView", owner: self, options: nil)?.first as! UIView
        let view = UINib(nibName: "SquarBoxView", bundle: nil).instantiate(withOwner: self, options: nil).first as! UIView
        view.frame = bounds
        view.backgroundColor = .systemCyan
        view.layer.cornerRadius = 10
        self.addSubview(view)
    }
    
    func loadUI() {
        label.font = .boldSystemFont(ofSize: 13)
        label.textAlignment = .center
        label.text = "마이페이지"
        imageView.image = UIImage(systemName: "star.fill")
        imageView.tintColor = .black
    }
    
}

class TapAnimationView: UIView {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        print(#function)
        DispatchQueue.main.async {
            self.alpha = 1.0
            UIView.animate(withDuration: 0.4, delay: 0, options: .curveLinear) {
                self.alpha = 0.5
            }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        print(#function)
        DispatchQueue.main.async {
            self.alpha = 1.0
            UIView.animate(withDuration: 0.4, delay: 0, options: .curveLinear) {
                self.alpha = 1.0
            }
        }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        print(#function)
        DispatchQueue.main.async {
            self.alpha = 1.0
            UIView.animate(withDuration: 0.4, delay: 0, options: .curveLinear) {
                self.alpha = 1.0
            }
        }
    }
}
