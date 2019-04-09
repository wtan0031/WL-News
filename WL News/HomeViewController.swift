//
//  HomeViewController.swift
//  WL News
//
//  Created by Tan Wei Liang on 29/10/2017.
//  Copyright © 2017 Tan Wei Liang. All rights reserved.
//

import UIKit
//import FirebaseAuth
//import FirebaseDatabase

class HomeViewController: UIViewController , UISearchBarDelegate{
    var news : [Home] = []
    var searchActive : Bool = false
    var filtered:[Home] = []
    
    
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.estimatedRowHeight = 350
            tableView.rowHeight = UITableViewAutomaticDimension
            
        }
    }
    @IBOutlet weak var searchTextFieldBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //dismiss keybaord when tap on vc
        //self.hideKeyboardWhenTappedAround()
        
        //tableView.removeGestureRecognizer(tapGesture)
        
        tableView.dataSource = self
        tableView.delegate = self
        searchTextFieldBar.delegate = self
        
        let urlString1 = "https://newsapi.org/v1/articles?source=engadget&sortBy=top&apiKey=11fd246c28ab411f98aa89868f674180"
        let urlString2 = "https://newsapi.org/v1/articles?source=the-new-york-times&sortBy=top&apiKey=11fd246c28ab411f98aa89868f674180"
        let urlString3 = "https://newsapi.org/v1/articles?source=techcrunch&sortBy=top&apiKey=11fd246c28ab411f98aa89868f674180"
        
        fetchData(urlString: urlString1)
        
        fetchData(urlString: urlString2)
        
        fetchData(urlString: urlString3)
        
        // Do any additional setup after loading the view.
    }
    
    
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchActive = true;
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchActive = false;
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchActive = false;
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchActive = false;
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        
        //filtered = data.filter({ (text) -> Bool in
        if searchText.characters.count == 0 {
            
            filtered = news
            
        } else {
            filtered = news.filter({ (item) -> Bool in
                let tmp: NSString = item.title! as NSString
                let range = tmp.range(of: searchText, options: .caseInsensitive)
                return range.location != NSNotFound
            })
        }
        if(filtered.count == 0){
            searchActive = false;
        } else {
            searchActive = true;
        }
        self.tableView.reloadData()
    }
    
    
    
    
    func fetchData(urlString : String) {
        //send API request
        //1.get the url
        //let urlString = "https://newsapi.org/v1/articles?source=ign&sortBy=top&apiKey=11fd246c28ab411f98aa89868f674180"
        guard let url = URL(string: urlString)
            else { return }
        
        //2. Get a URLSession
        let session = URLSession.shared
        
        //3.Create a URLTask
        let task = session.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print("DataTask Error : \(error.localizedDescription)")
                return
            }
            
            
            guard let data = data
                else{
                    print("Invalid Data")
                    return
            }
            
            //print(data)
            //Convert to Json
            
            guard let json = try? JSONSerialization.jsonObject(with: data, options: []),
                let validJson = json as? [String : Any]
                else {
                    return
            }
            
            guard let homeArray = validJson["articles"] as? [[String:Any]]
                else { return }
            
            
            for homeData in homeArray {
                
                let newHome = Home(homeData: homeData)
                self.news.append(newHome)
                
                
            }
            //self.filtered = self.news
            
            // print(self.news.count)
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
            
            
        }
        //4. Start the task
        task.resume()
    }
    
    
}


extension HomeViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(searchActive) {
            return filtered.count
        }
        return news.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //1.get the cell
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "homeCell", for: indexPath) as? HomeTableViewCell else { return UITableViewCell() }
        
        
        var aNews = news[indexPath.row]
        
        if searchActive {
            aNews = filtered[indexPath.row]
        } else {
            aNews = news[indexPath.row]
        }
        
        
        cell.newsArticleTitleLabel.text = aNews.title
        cell.newsSummaryTextView.text = aNews.description
        cell.newsPublishedTime.text = aNews.publishedTime
        cell.newsImageView.loadImage(from: aNews.urlImage ?? "")
        
        //2.setup fot the time format
        let RFC3339DateFormatter = DateFormatter()
        RFC3339DateFormatter.locale = Locale(identifier: "en_US_POSIX")
        RFC3339DateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
        RFC3339DateFormatter.timeZone = TimeZone(secondsFromGMT: 4800)
        guard let string = cell.newsPublishedTime.text else { return UITableViewCell() }
        guard let date1 = RFC3339DateFormatter.date(from: string) else { return UITableViewCell() }
        
        let newDate = DateHelper.createDateTimeString(date1.timeIntervalSince1970)
        cell.newsPublishedTime.text = newDate   //String(describing: date1)
        
        
        //cell.tag = indexPath.row
        
        
        //        if searchActive {
        //            let filter = filtered[indexPath.row]
        //            cell.newsArticleTitleLabel.text = filter.title
        //            //cell.fullnameLabel.text = "\(filter.fullname) Following"
        //
        //            let imageURL = filter.urlImage
        //            cell.newsImageView.loadImage(from: imageURL!)
        //
        //        } else {
        //            let aNews = news[indexPath.row]
        //            cell.newsArticleTitleLabel.text = aNews.title
        //            //cell.fullnameLa.text = "\(aNews.fullname) Following"
        //
        //            let imageURL = aNews.urlImage
        //            cell.newsImageView.loadImage(from: imageURL!)
        //        }
        
        //        DispatchQueue.main.async {
        //            if cell.tag == indexPath.row {
        //                guard let urlImage = aNews.urlImage else
        //                { return }
        //                cell.newsImageView.loadImage(from: urlImage)
        //            }
        //        }
        
        
        return cell
    }
    
}

extension HomeViewController : UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //move to the next view
        guard let targetVC = storyboard?.instantiateViewController(withIdentifier: "HomeDetailsViewController" )
            as? HomeDetailsViewController
            else { return }
        //setup
        targetVC.selectedNews = news[indexPath.row]
        
        navigationController?.pushViewController(targetVC, animated: true)
    }
}

