//
//  Groupe.swift
//  Marcompte
//
//  Created by CHWATACZ ANTOINE on 11/12/2018.
//  Copyright © 2018 fr.utt.if26. All rights reserved.
//

import UIKit
import Foundation

class Groupe {
    
    
    var id_groupe: Int
    var nomGroupe: String
    var nombre: Int
    var MotdePasse: String
    var groupeTransaction: Array<Transaction>
    
    init() {
        id_groupe = 0
        nomGroupe = "?"
        nombre = 0
        MotdePasse = ""
        groupeTransaction = Array<Transaction>()
    }
    
    init(id: Int, nom: String, credit: Int, motdepasse: String) {
        self.id_groupe = id
        self.nomGroupe = nom
        self.nombre = credit
        self.MotdePasse = motdepasse
        self.groupeTransaction = Array<Transaction>()
    }
    
    public var descriptor: String {
        
        for transaction in self.groupeTransaction {
            print ("Module(\(id_groupe),\(nomGroupe),\(nombre),\(transaction))")
        }
        return "Module(\(id_groupe),\(nomGroupe),\(nombre))"
    }
}

