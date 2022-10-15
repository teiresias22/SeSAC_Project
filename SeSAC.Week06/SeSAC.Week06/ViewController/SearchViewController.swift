import UIKit
import RealmSwift

class SearchViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    let localRealm = try! Realm()
    var tasks: Results<UserDiary>!
    
    //var tasks: Results<UserDiary>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self

        let nibName = UINib(nibName: SearchTableViewCell.identifier, bundle: nil)
        
        tableView.register(nibName, forCellReuseIdentifier: SearchTableViewCell.identifier)
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        tasks = localRealm.objects(UserDiary.self)
        tableView.reloadData()
    }
    
    //도큐먼트 폴더 경로 -> 이미지 찾기 -> UIImage -> UIimageView
    func loadImageFromDocumentDirectory(imageName: String) -> UIImage? {
        
        let documentDirectory = FileManager.SearchPathDirectory.documentDirectory
        let userDomainMask = FileManager.SearchPathDomainMask.userDomainMask
        let path = NSSearchPathForDirectoriesInDomains(documentDirectory, userDomainMask, true)
        
        if let direcoryPath = path.first {
            let imageURL = URL(fileURLWithPath: direcoryPath).appendingPathComponent(imageName)
            return UIImage(contentsOfFile: imageURL.path)
        } else {
            return UIImage(systemName: "star")
        }
    }
    
    func deleteImageFromDocumentDirectory(imageName: String) {
        //1. 이미지 저장할 경로 설정 : 도큐먼트 폴더 (.documentDirectory), FileManager
        guard let documentDirctory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return }
        
        //2. 이미지 파일 이름 & 최종 경로 설정
        //Desktop/jack/ios/folder/222.png
        let imageURL = documentDirctory.appendingPathComponent(imageName)
        
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
    }
    
}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchTableViewCell.identifier, for: indexPath) as? SearchTableViewCell else {
            return UITableViewCell()
        }
        let row = tasks[indexPath.row]
        
        cell.daiaryImageView.image = loadImageFromDocumentDirectory(imageName: "\(row._id).jpg")
        
        cell.titleLabel.text = row.diaryTitle
        
        let format = DateFormatter()
        format.dateFormat = "yyyy년 MM월 dd일"
        cell.dateLabel.text = format.string(from: row.writeDate)
        
        //cell.dateLabel.text = "\(row.writeDate)"
        cell.mainTextLabel.text = row.content
        
        cell.daiaryImageView.backgroundColor = .systemCyan
        cell.daiaryImageView.clipsToBounds = true
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UIScreen.main.bounds.height / 8
    }
    
    //본래는 화면전환 + 값 전달 후 새로운 화면에서 수정이 적합
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let taskToUpdate = tasks[indexPath.row]
        // 수정 - 레코드에 대한 값 수정
        try! localRealm.write {
            taskToUpdate.diaryTitle = "새롭게 수정해봅시다."
            taskToUpdate.content = "새로운 내용"
            tableView.reloadData()
        }
        
        /* 2. 일괄 수정
        try! localRealm.write {
            tasks.setValue(Date(), forKey: "writeDate")
            tasks.setValue("일괄수정하는거", forKey: "content")
            tableView.reloadData()
        }*/
        
        /*3. 수정 pk 기준으로 수정할 때 사용 (권장x)
        try! localRealm.write {
            let update = UserDiary(value: ["_id": taskToUpdate._id, "diaryTitle": "얘만 바꾸고 싶어"])
            localRealm.add(update, update: .modified)
            tableView.reloadData()
        }*/
        
        /* 3을 바탕으로 변형
        try! localRealm.write {
            localRealm.create(UserDiary.self, value: ["_id": taskToUpdate._id, "diaryTitle": "얘만 바꾸고 싶어!"], update: .modified)
            tableView.reloadData()
        }*/
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let row = tasks[indexPath.row]
        
        try! localRealm.write{
            deleteImageFromDocumentDirectory(imageName: "\(row._id).jpg")
            localRealm.delete(row)
            tableView.reloadData()
        }
    }
    
    
}
