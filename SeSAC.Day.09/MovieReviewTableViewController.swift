import UIKit

class MovieReviewTableViewController: UITableViewController {
    
    //Pass Data1. 값을 전달 받을 공간
    var titleSpace: String?

    let movieInformation = MovieInformation()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Pass Data2. 표현
        title = titleSpace ?? "내용이 없을때 타이틀"
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "닫기", style: .plain, target: self, action: #selector(closeButtonClicked))
    }
    
    @objc
    func closeButtonClicked() {
        //Push - Pop
        self.navigationController?.popViewController(animated: true)
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieInformation.list.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MovieReviewTableViewCell.identifier, for: indexPath) as? MovieReviewTableViewCell else {
            return UITableViewCell()
        }
        
        let row = movieInformation.list[indexPath.row]
        
        cell.MoviePoster.image = UIImage(named: row.title)
        cell.lbMovieTitle.text = row.title
        cell.lbMovieOpenDate.text = row.releaseDate
        cell.lbMovieSummery.text = row.overview
        cell.lbMovieSummery.numberOfLines = 0
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UIScreen.main.bounds.height / 5
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let sb = UIStoryboard(name: "MovieStoryboard", bundle: nil)
        
        let vc = sb.instantiateViewController(withIdentifier: "BoxOfficeDetailViewController") as! BoxOfficeDetailViewController
        
        let row = movieInformation.list[indexPath.row]
        
        vc.movieData = row
        
//        vc.releaseDate = row.releaseDate
//        vc.overview = row.overview
//        vc.runtime = row.runtime
//        vc.rate = row.rate
//        vc.movieTitle = row.title
        
        self.navigationController?.pushViewController(vc, animated: true)
    }

}
