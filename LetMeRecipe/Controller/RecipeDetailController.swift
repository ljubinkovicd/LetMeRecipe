//
//  RecipeDetailController.swift
//  LetMeRecipe
//
//  Created by Dorde Ljubinkovic on 10/11/17.
//  Copyright © 2017 Dorde Ljubinkovic. All rights reserved.
//

import UIKit

class RecipeDetailController: UIViewController {
    
    @IBOutlet weak var recipeImageView: UIImageView!
    @IBOutlet weak var recipeDetailsLabel: UITextView!
    
    var recipe: Recipe? = nil
    var recipeImg: UIImage? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let recipe = recipe {
            recipeDetailsLabel.text = recipe.ingredients.description
            recipeImageView.image = recipeImg
        }
    }
    
    @IBAction func initiateWebView(_ sender: Any) {
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let vc = segue.destination as! RecipeWebView
        
        vc.recipe = recipe
        
    }
}
