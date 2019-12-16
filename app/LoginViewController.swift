//
//  LoginViewController.swift
//  app
//
//  Created by RIzkiNur on 22/11/19.
//  Copyright © 2019 vokasi. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    @IBOutlet weak var BtnMasukLogin: UIButton!
    @IBOutlet weak var katasandiText: UITextField!
    @IBOutlet weak var namaText: UITextField!
    @IBOutlet weak var CardViewLogin: UIView!
    
    @IBOutlet weak var Username: UITextField!
    @IBOutlet weak var Password: UITextField!
    
    var db:DBhelper = DBhelper() //inisialisasi db
    var users:[Users] = [] //memanggil table users
    
    override func viewDidLoad() {
        super.viewDidLoad()
        CardViewLogin.layer.cornerRadius = 15
        BtnMasukLogin.layer.cornerRadius = 10

        // Do any additional setup after loading the view.
        
        db.readUsers()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func kembalilogin(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func BtnMasukLogin(_ sender: Any) {
        let nama: String = Username.text!
        let katasandi: String = Password.text!
        
        if nama.isEmpty || katasandi.isEmpty {
            showAlert(Title: "Peringatan", Message: "Mohon untuk diisi Nama dan Katasandi")
        }
        
        var masuk = db.readUsers(nama: nama, katasandi: katasandi)
        if masuk.count > 0 {
            performSegue(withIdentifier: "HomeSegue", sender: self)
        }else {
            showAlert(Title: "Peringatan", Message: "Nama dan Katasandi salah")
        }
    }
    
    func showAlert(Title title:String, Message message: String){
        let alertController = UIAlertController(title: title,message:message, preferredStyle:UIAlertControllerStyle.alert)
        
        alertController.addAction(UIAlertAction(title:"OK", style : UIAlertActionStyle.default, handler:nil))
        
        present(alertController, animated:true,completion: nil)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let homelogin: HomeViewController = segue.destination as! HomeViewController
        homelogin.usernamee = namaText.text!
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
