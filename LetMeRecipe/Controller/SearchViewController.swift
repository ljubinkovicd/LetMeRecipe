//
//  ViewController.swift
//  LetMeRecipe
//
//  Created by Dorde Ljubinkovic on 10/10/17.
//  Copyright © 2017 Dorde Ljubinkovic. All rights reserved.
//

import UIKit
import Alamofire

class SearchViewController: UIViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var collectionView: UICollectionView!
    
    final let APP_ID = "ae3627c5"
    final let APP_KEY = "db8fa6e8466d85b879d51866201bd0b8"
    
    var searchResults: [String] = []
    var searchImages: [UIImage] = []
    
    override func viewDidLoad() {
        
        // TODO: Change this
        // This tells the table view to add a 56-point margin at the top, made up of 20 points for the status bar and 44 points for the Search Bar.
        collectionView.contentInset = UIEdgeInsetsMake(56, 0, 0, 0)
        
//        let width = (collectionView!.frame.width / 3) - 5
//        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
//        layout.itemSize = CGSize(width: width, height: 200)
    }
    
    
    
    // IZ KNJIGE
    //    func iTunesURL(searchText: String) -> URL {
    //    let escapedSearchText = searchText.addingPercentEncoding(
    //        withAllowedCharacters: CharacterSet.urlQueryAllowed)!
    //        let urlString = String(format:
    //            "https://itunes.apple.com/search?term=%@", searchText)
    //        let url = URL(string: urlString)
    //        return url!
    //
    //    }
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
}

extension SearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print("The search text is: '\(searchBar.text!)'")
        
        let myRequest = "https://api.edamam.com/search?q=\(searchBar.text!)&app_id=\(APP_ID)&app_key=\(APP_KEY)"
        
        Alamofire.request(myRequest).responseObject { (response: DataResponse<RecipeList>) in
            
            self.searchResults = []
            self.searchImages = []
            
            if let recipes = response.result.value {
                
                for i in 0..<recipes.recipeMetaData.count {
                    self.searchResults.append(recipes.recipeMetaData[i].recipe.title)
                }
            }
            
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    
    func position(for bar: UIBarPositioning) -> UIBarPosition {
        return .topAttached
    }
}

extension SearchViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return searchResults.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RecipeCell", for: indexPath) as! RecipeCell
        
        cell.recipeTitleLabel.text = searchResults[indexPath.row]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Selected item: \(indexPath.row)")
    }
    
    // MARK: - Custom methods
}

extension SearchViewController: UICollectionViewDelegate {
    
}

