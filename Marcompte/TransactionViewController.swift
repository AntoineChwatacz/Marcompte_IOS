//
//  TransactionViewController.swift
//  Marcompte
//
//  Created by CHWATACZ ANTOINE on 18/12/2018.
//  Copyright © 2018 fr.utt.if26. All rights reserved.
//

import UIKit

class TransactionViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{

    @IBOutlet weak var TransTableViews: UITableView!
    
    
    var groupeID:Int = 0
    var NomGroupe:String = ""
    @IBOutlet weak var LabelGroupeNom: UILabel!
    
    let bdd = SingletonBdd.shared;
    
    var transactions: [Transaction] = []
    
   override func viewDidLoad() {
        super.viewDidLoad()
        
        LabelGroupeNom?.text = String(NomGroupe)
        // Do any additional setup after loading the view.
        
       transactions = bdd.selectTransactions(id_groupe: groupeID)!
       TransTableViews.delegate = self
       TransTableViews.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        LabelGroupeNom?.text = String(NomGroupe)
        // Do any additional setup after loading the view.
        
        transactions = bdd.selectTransactions(id_groupe: groupeID)!
        TransTableViews.delegate = self
        TransTableViews.dataSource = self
        
        //Reload TableView
        TransTableViews.reloadData()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cellTrans = tableView.dequeueReusableCell(withIdentifier: "celluleTransModule")
        if cellTrans == nil {
            cellTrans = UITableViewCell(style: UITableViewCellStyle.value2, reuseIdentifier: "celluleTransModule")
        }
        
        cellTrans?.textLabel?.text = "Nom transaction : \(transactions[indexPath.row].nom_transaction)"
        cellTrans?.detailTextLabel?.text = "Montant: \(transactions[indexPath.row].prix)"
        return cellTrans!
    }
    
    /* func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
     // cell selected code here
     }*/
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return bdd.CountTableTransaction(id_groupe: groupeID)
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        
        if segue.destination is addtransactionViewController
        {
            let vc = segue.destination as? addtransactionViewController
            print ("---> Groupe ID : \(groupeID) ")
            vc?.groupeIDtransaction = groupeID
        }
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
