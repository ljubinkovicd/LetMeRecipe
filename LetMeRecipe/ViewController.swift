//
//  ViewController.swift
//  LetMeRecipe
//
//  Created by Dorde Ljubinkovic on 10/10/17.
//  Copyright © 2017 Dorde Ljubinkovic. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController {
    
    final let APP_ID = "ae3627c5"
    final let APP_KEY = "db8fa6e8466d85b879d51866201bd0b8"
    
    override func viewDidLoad() {
        
        let userInput = "chicken"
        let myRequest = "https://api.edamam.com/search?q=\(userInput)&app_id=\(APP_ID)&app_key=\(APP_KEY)"
        
        Alamofire.request(myRequest).responseObject { (response: DataResponse<RecipeList>) in
            
            print("\(response.result.value!)")
        }
    }
    
}

