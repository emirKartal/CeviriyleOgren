//
//  TopCategoryEnVC.swift
//  CeviriyleOgren
//
//  Created by Emir Kartal on 30.11.2017.
//  Copyright © 2017 Emir Kartal. All rights reserved.
//

import UIKit
import SwiftyJSON

class TopCategoryEnVC: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    var alamofireElement =  AlamofireData()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        DispatchQueue.global(qos: .userInteractive).async {
            self.alamofireElement.getTopCategory()
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return alamofireElement.model.topCategory.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "topCatCell", for: indexPath)
        cell.textLabel?.text = alamofireElement.model.topCategory[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let chosenRow = indexPath.row 
        performSegue(withIdentifier: "toCategoryEnVC", sender: chosenRow)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toCategoryEnVC" {
            if let vc = segue.destination as? CategoryEnVC {
                vc.chosen = sender as! Int
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
