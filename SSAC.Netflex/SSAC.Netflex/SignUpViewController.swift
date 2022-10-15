import UIKit

class SignUpViewController: UIViewController {

    @IBOutlet var tfEmail: UITextField!
    @IBOutlet var tfPassword: UITextField!
    @IBOutlet var tfNickname: UITextField!
    @IBOutlet var tfLocation: UITextField!
    @IBOutlet var tfCoupon: UITextField!
        
    @IBOutlet var btnSignUp: UIButton!
    @IBOutlet var swMoreInfomation: UISwitch!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tfEmail.placeholder = "이메일 또는 연락처"
        tfEmail.textColor = .white
        tfEmail.backgroundColor = .gray
        tfEmail.textAlignment = .center
        tfEmail.keyboardType = .emailAddress
        
        tfPassword.placeholder = "비밀번호"
        tfPassword.textColor = .white
        tfPassword.backgroundColor = .gray
        tfPassword.textAlignment = .center
        tfPassword.keyboardType = .numbersAndPunctuation
        tfPassword.isSecureTextEntry = true
        
        tfNickname.placeholder = "닉네임"
        tfNickname.textColor = .white
        tfNickname.textAlignment = .center
        tfNickname.backgroundColor = .gray
        
        tfLocation.placeholder = "지역"
        tfLocation.textColor = .white
        tfLocation.textAlignment = .center
        tfLocation.backgroundColor = .gray
        tfLocation.keyboardType = .asciiCapable
        
        tfCoupon.placeholder = "쿠폰 코드 입력"
        tfCoupon.textColor = .white
        tfCoupon.textAlignment = .center
        tfCoupon.backgroundColor = .gray
        tfCoupon.keyboardType = .numberPad
        
        btnSignUp.setTitle("가입하기", for: .normal)
        btnSignUp.setTitleColor(.black, for: .normal)
        btnSignUp.backgroundColor = .white
        
        swMoreInfomation.setOn(true, animated: true)
        swMoreInfomation.onTintColor = .red
        swMoreInfomation.thumbTintColor = .gray
        
        
        // Do any additional setup after loading the view.
    }
    @IBAction func btnSignIn(_ sender: UIButton) {
        print("회원가입 정보 확인")
        print("ID : \(tfEmail.text!)")
        print("PW : \(tfPassword.text!)")
        print("Nick : \(tfNickname.text!)")
        print("Location : \(tfLocation.text!)")
        print("CODE : \(tfCoupon.text!)")
        
    }
    @IBAction func swMoreInfo(_ sender: UISwitch) {
        if(sender.isOn){
            tfNickname.isHidden = false
            tfLocation.isHidden = false
            tfCoupon.isHidden = false
        }else{
            tfNickname.isHidden = true
            tfLocation.isHidden = true
            tfCoupon.isHidden = true
        }
    }
    @IBAction func tapGesture(_ sender: UITapGestureRecognizer) {
        self.view.endEditing(true)
    }
    

}
