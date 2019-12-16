//
//  HomeViewController.swift
//  app
//
//  Created by RIzkiNur on 24/11/19.
//  Copyright © 2019 vokasi. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    @IBOutlet weak var btnTambahhome: UIButton!
    @IBOutlet weak var jumlahbuku3: UILabel!
    @IBOutlet weak var jumlahbuku2: UILabel!
    @IBOutlet weak var jumlahbuku1: UILabel!
    @IBOutlet weak var card3: UIView!
    @IBOutlet weak var card2: UIView!
    @IBOutlet weak var card1: UIView!
    @IBOutlet weak var cardhome: UIView!
    @IBOutlet weak var userlabelText: UILabel!
    @IBOutlet weak var btnkeluar: UIButton!
    
    var db:DBhelper = DBhelper()
    var buku:[Buku] = []
    var text: Int = 0
    
    var usernamee: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        card1.layer.cornerRadius = 15
        card2.layer.cornerRadius = 15
        card3.layer.cornerRadius = 15
        cardhome.layer.cornerRadius = 15
        btnTambahhome.layer.cornerRadius = 8
        btnkeluar.layer.cornerRadius = 5
        
        
        var pengetahuanumum = self.db.readsingle(kategoribuku: "Pengetahuan Umum")
        jumlahbuku1.text = String(pengetahuanumum.count)
        
        var novel = self.db.readsingle(kategoribuku: "Novel")
        jumlahbuku2.text = String(novel.count)
        
        var majalah = self.db.readsingle(kategoribuku: "Majalah")
        jumlahbuku3.text = String(majalah.count)
        
        userlabelText.text = usernamee
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func btnkeluar(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func btntambahhome(_ sender: Any) {
        performSegue(withIdentifier: "tambahSegue", sender: nil)
    }
    
    @IBAction func refresh(_ sender: Any) {
        viewDidLoad()
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let home: TambahViewController = segue.destination as! TambahViewController
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
