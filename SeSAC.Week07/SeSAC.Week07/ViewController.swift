//
//  ViewController.swift
//  SeSAC.Week07
//
//  Created by Joonhwan Jeon on 2021/11/10.
//

import UIKit

class ViewController: UIViewController, PassDateDelegate {
    func sendTextData(text: String) {
        textView.text = text
    }
    
    @IBOutlet weak var textView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        NotificationCenter.default.addObserver(self, selector: #selector(firstNotification(notification:)), name: .myNotification, object: nil)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector: #selector(firstNotification(notification:)), name: .myNotification, object: nil)
    }
    
    deinit {
        NotificationCenter.default.addObserver(self, selector: #selector(firstNotification(notification:)), name: .myNotification, object: nil)
    }
    
    
    
    @objc func firstNotification(notification: NSNotification) {
        
        if let text = notification.userInfo?["myText"] as? String {
            textView.text = text
        }
        
        
        print("NOTIFICATION!")
    }

    @IBAction func buttonClicked(_ sender: UIButton) {
        guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "SecondViewController") as? SecondViewController else { return }
        
        vc.buttonActionHandler = {
            print("buttonActionHandler")
            self.textView.text = vc.textView.text
        }
        
        vc.textSpace = textView.text
        self.present(vc, animated: true, completion: nil)
    }
    
    @IBAction func NotificationButtonClicked(_ sender: UIButton) {
        guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "SecondViewController") as? SecondViewController else { return }
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
        
    }
    @IBAction func protocolButtonClicked(_ sender: UIButton) {
        guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "SecondViewController") as? SecondViewController else { return }
        vc.delegate = self
        self.present(vc, animated: true, completion: nil)
    }
}

extension NSNotification.Name {
    static let myNotification = NSNotification.Name("firstNotification")
}
