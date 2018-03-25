//
//  CategoryEnVC.swift
//  CeviriyleOgren
//
//  Created by Emir Kartal on 30.11.2017.
//  Copyright © 2017 Emir Kartal. All rights reserved.
//

import UIKit

class CategoryEnVC: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    var chosen = Int()
    var alamofireElement =  AlamofireData()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        DispatchQueue.global(qos: .userInteractive).async {
            self.alamofireElement.getCategory(chosen: self.chosen)
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return alamofireElement.model.category.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "catCell", for: indexPath)
        cell.textLabel?.text = alamofireElement.model.category[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let chosenRow = alamofireElement.model.subCategoryId[indexPath.row]
        performSegue(withIdentifier: "toSubCategoryEnVC", sender: chosenRow)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toSubCategoryEnVC" {
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
