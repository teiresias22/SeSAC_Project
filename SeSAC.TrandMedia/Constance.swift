import Foundation

struct APIkey {
    static let TMDB_ID = "aadf45b155b0b2fbdf8ce38f2cbe75ec"
    static let KOBIS_ID = "a11efa14779ad184968362a7548a6b9f"
    
    static let Naver_ID = "CHfbyWsVTB6vKZOdPhrR"
    static let Naver_Secret = "xayOzRnNQk"
}

struct Endpoint {
    static let TMDBTranding = "https://api.themoviedb.org/3/trending/"
    static let TMDBType = "https://api.themoviedb.org/3/"
    static let TMDBImage = "https://image.tmdb.org/t/p/original"
    
    static let NaverSearch = "https://openapi.naver.com/v1/search/"
    
    static let KobisURL = "https://kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json?key=f5eef3421c602c6cb7ea224104795888&targetDt="
}
