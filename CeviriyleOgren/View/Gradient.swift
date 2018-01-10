//
//  Gradient.swift
//  CeviriyleOgren
//
//  Created by Emir Kartal on 29.11.2017.
//  Copyright © 2017 Emir Kartal. All rights reserved.
//

import Foundation
import UIKit

class Gradient {
    
    /*func createGradientLayer(view : UIView) {
        
        var gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.view.bounds
        gradientLayer.colors = [UIColor(red:0.76, green:0.22, blue:0.39, alpha:1.0).cgColor, UIColor(red:0.11, green:0.15, blue:0.44, alpha:1.0).cgColor]
        
        gradientLayer.zPosition = -1
        self.view.layer.addSublayer(gradientLayer)
        self.view.sendSubview(toBack: self.view)
    }*/
    
    func tableViewDesign(sender: UITableViewController) {
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [UIColor(red:0.76, green:0.22, blue:0.39, alpha:1.0).cgColor, UIColor(red:0.11, green:0.15, blue:0.44, alpha:1.0).cgColor]
        gradientLayer.frame = sender.tableView.bounds
        let backgroundView = UIView(frame: sender.tableView.bounds)
        backgroundView.layer.insertSublayer(gradientLayer, at: 0)
        sender.tableView.backgroundView = backgroundView
        
    }
    
}
