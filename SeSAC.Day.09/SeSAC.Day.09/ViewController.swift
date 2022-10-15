//
//  ViewController.swift
//  SeSAC.Day.09
//
//  Created by Joonhwan Jeon on 2021/10/12.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    //Present - Dismiss
    @IBAction func memoButtonClicked(_ sender: UIButton) {
        //1, 스토리보드 특정
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        //2. 스토리보드 내 많은 뷰컨트롤러 중 전환하고자 하는 뷰컨트롤러 가져오기
        let vc = storyboard.instantiateViewController(withIdentifier: "MemoTableViewController") as! MemoTableViewController
        
        //2-1 네비게이션 컨트롤러 임베드
        let nav = UINavigationController(rootViewController: vc)
        
        
        //(옵션)
        nav.modalTransitionStyle = .partialCurl
        nav.modalPresentationStyle = .fullScreen
        
        //3. Present
        self.present(nav, animated: true, completion: nil)
        
    }
    
    
    //Puch - Pop
    @IBAction func BoxOfficeButtonClicked(_ sender: UIButton) {
        
        print(#function)
        
        //1, 스토리보드 특정
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        //2. 스토리보드 내 많은 뷰컨트롤러 중 전환하고자 하는 뷰컨트롤러 가져오기
        let vc = storyboard.instantiateViewController(withIdentifier: "MovieReviewTableViewController") as! MovieReviewTableViewController
        
        //Pass Data3
        vc.titleSpace = "박스오피스"
        
        //Push: 스토리보드에서 네비게이션 컨트롤러가 임베드 되어 있는지 확인!
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}

