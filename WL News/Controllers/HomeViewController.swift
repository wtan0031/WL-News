//
//  HomeViewController.swift
//  WL News
//
//  Created by Tan Wei Liang on 29/10/2017.
//  Copyright © 2017 Tan Wei Liang. All rights reserved.
//

import UIKit

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
        
        tableView.dataSource = self
        tableView.delegate = self
        searchTextFieldBar.delegate = self
        
        fetchData(urlString: Constants.urlString1)
        fetchData(urlString: Constants.urlString2)
        fetchData(urlString: Constants.urlString3)
        fetchData(urlString: Constants.urlString4)
        fetchData(urlString: Constants.urlString5)
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
        
        if searchText.count == 0 {
            
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
                return }
            
            //Convert to Json
            guard let json = try? JSONSerialization.jsonObject(with: data, options: []),
                  let validJson = json as? [String : Any] else { return }
            
            guard let homeArray = validJson["articles"] as? [[String:Any]]
            else { return }
            
            for homeData in homeArray {
                let newHome = Home(homeData: homeData)
                self.news.append(newHome)
            }
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
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "homeCell", for: indexPath) as? HomeTableViewCell else { return UITableViewCell() }
        
        var aNews = news[indexPath.row]
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let someDate = formatter.string(from: Date())
        
        if searchActive {
            aNews = filtered[indexPath.row]
        } else {
            aNews = news[indexPath.row]
        }
        
        cell.newsArticleTitleLabel.text = aNews.title
        cell.newsSummaryTextView.text = aNews.description
        
        if aNews.publishedTime == nil {
            cell.newsPublishedTime.text = "\(someDate)T17:01:00Z"
        } else {
            cell.newsPublishedTime.text = aNews.publishedTime
        }
        cell.newsImageView.loadImage(from: aNews.urlImage ?? "")
        
        let RFC3339DateFormatter = DateFormatter()
        RFC3339DateFormatter.locale = Locale(identifier: "en_US_POSIX")
        RFC3339DateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
        RFC3339DateFormatter.timeZone = TimeZone(secondsFromGMT: 4800)
        guard let string = cell.newsPublishedTime.text else { return UITableViewCell() }
        guard let date1 = RFC3339DateFormatter.date(from: string) else { return UITableViewCell() }
        
        let newDate = DateHelper.createDateTimeString(date1.timeIntervalSince1970)
        cell.newsPublishedTime.text = newDate
        
        return cell
    }
    
}

extension HomeViewController : UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //move to the next view
        guard let targetVC = storyboard?.instantiateViewController(withIdentifier: "HomeDetailsViewController" )
                as? HomeDetailsViewController
        else { return }
        targetVC.selectedNews = news[indexPath.row]
        
        navigationController?.pushViewController(targetVC, animated: true)
    }
}

