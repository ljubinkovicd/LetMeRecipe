//
//  RecipeCell.swift
//  LetMeRecipe
//
//  Created by Dorde Ljubinkovic on 10/10/17.
//  Copyright © 2017 Dorde Ljubinkovic. All rights reserved.
//

import UIKit

class RecipeCell: UICollectionViewCell {
    
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var recipeImageView: UIImageView!
    @IBOutlet weak var recipeTitleLabel: UILabel!
    @IBOutlet weak var numberOfCaloriesLabel: UILabel!
    @IBOutlet weak var numberOfIngredientsLabel: UILabel!
    @IBOutlet weak var recipeSourceLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        containerView.layer.cornerRadius = 8
        containerView.layer.masksToBounds = true
        
//        let selectedView = UIView(frame: CGRect.zero)
//        selectedView.backgroundColor = UIColor(red: 20/255, green: 160/255, blue: 160/255, alpha: 0.5)
//
//        selectedBackgroundView = selectedView
    }
    
//    var recipe: Recipe? {
//        didSet {
//            recipeTitleLabel.text = recipe?.title
//        }
//    }
    
}
