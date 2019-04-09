//
//  Helper.swift
//  WL News
//
//  Created by Tan Wei Liang on 29/10/2017.
//  Copyright © 2017 Tan Wei Liang. All rights reserved.
//

import Foundation
import UIKit

extension UIImageView {
    func loadImage(from urlString : String) {
        //1. url
        guard let url = URL(string: urlString) else {return}
        
        let session = URLSession.shared
        let task = session.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print("Error : \(error.localizedDescription)")
                return
            }
            
            
            if let data = data {
                DispatchQueue.main.async {
                    self.image = UIImage(data: data)
                }
            }
            
        }
        task.resume()
    }
}



class DateHelper {
    static func createDateString(_ timeStamp: Double) -> String {
        let date = Date(timeIntervalSince1970: timeStamp)
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat  = "dd/MM/yyyy"
        
        return dateFormatter.string(from: date)
    }
    
    static func createTimeString(_ timeStamp: Double) -> String {
        let date = Date(timeIntervalSince1970: timeStamp)
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat  = "hh:mm a"
        
        return dateFormatter.string(from: date)
    }
    
    static func createDateTimeString(_ timeStamp: Double) -> String {
        let date = Date(timeIntervalSince1970: timeStamp)
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat  = "dd/MM/yyyy hh:mm a"
        
        return dateFormatter.string(from: date)
    }
}

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    
}


