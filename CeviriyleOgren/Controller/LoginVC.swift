//
//  ViewController.swift
//  CeviriyleOgren
//
//  Created by Emir Kartal on 29.11.2017.
//  Copyright © 2017 Emir Kartal. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {
    
    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    let alamofireElement = AlamofireData()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func signInClicked(_ sender: Any) {
        
        performSegue(withIdentifier: "toHomeVC", sender: nil)
    }
    
    @IBAction func signUpClicked(_ sender: Any) {
    }
    

}

