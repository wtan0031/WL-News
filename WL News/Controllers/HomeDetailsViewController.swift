//
//  HomeDetailsViewController.swift
//  WL News
//
//  Created by Tan Wei Liang on 29/10/2017.
//  Copyright © 2017 Tan Wei Liang. All rights reserved.
//

import UIKit

class HomeDetailsViewController: UIViewController, UIWebViewDelegate, UITextFieldDelegate {
    
    var selectedNews : Home?
    
    @IBOutlet weak var variableWebView: UIWebView!
    
    @IBOutlet weak var loadingView: UIActivityIndicatorView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        variableWebView.delegate = self
        loadurl(with: (selectedNews?.url)!)
    }
    
    func loadurl(with string: String){
        guard let url = URL(string: string) else {return}
        
        let request = URLRequest(url: url)
        variableWebView.loadRequest(request)
    }
    
    func webViewDidStartLoad(_ webView: UIWebView) {
        loadingView.startAnimating()
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        loadingView.stopAnimating()
    }
    
    func webView(_ webView: UIWebView, didFailLoadWithError error: Error) {
        print("fail with error :\(error.localizedDescription)")
        loadingView.stopAnimating()
    }
    
    
}

