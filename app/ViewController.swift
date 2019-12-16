//
//  ViewController.swift
//  app
//
//  Created by RIzkiNur on 22/11/19.
//  Copyright © 2019 vokasi. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var BtnDaftar: UIButton!
    @IBOutlet weak var BtnMasuk: UIButton!
    @IBOutlet weak var CardView: UIView!
    @IBOutlet weak var image: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        image.layer.borderWidth = 0
        image.layer.masksToBounds = false
        image.layer.borderColor = UIColor.black.cgColor
        image.layer.cornerRadius = 12
        image.clipsToBounds = true
        
        CardView.layer.cornerRadius = 15
        BtnMasuk.layer.cornerRadius = 10
        BtnDaftar.layer.cornerRadius = 10
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func BtnMasuk(_ sender: Any) {
        performSegue(withIdentifier: "loginSegue", sender: self)
    }
    
    @IBAction func BtnDaftar(_ sender: Any) {
        performSegue(withIdentifier: "registerSegue", sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "loginSegue" {
            let vclogin: LoginViewController = segue.destination as! LoginViewController
        }else if segue.identifier == "registerSegue" {
            let vcregister: RegisterViewController = segue.destination as! RegisterViewController
        }
        
    }
    
}

