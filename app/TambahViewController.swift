//
//  TambahViewController.swift
//  app
//
//  Created by RIzkiNur on 24/11/19.
//  Copyright © 2019 vokasi. All rights reserved.
//

import UIKit

class TambahViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIPickerViewDelegate, UIPickerViewDataSource {
    
    //untuk mengubah tampilan
    @IBOutlet weak var tabelbuku: UITableView!
    @IBOutlet weak var btnhapusdata: UIButton!
    @IBOutlet weak var btneditdata: UIButton!
    @IBOutlet weak var btntambahdata: UIButton!
    
    //untuk menambah cell
    let cellReuseIdentifier = "cell"
    
    var db:DBhelper = DBhelper() //inisialisasi db
    
    var buku:[Buku] = [] //memanggil table buku
    
    //untuk memilih salah satu cell atau row yg akan di edit/hapus
    var selectedBuku: Int = 1
    
    //variabel untuk wadah data dari tabel
    var id: Int!
    var esbn: String!
    var judulbuku: String!
    var pengarangbuku: String!
    var penerbitbuku: String!
    var kategoribuku: String!
    
    //variabel untuk membuat picker view
    var pickerTextField: UITextField?
    var pickerView: UIPickerView?
    var pickerdata: [String] = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        //membuat corner radius
        btnhapusdata.layer.cornerRadius = 8
        btneditdata.layer.cornerRadius = 8
        btntambahdata.layer.cornerRadius = 8
        
        //tabel
        tabelbuku.register(UITableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
        tabelbuku.delegate = self
        tabelbuku.dataSource = self
        tabelbuku.reloadData()
        
        //untuk set picker view
        self.pickerdata = ["","Pengetahuan Umum", "Novel", "Majalah"]
        self.pickerView = UIPickerView()
        self.pickerView?.delegate = self
        self.pickerView?.dataSource = self
        
        //untuk membaca dan menampilkan data dari db
        buku = db.read()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //untuk set jumlah baris pada tabel
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return buku.count
    }
    
