//
//  CategoryTurVC.swift
//  CeviriyleOgren
//
//  Created by Emir Kartal on 30.11.2017.
//  Copyright © 2017 Emir Kartal. All rights reserved.
//

import UIKit

class CategoryTurVC: UIViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    var chosen = Int()
    var alamofireElement =  AlamofireData()
    var categoryArr = [String]()
    var categoryIdArr = [Int]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //self.tabBarController?.tabBar.isHidden = true
        alamofireElement.getCategory(chosen: chosen)
        tableView.delegate = self
        tableView.dataSource = self
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        categoryArr = alamofireElement.category
        categoryIdArr = alamofireElement.subCategoryId
        tableView.reloadData()
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "catCellTur", for: indexPath)
        cell.textLabel?.text = categoryArr[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let chosenRow = categoryIdArr[indexPath.row]
        performSegue(withIdentifier: "toSubCategoryTurVC", sender: chosenRow)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toSubCategoryTurVC" {
            if let vc = segue.destination as? SubCategoryEnVC {
                vc.subCatId = sender as! Int
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
