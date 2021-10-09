import UIKit

class StartViewController: UIViewController {
    
  override func viewDidLoad() {
        super.viewDidLoad()
      
  }

        @IBAction func countryNewsButtonPushed(_ sender: UIButton) {
        guard let navVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "NewsTableViewController") as? NewsTableViewController else {return}
        navVC.newsType = .country
        guard let navigator = navigationController else {return}
        navigator.pushViewController(navVC, animated: true)
    }
    
    @IBAction func todayNewsButtonPushed(_ sender: UIButton) {
        guard let navVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "NewsTableViewController") as? NewsTableViewController else {return}
        navVC.newsType = .date
        guard let navigator = navigationController else {return}
        navigator.pushViewController(navVC, animated: true)  
    }
}
