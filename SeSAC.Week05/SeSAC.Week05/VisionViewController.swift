import UIKit
import SwiftyJSON
import JGProgressHUD

/*
 카메라: 시뮬레이터 테스트 불가능 -> 런타임 오류 발생
 - ImagePickerViewController -> PHPickerViewController(iOS 14+)
 - iOS14+: 선택 접근 권한 + UI
 */


class VisionViewController: UIViewController {

    @IBOutlet weak var postImageView: UIImageView!
    @IBOutlet weak var resultLabel: UILabel!
    
    //언제 Show, Hide
    let progress = JGProgressHUD()
    let imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imagePicker.sourceType = .photoLibrary
        //편집기능
        imagePicker.allowsEditing = true
        imagePicker.delegate = self
        
        imagePicker.sourceType = .photoLibrary

        // Do any additional setup after loading the view.
    }
    
    @IBAction func photoLibraryButtonClicked(_ sender: UIButton) {
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func requestButtonClicked(_ sender: UIButton) {
        
        progress.show(in: view, animated: true)
        
        visionAPIManager.shared.fetchFaceData(image: postImageView.image!) { Code, json in
            print(json)
            
            self.progress.dismiss(animated: true)
            
            let age = json["result"]["faces"][0]["facial_attributes"]["age"].doubleValue
            self.resultLabel.text = "\(round(age))살 입니다."
            
        }
    }
}

extension VisionViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    //사진을 촬영하거나, 갤러리에서 사진을 선택한 직후에 실행
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        print(#function)
        
        //1. 선택한 사진 가져오기 //편집기능 사용시 originalImage > editImage
        //allowEditing false > editedImage = nil
        if let value = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            //2. 로직: 이미지뷰에 선택한 이미지 보여주기
            postImageView.image = value
        }
        //3. Picker dismiss
        picker.dismiss(animated: true, completion: nil)
    }
    
    //촬영을 취소할때 호출
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        print(#function)
    }
    
}
