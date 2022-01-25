//
//  SignUpBDViewController.swift
//  SeSACFriend
//
//  Created by Joonhwan Jeon on 2022/01/21.
//

import UIKit

class SignUpBDViewController: BaseViewController {
    let mainView = SignUpBDView()
    
    var availableYear: [Int] = []
    var allMonth: [Int] = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12]
    var allDay: [Int] = []
    
    var selectedYear = 0
    var selectedMonth = 0
    var selectedDay = 0
    
    var todayYear = "0"
    var todayMonth = "0"
    var todayDay = "0"

    override func loadView() {
        self.view = mainView
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setAvailableDate()
        createPickerView()
        
        mainView.submitButton.addTarget(self, action: #selector(submitButtonClicked(_:)), for: .touchUpInside)
    }
    
    @objc func submitButtonClicked(_ sender: Any) {
        self.navigationController?.pushViewController(SignUpEmailViewController(), animated: true)
    }
    
    func createPickerView() {
        let pickerView = UIPickerView()
        pickerView.delegate = self
        pickerView.dataSource = self
                
        // 피커뷰 확인 취소 버튼 세팅
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        
        let btnDone = UIBarButtonItem(title: "확인", style: .done, target: self, action: #selector(onPickDone))
        let space = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        let btnCancel = UIBarButtonItem(title: "취소", style: .done, target: self, action: #selector(onPickCancel))
        toolBar.setItems([btnCancel , space , btnDone], animated: true)
        toolBar.isUserInteractionEnabled = true
            
        // 텍스트필드 입력 수단 연결
        mainView.inputYearTextField.inputView = pickerView
        mainView.inputMonthTextField.inputView = pickerView
        mainView.inputDayTextField.inputView = pickerView
        mainView.inputYearTextField.inputAccessoryView = toolBar
        mainView.inputMonthTextField.inputAccessoryView = toolBar
        mainView.inputDayTextField.inputAccessoryView = toolBar
    }
    
    @objc func onPickDone() {
        mainView.inputYearTextField.text = String(selectedYear)
        mainView.inputMonthTextField.text = String(selectedMonth)
        mainView.inputDayTextField.text = String(selectedDay)
        
        mainView.inputYearTextField.resignFirstResponder()
        mainView.inputMonthTextField.resignFirstResponder()
        mainView.inputDayTextField.resignFirstResponder()
    }
    
    @objc func onPickCancel() {
        mainView.inputYearTextField.resignFirstResponder()
        mainView.inputMonthTextField.resignFirstResponder()
        mainView.inputDayTextField.resignFirstResponder()
    }
    
    
    //날짜 계산
    func setAvailableDate() {
        let formatterYear = DateFormatter()
        formatterYear.dateFormat = "yyyy"
        todayYear = formatterYear.string(from: Date())
        
        for i in 1940...Int(todayYear)! {
            availableYear.append(i)
        }
        
        let formatterMonth = DateFormatter()
        formatterMonth.dateFormat = "MM"
        todayMonth = formatterMonth.string(from: Date())
        
        let formatterDay = DateFormatter()
        formatterDay.dateFormat = "dd"
        todayDay = formatterDay.string(from: Date())
        
        for i in 1...31 {
            allDay.append(i)
        }
        
        selectedYear = Int(todayYear)!
        selectedMonth = Int(todayMonth)!
        selectedDay = Int(todayDay)!
    }
    
}

extension SignUpBDViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 3
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch component {
        case 0: return availableYear.count
        case 1: return allMonth.count
        case 2: return allDay.count
        default: return 0
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch component {
        case 0: return "\(availableYear[row])년"
        case 1: return "\(allMonth[row])월"
        case 2: return "\(allDay[row])일"
        default: return ""
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch component {
        case 0: selectedYear = availableYear[row]
        case 1: selectedMonth = allMonth[row]
        case 2: selectedDay = allDay[row]
        default: break
        }
        
        if (Int(todayYear) == selectedYear && Int(todayMonth)! < selectedMonth) {
            pickerView.selectRow(Int(todayMonth)!-1, inComponent: 1, animated: true)
            selectedMonth = Int(todayMonth)!
        }
    }
    
    
}
