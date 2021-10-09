import Foundation

struct NewsModel: Codable{
    let status: String
    let totalResults: Int
    let code: String?
    let message: String?
    var articles = [Article]()
}

struct Article: Codable {
    var source = [String:String?]()
    let author: String?
    let title: String
    let description: String?
    let url: String?
    let urlToImage: String?
    let publishedAt:String
    let content: String?
}
