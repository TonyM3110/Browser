//
//  ViewController.swift
//  Browser
//
//  Created by Tony on 19.03.2022.
//

import UIKit
import WebKit

class ViewController: UIViewController {

    @IBOutlet weak var urlTF: UITextField!
    @IBOutlet weak var forwardButton: UIButton!
    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var backButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        urlTF.delegate = self
        webView.navigationDelegate = self
        
        let homePage = "https://www.apple.com"
        let url = URL(string: homePage)
        let request = URLRequest(url: url!)
        urlTF.text = homePage
        
        webView.load(request)
        
        webView.allowsBackForwardNavigationGestures = true
    }

    @IBAction func forwardButtonActiob(_ sender: UIButton) {
        if webView.canGoForward {
            webView.goForward()
        }
    }
    
    @IBAction func backButtonAction(_ sender: UIButton) {
        if webView.canGoBack {
            webView.goBack()
        }
    }
}

extension ViewController: UITextFieldDelegate, WKNavigationDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let urlString = textField.text!
        let url = URL(string: urlString)!
        let request = URLRequest(url: url)
        
        webView.load(request)
        
        textField.resignFirstResponder()
        
        return true
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        urlTF.text = webView.url?.absoluteString
        
        backButton.isEnabled = webView.canGoBack
        forwardButton.isEnabled = webView.canGoForward
    }
}

