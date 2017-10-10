////
////  Test.swift
////  LetMeRecipe
////
////  Created by Dorde Ljubinkovic on 10/10/17.
////  Copyright © 2017 Dorde Ljubinkovic. All rights reserved.
////
//
//import Foundation
//// ResponseCollectionSerializable if we want to get array of these objects, like this one:
////[
////    {
////        "id": 1,
////        "title": "Post #1",
////        "body": "My first blog post"
////    },
////    {
////        "id": 2,
////        "title": "Post #2",
////        "body": "My second blog post"
////    },
////    {
////        "id": 3,
////        "title": "Post #3",
////        "body": "My third blog post"
////    }
////]
//// whereas ResponseObjectSerializable would serialize this json return:
////    {
////        "id": 1,
////        "title": "Post #1",
////        "body": "My first blog post"
////    }
//final class Test: ResponseObjectSerializable, CustomStringConvertible {
//    let q: String
//    let from: Int
//    let to: Int
//    let recipeMetaData: [RecipeMetaObject] // nested array
//    
//    init?(response: HTTPURLResponse, representation: Any) {
//        
//        let representation = representation as! [String: Any]
//        let q = representation["q"] as! String
//        let from = representation["from"] as! Int
//        let to = representation["to"] as! Int
//        let recipeMetaData = RecipeListItem.collection(from: response, withRepresentation: representation["hits"]!)
//        
//        
//        self.q = q
//        self.from = from
//        self.to = to
//        self.recipeMetaData = recipeMetaData
//    }
//    
//    var description: String {
//        return "These are my recipe objects: \n\(recipeMetaData)"
//    }
//    
//}
//
//final class RecipeListItem: ResponseObjectSerializable, ResponseCollectionSerializable, CustomStringConvertible {
//    
//    let bought: Bool
//    let bookmarked: Bool
//    let recipe: Recipe
//    
//    init?(response: HTTPURLResponse, representation: Any) {
//        guard
//            let representation = representation as? [String: Any],
//            let bought = representation["bought"] as? Bool,
//            let bookmarked = representation["bookmarked"] as? Bool,
//            let recipe = Recipe.init(response: response, representation: representation["recipe"]!)
//            else { return nil }
//        
//        self.bought = bought
//        self.bookmarked = bookmarked
//        self.recipe = recipe
//    }
//    
//    var description: String {
//        return "\n\(recipe)"
//    }
//}
//
//final class Recipe: ResponseObjectSerializable, CustomStringConvertible {
//
//    var title: String // label
//    var mealImgUrl: String // image
//    var redirectUrl: String // url (will redirect to WebView since it is a completely new separate web page)
//    var calories: Float // calories
//    var source: String // source
//    var ingredients: [Ingredient] // ingredients
//
//    init?(response: HTTPURLResponse, representation: Any) {
//        
//        let representation = representation as! [String: Any]
//        let title = representation["label"] as! String
//        let mealImgUrl = representation["image"] as! String
//        let redirectUrl = representation["url"] as! String
//        let calories = representation["calories"] as! Float
//        let source = representation["source"] as! String
//        let ingredients = Ingredient.collection(from: response, withRepresentation: representation["ingredients"]!)
//
//        self.title = title
//        self.mealImgUrl = mealImgUrl
//        self.redirectUrl = redirectUrl
//        self.calories = calories
//        self.source = source
//        self.ingredients = ingredients
//    }
//
//    var description: String {
//        return "Recipe: { title: \(title), source: \(source), ingredients: \(ingredients) }"
//    }
//}
//
//final class Ingredient: ResponseObjectSerializable, ResponseCollectionSerializable, CustomStringConvertible {
//
//    var text: String // text
//    var weight: Float // weight
//
//    init?(response: HTTPURLResponse, representation: Any) {
//        guard
//            let representation = representation as? [String: Any],
//            let text = representation["text"] as? String,
//            let weight = representation["weight"] as? Float
//            else { return nil }
//
//        self.text = text
//        self.weight = weight
//    }
//
//    var description: String {
//        return "Ingredient: { text: \(text), weight: \(weight) }"
//    }
//}
//
