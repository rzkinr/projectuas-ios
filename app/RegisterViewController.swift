//
//  RegisterViewController.swift
//  app
//
//  Created by RIzkiNur on 24/11/19.
//  Copyright © 2019 vokasi. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController {
    @IBOutlet weak var BtnDaftar2: UIButton!
    @IBOutlet weak var katasandiTextDaftar: UITextField!
    @IBOutlet weak var namaTextDaftar: UITextField!
    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var CardViewRegis: UIView!
    
    
    
    var db:DBhelper = DBhelper() //inisialisasi db
    var users:[Users] = [] //memanggil table users
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        CardViewRegis.layer.cornerRadius = 15
        BtnDaftar2.layer.cornerRadius = 10
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func kembalihome(_ sender: Any) {
        //dismiss(animated: true, completion: nil)
    }
    
    @IBAction func BtnDaftar(_ sender: Any) {
        let nama = namaTextDaftar.text!
        let katasandi = katasandiTextDaftar.text!
        
        db.insertUsers(nama: nama, katasandi: katasandi)
        
        dismiss(animated: true, completion: nil)
        //performSegue(withIdentifier: "HomeSegue2", sender: self)
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
