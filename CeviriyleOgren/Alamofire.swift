//
//  Alamofire.swift
//  CeviriyleOgren
//
//  Created by Emir Kartal on 30.11.2017.
//  Copyright © 2017 Emir Kartal. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import SwiftyJSON

 class AlamofireData {
    
    var topCategory = [String]()
    var category = [String]()
    var subCategory = [String]()
    var subCategoryId = [Int]()
    var questionId = [Int]()
    var questionArr = [String]()
    var answerArr = [String]()
    var soundArr = [String]()
    
    func getTopCategory() {
        
        topCategory = []
        var json:JSON = []
        let url = "http://api.bankokuponlar.org/api/v1/topcategory"
        
        Alamofire.request(url ,method: .get ,parameters: nil, encoding: URLEncoding.default).responseJSON { response in
                
            if let data = response.result.value{
                json = JSON(data)
                for unit in json{
                    let unitName = unit.1["Title"].string
                    self.topCategory.append(unitName!)
                }
            }else {
                print("error")
            }
        }
        
    }
    
    func getCategory(chosen : Int) {
        
        let url = "http://api.bankokuponlar.org/api/v1/Category/GetCategoriesByTopCategoryId/\(chosen)"
        var json:JSON = []
        category = []
        
        Alamofire.request(url ,method: .get ,parameters: nil, encoding: URLEncoding.default).responseJSON { response in
            
            if let data = response.result.value{
                json = JSON(data)
                for unit in json{
                    let categoryName = unit.1["Title"].string
                    let categoryId = unit.1["Id"].int
                    self.category.append(categoryName!)
                    self.subCategoryId.append(categoryId!)
                }
            }else {
                print("error")
            }
        }
    }
    
    func getSubCategory(categoryId : Int) {
        
        var json:JSON = []
        let url = "http://api.bankokuponlar.org/api/v1/SubCategory/GetSubCategoriesByCategoryId/\(categoryId)"
        subCategory = []
        questionId = []
        
        Alamofire.request(url ,method: .get ,parameters: nil, encoding: URLEncoding.default).responseJSON { response in
            
            if let data = response.result.value{
                json = JSON(data)
                for unit in json{
                    let subCategoryName = unit.1["Title"].string
                    self.subCategory.append(subCategoryName!)
                    let questionIdNumber = unit.1["Id"].int
                    self.questionId.append(questionIdNumber!)
                }
            }else {
                print("error")
            }
        }
    }
    
    func getQuestion(qId : Int, fromLang : Int, toLang : Int) {
        
        var json:JSON = []
        questionArr = []
        answerArr = []
        let url = "http://api.bankokuponlar.org/api/v1/Question/GetAllQuestions?subcategoryId=\(qId)&fromLanguageId=\(fromLang)&toLanguageId=\(toLang)"
        
        Alamofire.request(url ,method: .get ,parameters: nil, encoding: URLEncoding.default).responseJSON { response in
            
            if let data = response.result.value{
                json = JSON(data)
                for unit in json{
                    let question = unit.1["FromTitle"].string
                    let answer = unit.1["ToTitle"].string
                    let soundPath = unit.1["ToVoice"].string
                    self.questionArr.append(question!)
                    self.answerArr.append(answer!)
                    self.soundArr.append(soundPath!)
                }
               
            }else {
                print("error")
            }
            
        }
    }
    
}
