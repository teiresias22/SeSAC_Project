//
//  SignUpBDViewController.swift
//  SeSACFriend
//
//  Created by Joonhwan Jeon on 2022/01/21.
//

import UIKit

class SignUpBDViewController: BaseViewController {
    let mainView = SignUpBDView()
    var viewModel: SignUpViewModel!
    let validation = Validation()
    var isReturn: Bool!
    
    override func loadView() {
        self.view = mainView
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        returnCheck()
        createPickerView()
        
        mainView.submitButton.addTarget(self, action: #selector(submitButtonClicked(_:)), for: .touchUpInside)
        
    }
    
    @objc func submitButtonClicked(_ sender: Any) {
        if viewModel.getAge() >= 17 {
            let vc = SignUpEmailViewController()
            vc.viewModel = self.viewModel
            vc.isReturn = isReturn
            self.navigationController?.pushViewController(vc, animated: true)
        } else {
            self.toastMessage(message: "새싹친구는 만 17세 이상만 사용할 수 있습니다.")
        }
    }
    
    func createPickerView() {
        let pickerView = UIDatePicker()
        pickerView.locale = Locale(identifier: "ko-KR")
        pickerView.preferredDatePickerStyle = .wheels
        pickerView.datePickerMode = .date
        pickerView.timeZone = NSTimeZone.local
        pickerView.maximumDate = Date()
                
        // 피커뷰 확인 취소 버튼 세팅
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        
        let btnDone = UIBarButtonItem(title: "확인", style: .done, target: self, action: #selector(onPickDone(_:)))
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
        
        pickerView.addTarget(self, action: #selector(pickerValueChanged(_:)), for: .valueChanged)
    }
    
    @objc func pickerValueChanged(_ sender: UIDatePicker) {
        viewModel.birthDay.value = sender.date
        
        let birthday = viewModel.getBirthday(sender.date)
        mainView.inputYearTextField.text = birthday[0]
        mainView.inputMonthTextField.text = birthday[1]
        mainView.inputDayTextField.text = birthday[2]
        
    }
    
    @objc func onPickDone(_ sender: UIDatePicker) {        
        mainView.inputYearTextField.resignFirstResponder()
        mainView.inputMonthTextField.resignFirstResponder()
        mainView.inputDayTextField.resignFirstResponder()
    }
    @objc func onPickCancel() {
        mainView.inputYearTextField.resignFirstResponder()
        mainView.inputMonthTextField.resignFirstResponder()
        mainView.inputDayTextField.resignFirstResponder()
    }
    
    func returnCheck() {
        if isReturn {
            let birthday = viewModel.getBirthday(viewModel.birthDay.value)
            mainView.inputYearTextField.text = birthday[0]
            mainView.inputMonthTextField.text = birthday[1]
            mainView.inputDayTextField.text = birthday[2]
        }
    }
}
