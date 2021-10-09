import UIKit
import Alamofire
import ObjectMapper
import Kingfisher
import SafariServices



class NewsTableViewController: UIViewController {
    @IBOutlet weak var parsingTableView: UITableView!
   
    var newsType:newsType?
    let newsRequest = ApiNewsRequest()
    let nib = UINib(nibName:"NewsCell", bundle: nil)
    var articleArray = [Article]()
    var mappableArticles = [MappableArticle]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Назад", style: .done, target: self, action: #selector(goBack))
        navigationItem.setHidesBackButton(true, animated: false)
        
        
        parsingTableView.dataSource = self
        parsingTableView.delegate = self
        parsingTableView.register(nib, forCellReuseIdentifier:"NewsCell")
        
        switch newsType {
        case .country:
            getCountryNewsFromAPI()
        case .date:
            getTodayNewsFromApi()
        case .none:
            return
        }
    }
    
    func getTodayNewsFromApi(){
        var mappableModelArray:MappableModel?
        newsRequest.apiDateRequest.validate().responseJSON { (response) in
            guard let unwrResponse = response.value else {
                if let errorText:String = response.error?.errorDescription {
                    print(errorText)
                }
                return
                
            }
            mappableModelArray = Mapper<MappableModel>().map(JSONObject: unwrResponse)
            guard mappableModelArray != nil else {return}
            self.mappableArticles = mappableModelArray!.articles
            self.parsingTableView.reloadData()
        
            if let statusText:String = mappableModelArray?.status,
               let messageText: String = mappableModelArray?.message
            {
                print(statusText)
                print(messageText)
            }
            
        }
        
    }
    
    
    func getCountryNewsFromAPI(){
        newsRequest.apiCountryRequest.validate().responseDecodable(of: NewsModel.self) { (response) in
            guard let newsData = response.value
            else {
                if let errorText = response.error?.errorDescription {
                    print(errorText)
                }
                return
            }
            print(newsData.status)
            if let message:String = newsData.message {
                print(message)
            }
            self.articleArray = newsData.articles
            self.parsingTableView.reloadData()
        }
        
        
    }
    
    @objc func goBack() {
        navigationController?.popViewController(animated: true)
        dismiss(animated: false, completion: nil)
    }
    
}



extension NewsTableViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch newsType {
        case .country: return articleArray.count
        case .date:
            return mappableArticles.count
        case .none: return 0
        }
        
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = parsingTableView.dequeueReusableCell(withIdentifier: "NewsCell", for: indexPath) as! NewsCell
        
        
        switch newsType {
        case .country:
            if let stringURL = articleArray[indexPath.row].urlToImage {
                let imageURL = URL(string: stringURL)
                cell.imageFromNews.kf.setImage(with: imageURL)
            }
            cell.newsTitle.text = articleArray[indexPath.row].title
            cell.newsDiscription?.text = articleArray[indexPath.row].description
            
        case .date:
            let imageURL = URL(string: mappableArticles[indexPath.row].urlToImage)
            cell.newsTitle.text = mappableArticles[indexPath.row].description
            cell.newsDiscription.text = mappableArticles[indexPath.row].title
            cell.imageFromNews.kf.setImage(with: imageURL)
            
        case .none: return UITableViewCell()
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        switch newsType {
        case .country:
            if let url = articleArray[indexPath.row].url{
                guard let newsURL = URL(string: url) else {break}
                let safariVC = SFSafariViewController(url: newsURL)
                
                present(safariVC, animated: true, completion: nil)
            }
        case .date:
            guard let url = URL(string: mappableArticles[indexPath.row].url) else {break}
            let safariVC = SFSafariViewController(url: url)
            present(safariVC, animated: true, completion: nil)
        case .none:
            break
        }
   
    
       
    }
}

