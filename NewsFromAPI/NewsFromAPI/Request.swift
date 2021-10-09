import Alamofire
import ObjectMapper

class ApiNewsRequest {
    
    static let apiKey = "3c342e9808fe43d7b64890f509c68359"
    private static let countryURL = URLStrings().apiCountryURL
    private static let dateURL = URLStrings().apiDateURL
    
    let apiCountryRequest = AF.request(countryURL,headers: ["X-Api-Key":apiKey])
    let apiDateRequest = AF.request(dateURL,headers: ["X-Api-Key":apiKey])
}




