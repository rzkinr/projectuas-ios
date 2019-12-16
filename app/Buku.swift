//
//  Buku.swift
//  app
//
//  Created by RIzkiNur on 25/11/19.
//  Copyright © 2019 vokasi. All rights reserved.
//

import Foundation

class Buku{
    var Id: Int = 0
    var esbn: String = ""
    var judulbuku: String = ""
    var pengarangbuku: String = ""
    var penerbitbuku: String = ""
    var kategoribuku: String = ""
    
    init(Id: Int, esbn: String, judulbuku: String, pengarangbuku: String, penerbitbuku: String, kategoribuku: String ) {
        self.Id = Id
        self.esbn = esbn
        self.judulbuku = judulbuku
        self.pengarangbuku = pengarangbuku
        self.penerbitbuku = penerbitbuku
        self.kategoribuku = kategoribuku
    }
}
