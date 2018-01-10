//
//  TopCategoryTurVC.swift
//  CeviriyleOgren
//
//  Created by Emir Kartal on 30.11.2017.
//  Copyright © 2017 Emir Kartal. All rights reserved.
//

import UIKit

class TopCategoryTurVC: UIViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    var alamofireElement =  AlamofireData()
    var topCatArr = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        DispatchQueue.main.async {
            self.alamofireElement.getTopCategory()
        }
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        topCatArr = alamofireElement.topCategory
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return topCatArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "topCatCellTur", for: indexPath)
        cell.textLabel?.text = topCatArr[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let chosenRow = indexPath.row
        performSegue(withIdentifier: "toCategoryTurVC", sender: chosenRow)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toCategoryTurVC" {
            if let vc = segue.destination as? CategoryTurVC {
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
