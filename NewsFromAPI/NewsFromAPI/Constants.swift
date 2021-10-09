import Foundation
import Alamofire
import ObjectMapper

class URLStrings {
    
    let apiCountryURL = "https://newsapi.org/v2/top-headlines?country=ru"
    let apiDateURL = "https://newsapi.org/v2/everything?q=Russia&from=" + currentDate()
    
    
    private static func currentDate() -> String {
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let stringDate = formatter.string(from: date)
        return stringDate
    }
}

enum newsType:String {
    case country = "country"
    case date = "date"
}



