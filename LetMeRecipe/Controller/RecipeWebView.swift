//
//  RecipeWebView.swift
//  LetMeRecipe
//
//  Created by Dorde Ljubinkovic on 10/11/17.
//  Copyright © 2017 Dorde Ljubinkovic. All rights reserved.
//

import UIKit
import WebKit

class RecipeWebView: UIViewController, WKUIDelegate {

    var webView: WKWebView!
    
    var recipe: Recipe? = nil
    
    override func loadView() {
        let webConfiguration = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView.uiDelegate = self
        view = webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let recipe = recipe {
            let myURL = URL(string: recipe.redirectUrl)
            let myRequest = URLRequest(url: myURL!)
            webView.load(myRequest)
        }
    }
}
