import ObjectMapper

class MappableModel: Mappable {
    var status: String = ""
    var totalResults: Int = 0
    var code: String = ""
    var message: String = ""
    var articles = [MappableArticle]()
    
    
    func mapping(map: Map) {
        status <- map["status"]
        totalResults <- map["totalResults"]
        code <- map["code"]
        message <- map["message"]
        articles <- map["articles"]
        
    }
    required init?(map: Map) {
        
    }
    
}


struct MappableArticle: Mappable {
    var source = [String:String?]()
    var author: String = ""
    var title: String = ""
    var description: String = ""
    var url: String = ""
    var urlToImage: String = ""
    var publishedAt:String = ""
    var content: String = ""
    
    mutating func mapping(map: Map) {
        source <- map["sourse"]
        author <- map["author"]
        title <- map["title"]
        description <- map["description"]
        url <- map["url"]
        urlToImage <- map["urlToImage"]
        publishedAt <- map["publishedAt"]
        content <- map["content"]
        
    }
    
    init?(map: Map) {
        
    }
}



