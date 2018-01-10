//
//  SubCategoryVC.swift
//  CeviriyleOgren
//
//  Created by Emir Kartal on 3.12.2017.
//  Copyright © 2017 Emir Kartal. All rights reserved.
//

import UIKit

class SubCategoryEnVC: UIViewController,UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    var subCatId = Int()
    var alamofireElement =  AlamofireData()
    var subCategoryArr = [String]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //self.tabBarController?.tabBar.isHidden = true
        alamofireElement.getSubCategory(categoryId: subCatId)
        tableView.delegate = self
        tableView.dataSource = self
        
    }

    override func viewDidAppear(_ animated: Bool) {
        
        subCategoryArr = alamofireElement.subCategory
        tableView.reloadData()
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return subCategoryArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "subCatCell", for: indexPath)
        cell.textLabel?.text = subCategoryArr[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let qId = alamofireElement.questionId[indexPath.row]
        performSegue(withIdentifier: "toQuestionVC", sender: qId)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toQuestionVC" {
            if let vc = segue.destination as? QuestionVC {
               vc.qId = sender as! Int
               vc.changeLanguage = false
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
