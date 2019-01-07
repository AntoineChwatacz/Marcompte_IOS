//
//  SingletonBdd.swift
//  Marcompte
//
//  Created by CHWATACZ ANTOINE on 11/12/2018.
//  Copyright © 2018 fr.utt.if26. All rights reserved.
//

import UIKit
import SQLite

class SingletonBdd {
    
    var database: Connection!
    let groupe_table = Table("groupes")
    let groupe_id = Expression<Int>("id")
    let groupe_nom = Expression<String>("groupe_nom")
    let groupe_nombre = Expression<Int>("groupe_nombre")
    let mot_de_passe = Expression<String>("mot_de_passe")
    //let groupe_transaction = Expression<Array<Transaction>>("groupes_transaction")
    
    
    let transaction_table = Table("transactions")
    let transaction_id = Expression<Int>("id")
    let transaction_nom = Expression<String>("transaction_nom")
    let transaction_prix = Expression<Int>("transaction_prix")
    let transaction_groupe = Expression<Int>("transaction_groupe")
    let transaction_categorie = Expression<String>("transaction_categorie")
    
    var initiated = false;
    
    var pkgroupe = 1000;
    var pktransaction = 2000;    // valeur de départ pour la primary key
    
    var tableGroupExist = false   // false la table n'est encore pas créée
    var tableTransactionExist = false
    
    
    static let shared = SingletonBdd()
    
    init(){
        if(self.initiated){}
        else{
            // Do any additional setup after loading the view, typically from a nib.
            print ("-->  Singleton initialized")
            // Il est possible de créer des fichiers dans le répertoire "Documents" de votre application.
            // Ici, création d'un fichier groupes_transaction
            do {let documentDirectory = try
                FileManager.default.url(for: .documentDirectory,
                                        in: .userDomainMask, appropriateFor: nil, create: true)
                let fileUrl = documentDirectory.appendingPathComponent("groupes_transaction").appendingPathExtension("sqlite3")
                let base = try Connection(fileUrl.path)
                self.database = base;
            }catch {
                print (error)
                print ("--> viewDidLoad fin")
            }
            self.initiated = true;
        }
    }
    
    func getConnection() -> Connection{
        return self.database;
    }
    
    func createTable() {
        print ("--> createTableGroupe debut")
        if !self.tableGroupExist {
            self.tableGroupExist = true
            // Instruction pour faire un drop de la table GROUPE
            let dropTable = self.groupe_table.drop(ifExists: true)
            // Instruction pour faire un create de la table GROUPE
            let createTable = self.groupe_table.create { table in
                table.column(self.groupe_id, primaryKey: true)
                table.column(self.groupe_nom)
                table.column(self.groupe_nombre)
                table.column(self.mot_de_passe)
                //table.column(self.groupe_transaction)
            }
            do {// Exécution du drop et du create
                try self.database.run(dropTable)
                try self.database.run(createTable)
                print ("Table groupe est créée")
            }catch {
                print (error)
            }
        }
        print ("--> createTableTansaction debut")
        if !self.tableTransactionExist {
            self.tableTransactionExist = true
            // Instruction pour faire un drop de la table TRANSACTION
            
            let dropTable = self.transaction_table.drop(ifExists: true)
            // Instruction pour faire un create de la table TRANSACTION
            let createTable = self.transaction_table.create { table in
                table.column(self.transaction_id, primaryKey: true)
                table.column(self.transaction_nom)
                table.column(self.transaction_prix)
                table.column(self.transaction_categorie)
                table.column(self.transaction_groupe)
                //table.foreignKey(self.transaction_groupe, references: self.groupe_table, self.groupe_id, delete: .setNull)
                // FOREIGN KEY("self.transaction_groupe") REFERENCES "self.groupe_table"("self.groupe_id") ON DELETE SET NULL
            }
            do {// Exécution du drop et du create
                try self.database.run(dropTable)
                try self.database.run(createTable)
                print ("Table transaction est créée")
            }catch {
                print (error)
            }
        }
        print ("--> createTables fin")
    }
    
    func getPKGroup() -> Int {
        let nbGroups = self.CountTableGroups()
    
        self.pkgroupe = 1000 + nbGroups + 1
        return self.pkgroupe
    }
    
    func getPKTransaction() -> Int {
        
    let nbTrans = self.CountTableTransaction()
        self.pktransaction  = 2000 + nbTrans + 1
        return self.pktransaction
    }
    
