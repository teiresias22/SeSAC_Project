

import UIKit

class ProfileViewController: UIViewController {

    //Bar Button Set
    @IBOutlet var userInformationSave: UIBarButtonItem!
    
    //User Profile Set
    @IBOutlet var profileImage: UIImageView!
    @IBOutlet var profileImageChange: UIButton!
    
    //Information Input Set
    @IBOutlet var userNickName: UITextField!
    @IBOutlet var userHight: UITextField!
    @IBOutlet var userWeight: UITextField!
    
    //바탕 색상 설정, dlalwl fltmxm 
    let customGreen: UIColor = UIColor(red: 65/255, green: 148/255, blue: 144/255, alpha: 1)
    let imgList = ["1-1", "1-2", "1-3", "1-4", "1-5", "1-6", "1-7", "1-8", "1-9"]

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = customGreen
        
        userNickName.placeholder = "닉네임을 설정해주세요"
        userNickName.text = UserDefaults.standard.string(forKey: "NickName")
        userHight.placeholder = "키(cm)를 설정해주세요"
        userHight.text = UserDefaults.standard.string(forKey: "Hight")
        userWeight.placeholder = "몸무게(kg)를 설정해주세요"
        userWeight.text = UserDefaults.standard.string(forKey: "Weight")
        
        defaultImage()
        
        profileImageChange.tintColor = .white
        userInformationSave.title = "저장"
        userInformationSave.tintColor = .white
        // Do any additional setup after loading the view.
    }
    
    //텝키로 키보드 숨기기
    @IBAction func tapGestureKybordHide(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    //세이브 버튼 클릭
    @IBAction func btnUserInformationSvae(_ sender: UIBarButtonItem) {
        setNickName("NickName")
        setHight("Hight")
        setWeight("Weight")
        setImage("ImgNum")
    }
    
    //프로필 이미지 교체 버튼 클릭
    @IBAction func btnProfileImageChange(_ sender: UIButton) {
        imageChange("number")
    }
    
    //프로필 이미지 교체
    func imageChange( _ key: String) {
        let countNum = UserDefaults.standard.integer(forKey: key)
        if countNum < 8 {
            UserDefaults.standard.set(countNum+1, forKey: key)
        } else {
            UserDefaults.standard.set(0, forKey: key)
        }
        let updateCountNum = UserDefaults.standard.integer(forKey: key)
        profileImage.image = UIImage.init(named: imgList[updateCountNum])
    }
    
    //입력한 닉네임을 저장
    func setNickName( _ key: String) {
        let userNickNameSet = userNickName.text
        UserDefaults.standard.set(userNickNameSet, forKey: key)
        userNickName.text = UserDefaults.standard.string(forKey: key)
    }
    
    //입력한 키를 저장
    func setHight( _ key: String) {
        let userHightSet = userHight.text
        UserDefaults.standard.set(userHightSet, forKey: key)
        userHight.text = UserDefaults.standard.string(forKey: key)
    }
    
    //입력한 몸무계를 저장
    func setWeight( _ key: String) {
        let userWeightSet = userWeight.text
        UserDefaults.standard.set(userWeightSet, forKey: key)
        userWeight.text = UserDefaults.standard.string(forKey: key)!
    }
    
    //선택되어있는 이미지를 저장
    func setImage( _ key: String) {
        let imageNum = UserDefaults.standard.integer(forKey: "number")
        UserDefaults.standard.set(imageNum, forKey: key)
        let updateImageNum = UserDefaults.standard.integer(forKey: key)
        profileImage.image = UIImage.init(named: imgList[updateImageNum])
    }
    
    //Default이미지 설정
    func defaultImage() {
        let imageNum = UserDefaults.standard.integer(forKey: "ImgNum")
        if imageNum != 0 {
            profileImage.image = UIImage.init(named: imgList[imageNum])
        }else {
            profileImage.image = UIImage.init(named: "1-1")
        }
    }
}
