//
//  ViewController.swift
//  LetMeRecipe
//
//  Created by Dorde Ljubinkovic on 10/10/17.
//  Copyright © 2017 Dorde Ljubinkovic. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

class SearchViewController: UIViewController {
    
    struct CollectionViewCellIdentifiers {
        static let recipeCell = "RecipeCell"
        static let nothingFoundCell = "NothingFoundCell"
        static let loadingCell = "NothingFoundCell"
    }
    
    struct ApiKeys {
        static let appId = "ae3627c5"
        static let appKey = "db8fa6e8466d85b879d51866201bd0b8"
    }
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var loadingActivityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    var searchRecipeResults: [Recipe] = []
    var hasSearched: Bool = false
    var isLoading: Bool = false
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
        super.viewWillAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
        super.viewWillDisappear(animated)
    }
    
    override func viewDidLoad() {
        // TODO: Change this
        // This tells the table view to add a 56-point margin at the top, made up of 20 points for the status bar and 44 points for the Search Bar.
        collectionView.contentInset = UIEdgeInsetsMake(100, 0, 0, 0)
        
        searchBar.becomeFirstResponder()
        
        //        let width = (collectionView!.frame.width / 3) - 5
        //        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        //        layout.itemSize = CGSize(width: width, height: 200)
    }
    
    @IBAction func segmentChanged(_ sender: UISegmentedControl) {
        print("Segment changed: \(sender.selectedSegmentIndex)")
        performSearch()
    }
    
    // MARK: - Custom methods
    func startLoading() {
        isLoading = true
        collectionView.reloadData()
        
        loadingActivityIndicator.startAnimating()
    }
    
    func stopLoading() {
        isLoading = false
        
        loadingActivityIndicator.stopAnimating()
    }
    
    // IZ KNJIGE
    func edamamURL(searchText: String, category: Int) -> URL {
        let dietType: String
        switch category {
            case 1: dietType = "high-fiber"
            case 2: dietType = "low-fat"
            case 3: dietType = "low-carb"
            default: dietType = "high-protein"
        }
        
        let escapedSearchText = searchText.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!
        let urlString = String(format:
            "https://api.edamam.com/search?q=%@&app_id=\(ApiKeys.appId)&app_key=\(ApiKeys.appKey)&diet=%@", escapedSearchText, dietType)
        let url = URL(string: urlString)
        
        return url!
    }
    //
    //
    //    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
    //        if !searchBar.text!.isEmpty {
    //            searchBar.resignFirstResponder()
    //            hasSearched = true
    //            searchResults = []
    //            let url = iTunesURL(searchText: searchBar.text!)
    //            print("URL: '\(url)'")
    //            if let jsonString = performStoreRequest(with: url) {
    //                print("Received JSON string '\(jsonString)'")
    //            }
    //            collectionView.reloadData()
    //
    //        }
    //    }
    //    func performStoreRequest(with url: URL) -> String? {
    //        do {
    //            return try String(contentsOf: url, encoding: .utf8)
    //        } catch {
    //            print("Download Error: \(error)")
    //            return nil
    //        } }
    //    func showNetworkError() {
    //        let alert = UIAlertController(
    //            title: "Whoops...",
    //            message:
    //            "There was an error reading from the iTunes Store. Please try again.",
    //            preferredStyle: .alert)
    //        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
    //        alert.addAction(action)
    //        present(alert, animated: true, completion: nil)
    //    }
    //    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
    //        if !searchBar.text!.isEmpty {
    //            ...
    //            if let jsonString = performStoreRequestWithURL(url) {
    //                if let jsonDictionary = parseJSON(jsonString) {
    //                    print("Dictionary \(jsonDictionary)")
    //                    tableView.reloadData()         // this has changed
    //                    return
    //                } }
    //        } }
    //    showNetworkError()
    //    // this is new
}

extension SearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
    
        performSearch()
    }
    
    func position(for bar: UIBarPositioning) -> UIBarPosition {
        return .topAttached
    }
    
    // MARK: - Custom methods
    func performSearch() {
        if !searchBar.text!.isEmpty {
            print("The search text is: '\(searchBar.text!)'")
            
            hasSearched = true
            startLoading()
            
            // No longer listen to keyboard input
            searchBar.resignFirstResponder()
            
//            let myRequest = "https://api.edamam.com/search?q=\(searchBar.text!)&app_id=\(ApiKeys.appId)&app_key=\(ApiKeys.appKey)"
            let myRequest = edamamURL(searchText: searchBar.text!, category: segmentedControl.selectedSegmentIndex)
            
            print(myRequest)
            
            Alamofire.request(myRequest).responseObject { (response: DataResponse<RecipeList>) in
                
                self.searchRecipeResults = []
                
                if let recipes = response.result.value {
                    
                    if recipes.recipeMetaData.count != 0 {
                        for i in 0..<recipes.recipeMetaData.count {
                            self.searchRecipeResults.append(recipes.recipeMetaData[i].recipe)
                        }
                    } else {
                        print("Nothing found: \(self.searchRecipeResults.count)")
                    }
                }
                
                // Ascending by calories
                self.searchRecipeResults.sort(by: { ($0.calories < $1.calories) })
                
                DispatchQueue.main.async {
                    self.stopLoading()
                    self.collectionView.reloadData()
                }
            }
        }
    }
}

extension SearchViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if !hasSearched || isLoading {
            return 0
        } else {
            return searchRecipeResults.count != 0 ? searchRecipeResults.count : 1
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCellIdentifiers.recipeCell , for: indexPath) as! RecipeCell
        
        let placeholderImage = UIImage(named: "placeholderImg")
        
        if searchRecipeResults.count == 0 {
            cell.isUserInteractionEnabled = false
            
            cell.recipeTitleLabel!.text = "Nothing Found..."
            cell.recipeImageView.image = placeholderImage
            cell.recipeImageView.layer.cornerRadius = 20.0
            cell.recipeImageView.layer.masksToBounds = true
            
            print(cell.recipeTitleLabel!.text)
        } else {
            cell.isUserInteractionEnabled = true
            
            let recipe = searchRecipeResults[indexPath.row]
            
            cell.recipeTitleLabel.text = recipe.calories.description
            cell.recipeImageView.layer.cornerRadius = 20.0
            cell.recipeImageView.layer.masksToBounds = true
            
            let recipeImgUrl = recipe.mealImgUrl
            
            Alamofire.request(recipeImgUrl).responseImage(completionHandler: { imgResponse in
                
                let url = URL(string: (recipeImgUrl))
                
                let filter = AspectScaledToFillSizeWithRoundedCornersFilter(
                    size: cell.recipeImageView.frame.size,
                    radius: 20.0
                )
                
                cell.recipeImageView.af_setImage(
                    withURL: url!,
                    placeholderImage: placeholderImage,
                    filter: filter,
                    imageTransition: .crossDissolve(0.8)
                )
            })
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Selected item: \(indexPath.row)")
        
        collectionView.deselectItem(at: indexPath, animated: true)
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
//        let myVc = segue.destination as! UINavigationController
//        let vc = myVc.topViewController as! RecipeDetailController
        
        let vc = segue.destination as! RecipeDetailController
        
        if let cell = sender as? RecipeCell,
            let indexPath = self.collectionView.indexPath(for: cell) {
            
            let recipe = self.searchRecipeResults[indexPath.row]
            
            vc.recipe = recipe
        }
    }
}

extension SearchViewController: UICollectionViewDelegate {
    
}