    //INSERTION TABLE GROUPE
    func insertGroupe(nom:String, nombre:Int, motdepasse: String) {
        print ("--> insertTableGroupe debut")
        // Insertion de 2 tuples exemples (sera réalisé à chaque click sur le bouton)
        let insert = self.groupe_table.insert(self.groupe_id <- getPKGroup(), self.groupe_nom <- nom, self.groupe_nombre <- nombre, self.mot_de_passe <- motdepasse)
        do {try self.database.run(insert)
            print ("Insert ok")
            
        }catch {
            print (error)
            print ("--> insertTableGroupe fin")
        }
    }
    
    //INSERTION TABLE TRANSACTION
    func insertTransaction(nom:String, prix:Int, categorie:String, idGroupe:Int) {
        print ("--> insertTableTransaction debut")
        print ("---> Groupe ID : \(idGroupe) ")
        
        // Insertion de 2 tuples exemples (sera réalisé à chaque click sur le bouton)
        let insert = self.transaction_table.insert(self.transaction_id <- getPKTransaction(), self.transaction_nom <- nom, self.transaction_prix <- prix, self.transaction_categorie <- categorie, self.transaction_groupe <- idGroupe)
        do {try self.database.run(insert)
            print ("Insert ok")
            
        }catch {
            print (error)
            print ("--> insertTableTransaction fin")
        }
    }
    
    //SELECT TOUS LES GROUPES
    func selectAllGroupe() -> [Groupe]? {
        var Mygroups : Array<Groupe> = Array<Groupe>()
        
        print("---> SelectAllGroupe debut")
        do{
            let groupes = try? self.database.prepare(self.groupe_table)
            
            for groupe in groupes!{
                print("id: ", groupe[self.groupe_id], ", nom du groupe: ", groupe[self.groupe_nom], ", Nombre de personnes: ", groupe[self.groupe_nombre], "Mot de passe : ", groupe[self.mot_de_passe])
                
                let mesgroupes = Groupe(id: groupe[self.groupe_id], nom: groupe[self.groupe_nom], credit: groupe[self.groupe_nombre], motdepasse: groupe[self.mot_de_passe])
                Mygroups.append(mesgroupes)
            }
        }
        catch
        {
            print(error)
        }
        print("---> SelectAllGroupe fin")
        return Mygroups
    }

    
    //SELECT TRANSACTION DU GROUPE ASSOCIE
    func selectTransactions(id_groupe:Int) -> [Transaction]?{
        print("---> SelectTransaction debut")
        print ("---> Groupe ID : \(id_groupe) ")
        var MyTransactions : Array<Transaction> = Array<Transaction>()
                
        print("---> SelectAllTransaction debut")
        do{
            let transactions = try self.database.prepare(self.transaction_table.filter(transaction_groupe ==
                id_groupe))
            
            for transaction in transactions{
                print("id: ", transaction[self.transaction_id], ", nom de la transaction: ", transaction[self.transaction_nom], ", Montant :  ", transaction[self.transaction_prix], " categorie : ", transaction[self.transaction_categorie])
                
                let mesTransactions = Transaction(transactionId: transaction[self.transaction_id], nom_transaction: transaction[self.transaction_nom], prix: transaction[self.transaction_prix],categorie:transaction[self.transaction_categorie], groupeId: id_groupe)
                MyTransactions.append(mesTransactions)
            }
        }
        catch
        {
            print(error)
        }
        print("---> SelectAllTransaction fin")
        return MyTransactions
    }
    
    
    func CountTableGroups() -> Int {
        print ("--> CountTableGroups debut")
        var resultat = 0
        do {
            resultat = try self.database.scalar(groupe_table.count)
            print ("count table = ", resultat)
        }
        catch
        {
            print (error)
            resultat = -1
        }
        print ("--> CountTableGroups fin")
        return resultat
    }
    
    func CountTableTransaction() -> Int {
        print ("--> CountTableTransaction sans ID debut")
        var resultat = 0
        do {
            resultat = try! database.scalar(transaction_table.count)
            
            //resultat = try self.database.scalar(groupe_table.count)
            print ("count Transaction sans ID = ", resultat)
        }
        catch
        {
            print (error)
            resultat = -1
        }
        print ("--> CountTableTransaction fin")
        return resultat
    }
    
    func CountTableTransaction(id_groupe:Int) -> Int {
        print ("--> CountTableTransaction debut")
        var resultat = 0
        do {
            resultat = try! database.scalar(transaction_table.where(transaction_groupe == id_groupe).count)

            //resultat = try self.database.scalar(groupe_table.count)
            print ("count Transaction = ", resultat)
        }
        catch
        {
            print (error)
            resultat = -1
        }
        print ("--> CountTableTransaction fin")
        return resultat
    }
}
