//
//  MovieTableViewController.swift
//  SeSAC.Day.10
//
//  Created by Joonhwan Jeon on 2021/10/13.
//

import UIKit

class MovieTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }

    //1. TableViewCell 화면을 생성
    //2. Prototype Cell의 클래스를 생성한 cell과 연결
    //3. 내부의 객제들을 작성한 cell과 아웃렛으로 연결
    //4. cellForRowAtt 에서 타입 캐스팅 후 사용 가능

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
       return 10
    }
    
    //2. 셀의 디자인 및 데이터 처리 cellForRowAt
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //타입 캐스팅
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "movieCell", for: indexPath) as? MovieTableViewCell else {
            return UITableViewCell()
        }
        
        cell.posterImageView.backgroundColor = .red
        cell.titleLabel.text = "7번방의 선물"
        cell.releaseDateLabel.text = "2020.01.01"
        cell.overviewLabel.text = "영화 줄거리가 보이는곳 입니다. 영화 줄거리가 보이는곳 입니다. 영화 줄거리가 보이는곳 입니다. 영화 줄거리가 보이는곳 입니다. 영화 줄거리가 보이는곳 입니다."
        cell.overviewLabel.numberOfLines = 0
        
        return cell
        
    }
    //3. 셀의 높이 heightForRowAt
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        //디바이스별 높이 적용
        return UIScreen.main.bounds.height / 5
        
    }

    
}
