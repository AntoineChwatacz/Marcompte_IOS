//
//  Transaction.swift
//  Marcompte
//
//  Created by CHWATACZ ANTOINE on 11/12/2018.
//  Copyright © 2018 fr.utt.if26. All rights reserved.
//

import UIKit


public class Transaction {

var transactionId: Int
var nom_transaction: String
var prix: Int
var groupeId: Int

init() {
    transactionId = 0
    nom_transaction = "?"
    prix = 0
    groupeId = 0
}

init(transactionId: Int, nom_transaction: String, prix: Int, groupeId: Int) {
    self.transactionId = transactionId
    self.nom_transaction = nom_transaction
    self.prix = prix
    self.groupeId = groupeId
}

public var descriptor: String {
    return "Transaction(\(transactionId),\(nom_transaction),\(prix),\(groupeId))"
}
}
