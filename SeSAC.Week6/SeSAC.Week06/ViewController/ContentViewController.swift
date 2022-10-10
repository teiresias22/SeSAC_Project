import UIKit
import RealmSwift

class ContentViewController: UIViewController {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var dateSetButton: UIButton!
    @IBOutlet weak var mainTextView: UITextView!
    
    let localRealm = try! Realm()

    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.image = UIImage(named: "IMG_0641 Small")
        
        title = "Content"
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "xmark"), style: .plain, target: self, action: #selector(closeButtonClicked))
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "save", style: .plain, target: self, action: #selector(saveButtonClicked))
        
        print("Realm is located at:", localRealm.configuration.fileURL!)
        // Do any additional setup after loading the view.
    }
    
    @objc
    func closeButtonClicked() {
        self.presentingViewController?.dismiss(animated: true)
    }
    
    @objc
    func saveButtonClicked() {
        
        let task = UserDiary(diaryTitle: titleTextField.text!,
                             content: mainTextView.text!,
                             writeDate: Date(),
                             regDate: Date() )
        try! localRealm.write {
            localRealm.add(task)
            saveImageToDirectory(imageName: "\(task._id).jpg", image: imageView.image!)
        }
    }
    
    func saveImageToDirectory(imageName: String, image: UIImage) {
        //1. 이미지 저장할 경로 설정 : 도큐먼트 폴더 (.documentDirectory), FileManager
        guard let documentDirctory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return }
        
        //2. 이미지 파일 이름 & 최종 경로 설정
        //Desktop/jack/ios/folder/222.png
        let imageURL = documentDirctory.appendingPathComponent(imageName)
        
        //3, 이미지 압축
        guard let data = image.jpegData(compressionQuality: 0.2) else { return }
        
        //4. 이미지 저장: 동일한 경로에 이미지를 저장하게 될 경우, 덮어쓰기
        //4-1. 이미지 경로 여부 확인
        if FileManager.default.fileExists(atPath: imageURL.path) {
            //4-2 기존 경로에 있는 이미지 삭제
            do {
                try FileManager.default.removeItem(at: imageURL)
                print("이미지 삭제 완료")
            } catch {
                print("이미지를 삭제하지 못했습니다.")
            }
        }
        
        //5. 이미지를 도큐먼트에 저장
        do {
            try data.write(to: imageURL)
        } catch {
            print("Error")
        }
    }
    
}
