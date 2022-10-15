import UIKit

class CodeViewController: UIViewController {

    @IBOutlet var userSearchTextField: UITextField!
    
    @IBOutlet var tagButton1: UIButton!
    @IBOutlet var tagButton2: UIButton!
    @IBOutlet var tagButton3: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        buttonUISetting(tagButton1)
        
        //buttonOutletName : 매개변수(Parameter), ButtonTitle :전달인자(Argument)
        //buttonUISetting(tagButton1, "사탕")
        buttonUISetting(tagButton2, "초콜릿")
        buttonUISetting(tagButton3, "츄러스")
        
        // Do any additional setup after loading the view.
    }
    //ButtonOutletName: 외부 매개변수, btn: 내부 매개변수
    //_ : 외부 매개변수 이름 생략 가능 -> 와일드 카드 식별자
    //오버로딩 : 같은 함수를 여러방법으로 사용할 수 있는것 (Defult 값을 주면 사용함)
    func buttonUISetting(_ btn : UIButton, _ t: String = "사탕") {
        //String = "사탕" defult 값으로 사탕을 고정
        btn.setTitle(t, for: .normal)
        btn.setTitleColor(.black, for: .normal)
        btn.layer.cornerRadius = 10
        btn.backgroundColor = .white
        
    }
    
    @IBAction func keyboardReturnKeyClicked(_ sender: UITextField) {
        //키보드 내리기
        view.endEditing(true)
        //EVENT : DidEndOnExit
    }
    
    @IBAction func foodTagButtonClicked(_ sender: UIButton) {
        
        //버튼에 이미지만 들어있다면 nil값일 수 있다.
        userSearchTextField.text = sender.currentTitle
        
    }
    
}