    //untuk format tampilan setiap baris
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        
        let cell:UITableViewCell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier)!
        
        cell.textLabel?.text = "Id: " + String(buku[indexPath.row].Id) + ", " + "Judul Buku: " + buku[indexPath.row].judulbuku
        
        return cell
    }
    
    //Memilih baris yg akan di update atau di hapus
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
        self.id = buku[indexPath.row].Id
        self.esbn = buku[indexPath.row].esbn
        self.judulbuku = buku[indexPath.row].judulbuku
        self.pengarangbuku = buku[indexPath.row].pengarangbuku
        self.penerbitbuku = buku[indexPath.row].penerbitbuku
        self.kategoribuku = buku[indexPath.row].kategoribuku
        
        selectedBuku = indexPath.row
    }
    
    
    @IBAction func btnTutup(_ sender: Any) {
        dismiss(animated: true, completion:nil)
    }
    
    
    @IBAction func btntambahdata(_ sender: Any) {
        showTambahDialog()
    }
    
    
    @IBAction func btneditdata(_ sender: Any) {
        showEditDialog()
    }
    
    
    @IBAction func btnhapusdata(_ sender: Any) {
        showHapusDialog()
    }
    
    func showTambahDialog() {
        //Creating UIAlertController and
        //Setting title and message for the alert dialog
        let alertController = UIAlertController(title: "Tambah Data Buku", message: "Masukkan ESBN, Judul, Pengarang, Penerbit, Kategori buku", preferredStyle: .alert)
        
        //the confirm action taking the inputs
        let confirmAction = UIAlertAction(title: "Tambah", style: .default) { (_) in
            
            //getting the input values from user
            let esbn = alertController.textFields?[0].text
            let judulbuku = alertController.textFields?[1].text
            let pengarangbuku = alertController.textFields?[2].text
            let penerbitbuku = alertController.textFields?[3].text
            let kategoribuku = alertController.textFields?[4].text
            
            
            self.db.insert(esbn: esbn!, judulbuku: judulbuku!, pengarangbuku: pengarangbuku!, penerbitbuku: penerbitbuku!, kategoribuku: kategoribuku!)
            self.viewDidLoad()
            self.viewDidLoad()
        }
        
        //the cancel action doing nothing
        let cancelAction = UIAlertAction(title: "Keluar", style: .cancel) { (_) in }
      
        //adding textfields to our dialog box
        alertController.addTextField { (textField) in
            textField.placeholder = "Masukkan ESBN"
        }
        alertController.addTextField { (textField) in
            textField.placeholder = "Masukkan Judul"
        }
        alertController.addTextField { (textField) in
            textField.placeholder = "Masukkan Pengarang"
        }
        alertController.addTextField { (textField) in
            textField.placeholder = "Masukkan Penerbit"
        }
        alertController.addTextField { (textField) in
            self.pickerTextField = textField
            self.pickerTextField?.inputView = self.pickerView
        }
        
        
        //adding the action to dialogbox
        alertController.addAction(confirmAction)
        alertController.addAction(cancelAction)
        
        //finally presenting the dialog box
        self.present(alertController, animated: true, completion: nil)
    }
    
    func showEditDialog() {
        //Creating UIAlertController and
        //Setting title and message for the alert dialog
        let alertController = UIAlertController(title: "Edit Data Buku", message: "Masukkan ESBN, Judul, Pengarang, Penerbeit, Kategori buku", preferredStyle: .alert)
        
        //the confirm action taking the inputs
        let confirmAction = UIAlertAction(title: "Edit", style: .default) { (_) in
            
            //get Id
            let id = self.id!
            print(id)
            
            //getting the input values from user
            let esbn = alertController.textFields?[0].text
            let judul = alertController.textFields?[1].text
            let pengarang = alertController.textFields?[2].text
            let penerbit = alertController.textFields?[3].text
            let kategori = alertController.textFields?[4].text
            
            self.db.update(esbn: esbn!, judulbuku: judul!, pengarangbuku: pengarang!, penerbitbuku: penerbit!, kategoribuku: kategori!, Id: Int(id))
            self.viewDidLoad()
            self.viewDidLoad()
        }
        
        //the cancel action doing nothing
        let cancelAction = UIAlertAction(title: "Keluar", style: .cancel) { (_) in }
        
        //adding textfields to our dialog box
        alertController.addTextField { (textField) in
            textField.text = self.esbn
        }
        alertController.addTextField { (textField) in
            textField.text = self.judulbuku
        }
        alertController.addTextField { (textField) in
            textField.text = self.pengarangbuku
        }
        alertController.addTextField { (textField) in
            textField.text = self.penerbitbuku
        }
        alertController.addTextField { (textField) in
            self.pickerTextField = textField
            self.pickerTextField?.inputView = self.pickerView
            self.pickerTextField?.text = self.kategoribuku
        }
        
        //adding the action to dialogbox
        alertController.addAction(confirmAction)
        alertController.addAction(cancelAction)
        
        //finally presenting the dialog box
        self.present(alertController, animated: true, completion: nil)
    }
    
    func showHapusDialog(){
        //Creating UIAlertController and
        //Setting title and message for the alert dialog
        let alertController = UIAlertController(title: "Hapus Data Buku", message: "Data akan dihapus secara permanent", preferredStyle: .alert)
        
        //the confirm action taking the inputs
        let confirmAction = UIAlertAction(title: "Hapus", style: .default) { (_) in
            
            //get Id
            let id = self.id!
            print(id)
            
            self.db.deleteByID(id: id)
            self.viewDidLoad()
            self.viewDidLoad()
            
        }
        
        //the cancel action doing nothing
        let cancelAction = UIAlertAction(title: "Keluar", style: .cancel) { (_) in }
        
        //adding the action to dialogbox
        alertController.addAction(confirmAction)
        alertController.addAction(cancelAction)
        
        //finally presenting the dialog box
        self.present(alertController, animated: true, completion: nil)
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerdata.count
    }
    
    //menampilkan data untuk tampilan picker
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerdata[row]
    }
    
    //menampilkan picker yg dipilih
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        pickerTextField?.text = pickerdata[row]
        pickerTextField?.resignFirstResponder()
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
