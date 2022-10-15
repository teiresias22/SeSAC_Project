//
//  NASAViewController.swift
//  SeSAC.Week13
//
//  Created by Joonhwan Jeon on 2022/01/07.
//

import UIKit

class NASAViewController: BaseViewController {
    
    let imageView = UIImageView()
    let label = UILabel()
    
    var session: URLSession!
    
    var buffer: Data?  {
        didSet {
            let result = Double(buffer?.count ?? 0) / total
            label.text = "\(result * 100)/100"
        }
    }
    
    var total: Double = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        buffer = Data()
        
        request()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        session.finishTasksAndInvalidate() //리소스 정리 : 실행중인 테스크가 종료된 후 정리
//        session.invalidateAndCancel() //리소스 정리 : 모두 다 정리, 실행중인 테스크가 있더라도 종료
        
    }
    
    override func configure() {
        imageView.backgroundColor = .lightGray
        imageView.contentMode = .scaleAspectFill
        label.backgroundColor = .white
        label.textColor = .black
        label.textAlignment = .center
    }
    
    override func setupConstraints() {
        view.addSubview(imageView)
        view.addSubview(label)
        imageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        label.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.height.equalTo(100)
        }
    }
    func request() {
        let url = URL(string: "https://apod.nasa.gov/apod/image/2201/eclipse_EV.jpg")!
        print("request start")
        
//        Detault를 보다 상세하게 설정
//        let configuration = URLSessionConfiguration.default
//        configuration.allowsCellularAccess = false
//        URLSession(configuration: configuration).dataTask(with: url).resume()
        
        session = URLSession(configuration: .default, delegate: self, delegateQueue: .main)
        session.dataTask(with: url).resume()
    }
    
}

extension NASAViewController: URLSessionDataDelegate {
    
    //서버에서 최초로 응답 받은 경우 호출(상태코드)
    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive response: URLResponse) async -> URLSession.ResponseDisposition {
        
        if let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) {
            total = Double(response.value(forHTTPHeaderField: "Content-Length")!)!
            return .allow
        }
        return .cancel
    }
    
    //서버에서 데이터를 받을 때마다 반복적으로 호출됨
    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive data: Data) {
//        print(data)
        buffer?.append(data)
    }
    
    //응답이 완료되었을 때 : Error -> nil
    func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
        if let error = error {
            print("오류가 발생했습니다")
        } else {
            print("성공") //Completionhandler
            
            //buffer에 Data가 모두 채워졌을 때, 이미지로 변환
            guard let buffer = buffer else {
                print("buffer Error")
                return
            }
            
            let image = UIImage(data: buffer)
            imageView.image = image
        }
    }
    
    
    
    
}
