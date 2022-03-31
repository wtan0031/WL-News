//
//  Home.swift
//  WL News
//
//  Created by Tan Wei Liang on 29/10/2017.
//  Copyright © 2017 Tan Wei Liang. All rights reserved.
//

import Foundation

struct Constants {
    static let urlString1 = "https://newsapi.org/v1/articles?source=cnn&sortBy=top&apiKey=11fd246c28ab411f98aa89868f674180"
    
    static let urlString2 = "https://newsapi.org/v1/articles?source=the-new-york-times&sortBy=top&apiKey=11fd246c28ab411f98aa89868f674180"
    
    static let urlString3 = "https://newsapi.org/v1/articles?source=techcrunch&sortBy=top&apiKey=11fd246c28ab411f98aa89868f674180"
    
    static let urlString4 = "https://newsapi.org/v2/top-headlines?country=us&apiKey=11fd246c28ab411f98aa89868f674180"
    
    static let urlString5 = "https://newsapi.org/v1/articles?source=independent&sortBy=top&apiKey=11fd246c28ab411f98aa89868f674180"
}

class Home  {
    
    var url : String?
    var title : String?
    var description : String?
    var urlImage : String?
    var publishedTime : String?
    
    init (homeData : [String : Any]){
        
        if let anUrl = homeData["url"] as? String {
            url = anUrl
        }
        
        if let aTitle = homeData["title"] as? String {
            title = aTitle
        }
        
        if let aDescription = homeData["description"] as? String {
            description = aDescription
        }
        
        if let anUrlImage = homeData["urlToImage"] as? String {
            urlImage = anUrlImage
        }
        
        if let aPublishedTime = homeData["publishedAt"] as? String {
            publishedTime = aPublishedTime
        }
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}
