//
//  RecipeDetailController.swift
//  LetMeRecipe
//
//  Created by Dorde Ljubinkovic on 10/11/17.
//  Copyright © 2017 Dorde Ljubinkovic. All rights reserved.
//

import UIKit

class RecipeDetailController: UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var containerView: UIView!
    
    var recipe: Recipe? = nil
    var recipeImg: UIImage? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLayout(recipe)
        
        //            recipeDetailsLabel.sizeToFit()
        //            recipeDetailsLabel.sizeThatFits(CGSize(width: recipeDetailsLabel.frame.size.width, height: formattedIngredientLines.height(withConstrainedWidth: recipeDetailsLabel.frame.size.width, font: .boldSystemFont(ofSize: 18))))
        
        //            recipeDetailsLabel.text = formattedIngredientLines
        
        //            recipeDetailsLabel.backgroundColor = UIColor.red
        
        
        //            recipeImageView.image = recipeImg
    }
    
    // MARK: - Configuration method(s)
    func setupLayout(_ recipe: Recipe?) {
        
        if let recipe = recipe {
            
            // Get the superview's layout
            let margins = containerView.layoutMarginsGuide
            
            let recipeImgView = UIImageView()
            recipeImgView.translatesAutoresizingMaskIntoConstraints = false
            let recipeTitleLabel = UILabel()
            recipeTitleLabel.translatesAutoresizingMaskIntoConstraints = false
            let recipeIngredientsLabel = UILabel()
            recipeIngredientsLabel.translatesAutoresizingMaskIntoConstraints = false
            let recipeRedirectUrlButton = UIButton()
            recipeRedirectUrlButton.translatesAutoresizingMaskIntoConstraints = false
            
            containerView.addSubview(recipeTitleLabel)
            containerView.addSubview(recipeImgView)
            containerView.addSubview(recipeIngredientsLabel)
            containerView.addSubview(recipeRedirectUrlButton)
            
            recipeTitleLabel.topAnchor.constraint(equalTo: margins.topAnchor, constant: 8.0).isActive = true
            recipeTitleLabel.centerXAnchor.constraint(equalTo: margins.centerXAnchor).isActive = true
            recipeTitleLabel.widthAnchor.constraint(equalTo: margins.widthAnchor, multiplier: 1.0).isActive = true
            recipeTitleLabel.font = UIFont(name: "HelveticaNeue-Bold", size: 30)
            recipeTitleLabel.textAlignment = .center
            recipeTitleLabel.numberOfLines = 0
            recipeTitleLabel.lineBreakMode = .byWordWrapping
            
            recipeImgView.topAnchor.constraint(equalTo: recipeTitleLabel.bottomAnchor, constant: 16.0).isActive = true
            recipeImgView.leadingAnchor.constraint(equalTo: margins.leadingAnchor).isActive = true
            recipeImgView.trailingAnchor.constraint(equalTo: margins.trailingAnchor).isActive = true
            recipeImgView.heightAnchor.constraint(equalTo: recipeImgView.widthAnchor, multiplier: 0.5).isActive = true
            recipeImgView.contentMode = .scaleAspectFill
            recipeImgView.layer.cornerRadius = 8.0
            recipeImgView.layer.masksToBounds = true
            recipeImgView.image = UIImage(named: "placeholderImg")
            
            recipeIngredientsLabel.topAnchor.constraint(equalTo: recipeImgView.bottomAnchor, constant: 16.0).isActive = true
            recipeIngredientsLabel.leadingAnchor.constraint(equalTo: margins.leadingAnchor, constant: 8.0).isActive = true
            recipeIngredientsLabel.trailingAnchor.constraint(equalTo: margins.trailingAnchor).isActive = true
            recipeIngredientsLabel.numberOfLines = 0
            recipeIngredientsLabel.lineBreakMode = .byWordWrapping
            
            recipeRedirectUrlButton.topAnchor.constraint(equalTo: recipeIngredientsLabel.bottomAnchor, constant: 16.0).isActive = true
            // It has to be greater than or equal to 8.0, so basically, the button will keep "pushing" down as the label expands, and always keep at least 8.0 CGFloat distance
            recipeRedirectUrlButton.bottomAnchor.constraint(greaterThanOrEqualTo: margins.bottomAnchor, constant: 8.0).isActive = true
            recipeRedirectUrlButton.widthAnchor.constraint(equalTo: margins.widthAnchor, multiplier: 0.5).isActive = true
            recipeRedirectUrlButton.centerXAnchor.constraint(equalTo: margins.centerXAnchor).isActive = true
            recipeRedirectUrlButton.heightAnchor.constraint(equalToConstant: 64).isActive = true
            recipeRedirectUrlButton.layer.cornerRadius = 8.0
            recipeRedirectUrlButton.layer.masksToBounds = true
            
            recipeTitleLabel.text = recipe.title
            
            recipeImgView.image = recipeImg
            
            var formattedIngredientLines = ""
            for line in recipe.ingredientLines {
                formattedIngredientLines += "• " + line + "\n"
            }
            
            recipeIngredientsLabel.frame = CGRect(x: recipeIngredientsLabel.frame.origin.x, y: recipeIngredientsLabel.frame.origin.y, width: recipeIngredientsLabel.frame.width, height: recipeIngredientsLabel.optimalHeight + 200)
            
            print(formattedIngredientLines)
            
            recipeIngredientsLabel.text = formattedIngredientLines
            
            recipeRedirectUrlButton.setTitle("Preparation", for: .normal)
            recipeRedirectUrlButton.backgroundColor = UIColor(red: 10/255, green: 80/255, blue: 80/255, alpha: 1)
            recipeRedirectUrlButton.addTarget(self, action: #selector(initiateWebView), for: .touchUpInside)
        }
    }
    
    @objc func initiateWebView() {
        performSegue(withIdentifier: "toWebViewSegue", sender: self)
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        switch segue.identifier! {
        case "toWebViewSegue":
            let vc = segue.destination as! RecipeWebView
            vc.recipe = recipe
        default:
            return
        }
    }
}

extension UILabel {
    var optimalHeight: CGFloat {
        get {
            let label = UILabel(frame: CGRect(x: 0, y: 0, width: self.bounds.width, height: CGFloat.greatestFiniteMagnitude))
            label.numberOfLines = 0
            label.lineBreakMode = .byWordWrapping
            label.font = self.font
            label.text = self.text
            label.sizeToFit()
            
            return label.frame.height
        }
    }
}

extension String {
    func height(withConstrainedWidth width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [.font: font], context: nil)
        
        return ceil(boundingBox.height)
    }
    
    func width(withConstraintedHeight height: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [.font: font], context: nil)
        
        return ceil(boundingBox.width)
    }
}
