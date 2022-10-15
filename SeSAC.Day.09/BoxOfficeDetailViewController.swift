//
//  BoxOfficeDetailViewController.swift
//  SeSAC.Day.09
//
//  Created by Joonhwan Jeon on 2021/10/15.
//

import UIKit

class BoxOfficeDetailViewController: UIViewController, UITextViewDelegate, UIPickerViewDelegate, UIPickerViewDataSource {
    
    //Pass Data 1. 공간 만들기
//    var movieTitle: String?
//    var releaseDate: String?
//    var runtime: Int?
//    var overview: String?
//    var rate: Double?
    
    var movieData: Movie?
    
    let pickerList: [String] = ["고래밥", "새우깡", "짱구", "맛동산", "포테토칩", "베이컨스모키", "프링글스"]
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 5
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerList[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        titleTextField.text = pickerList[row]
        print(row)
    }
    

    @IBOutlet weak var titleTextField: UITextField!
    
    @IBOutlet weak var overviewTextView: UITextView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Pass Data2.
//        titleTextField.text = movieTitle
//        overviewTextView.text = overview
        
//        print(runtime, rate, releaseDate)
        
        titleTextField.text = movieData?.title
        overviewTextView.text = movieData?.overview
        
        print(movieData?.rate, movieData?.runtime, movieData?.releaseDate)
        
    
        let pickerView = UIPickerView()
        pickerView.delegate = self
        pickerView.dataSource = self
        titleTextField.inputView = pickerView
        
        
        overviewTextView.delegate = self
        
        //택스트뷰 플래아수 홀더 : 글자 색상
        //overviewTextView.text = "이곳에 줄거리를 남겨보세요"
        overviewTextView.textColor = .lightGray
        
    }
    
    
    //커서 시작
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == .lightGray{
            overviewTextView.text = nil
            textView.textColor = .black
        }
    }
    
    //커서 끝
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "이곳에 줄거리를 남겨보세요"
            textView.textColor = .lightGray
        }
    }
   

}
