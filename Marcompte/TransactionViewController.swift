//
//  TransactionViewController.swift
//  Marcompte
//
//  Created by CHWATACZ ANTOINE on 18/12/2018.
//  Copyright © 2018 fr.utt.if26. All rights reserved.
//

import UIKit

class TransactionViewController: UIViewController {

    @IBOutlet weak var TransTableViews: UITableView!
    
    
    var groupeID:Int = 0
    @IBOutlet weak var LabelGroupeNom: UILabel!
    
    let bdd = SingletonBdd.shared;
    
    var transactions: [Transaction] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        LabelGroupeNom?.text = String(groupeID)
        // Do any additional setup after loading the view.
        
        transactions = bdd.selectTransactions(id_groupe: groupeID)!
        
       // TransTableViews.delegate = self as! UITableViewDelegate
        //TransTableViews.dataSource = self as! UITableViewDataSource
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell = tableView.dequeueReusableCell(withIdentifier: "celluleTransModule")
        if cell == nil {
            cell = UITableViewCell(style: UITableViewCellStyle.value2, reuseIdentifier: "celluleTransModule")
        }
        
        cell?.textLabel?.text = "Nom transaction : \(transactions[indexPath.row].nom_transaction)"
        cell?.detailTextLabel?.text = "Montant: \(transactions[indexPath.row].prix)"
        return cell!
    }
    
    /* func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
     // cell selected code here
     }*/
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return bdd.CountTableTransaction(id_groupe: groupeID)
    }
    
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
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
