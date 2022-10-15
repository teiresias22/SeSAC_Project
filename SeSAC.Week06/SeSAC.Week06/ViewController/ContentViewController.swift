import UIKit
import RealmSwift

class ContentViewController: UIViewController {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var dateSetButton: UIButton!
    @IBOutlet weak var mainTextView: UITextView!
    
    let localRealm = try! Realm()
    let format = DateFormatter()

    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.image = UIImage(named: "IMG_0641 Small")
        
        title = "Content"
        
        format.dateFormat = "yyyy년 MM월 dd일"
        let value = format.string(from: Date())
        dateSetButton.setTitle(value, for: .normal)
        
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
        
        //format.dateFormat = "yyyy년 MM월 dd일"
        //extention으로 대체
        
        //let date = dateSetButton.currentTitle!
        //let value = format.date(from: date)!
        //강제해제 연산자를 사용하지 않고 사용
        guard let date = dateSetButton.currentTitle, let value = DateFormatter().customFormat.date(from: date) else { return }
        
        let task = UserDiary(diaryTitle: titleTextField.text!,
                             content: mainTextView.text!,
                             writeDate: value,
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
    
    @IBAction func dateButtonClicked(_ sender: UIButton) {
        let alert = UIAlertController(title: "날짜 선택", message: "날짜를 선택해 주세요", preferredStyle: .alert)
        
        //Alert Customizing
        guard let contentView = self.storyboard?.instantiateViewController(withIdentifier: "AlertDatePickerViewController") as? AlertDatePickerViewController else { print("DatePickerViewController에 오류가 있음")
            return }
                
        contentView.view.backgroundColor = .clear
        //contentView.preferredContentSize = CGSize(width: UIScene.main.bounds.width, height: UIScene.main.bounds.height)
        contentView.preferredContentSize.height = 200
        alert.setValue(contentView, forKey: "ContentViewController")
        
        
        let cancel = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        let ok = UIAlertAction(title: "확인", style: .default) { _ in
            //확인 버튼을 눌렀을때 버튼의 타이틀 변경
            
            let format = DateFormatter()
            format.dateFormat = "yyyy년 MM월 dd일"
            let value = format.string(from: contentView.datePicker.date)
            
            self.dateSetButton.setTitle(value, for: .normal)
        }
        
        alert.addAction(cancel)
        alert.addAction(ok)
        self.present(alert, animated: true, completion: nil)
        
        
        
    }
    
}
