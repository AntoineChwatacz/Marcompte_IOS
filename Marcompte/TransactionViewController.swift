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
    var motDePasse = ""
    var nombrePers = 1
    @IBOutlet weak var LabelGroupeNom: UILabel!
    
    let bdd = SingletonBdd.shared;
    
    var transactions: [Transaction] = []
    
   override func viewDidLoad() {
        super.viewDidLoad()
    
    //cacher la vue
        TransTableViews.isHidden = true
   
    // Test mot de passe
    //1. Create the alert controller.
    let alert = UIAlertController(title: "check mot de passe", message: "Donner le mot de passe", preferredStyle: .alert)
    //2. Add the text field. You can configure it however you need.
    alert.addTextField { (textField) in
        textField.text = ""
    }
    // 3. Grab the value from the text field, and print it when the user clicks OK.
    alert.addAction(UIAlertAction(title: "OK", style: .default, handler:
        {
            [weak alert] (_) in
            let textField = alert?.textFields![0] // Force unwrapping because we know it exists.
            var test_mdp_secure = ""
            test_mdp_secure = self.sha256((textField?.text)!)!
            if test_mdp_secure != self.motDePasse {
                let innerAlert = UIAlertController(title: "mauvais mot de passe ", message: "Mot de passe incorrect !", preferredStyle: .alert)
                innerAlert.addAction(UIAlertAction(title: "OK", style: .default, handler:
                {
                    [weak innerAlert] (_) in
                    //Retour en arrière
                    self.navigationController?.popViewController(animated: true)
                }))
                self.present(innerAlert, animated: true, completion: nil)
            } else {
                // remettre la vue visible
                self.TransTableViews.isHidden = false
            }
    }))
    
    /*var height:NSLayoutConstraint = NSLayoutConstraint(item: alert.view, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1, constant: self.view.frame.height * 0.80)
    alert.view.addConstraint(height);
 */
    
    // 4. Present the alert.
    self.present(alert, animated: true, completion: nil)
    

    
    LabelGroupeNom?.text = String(NomGroupe)
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
        let montantPers = (transactions[indexPath.row].prix)/nombrePers
        cellTrans?.textLabel?.text = "Nom transaction : \(transactions[indexPath.row].nom_transaction)"
        cellTrans?.detailTextLabel?.text = "Montant total : \(transactions[indexPath.row].prix), montant par personne : \(montantPers)"
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

    
    //fonction de sécurités
    func sha256(_ data: Data) -> Data? {
        guard let res = NSMutableData(length: Int(CC_SHA256_DIGEST_LENGTH)) else { return nil }
        CC_SHA256((data as NSData).bytes, CC_LONG(data.count), res.mutableBytes.assumingMemoryBound(to: UInt8.self))
        return res as Data
    }
    
    func sha256(_ str: String) -> String? {
        guard
            let data = str.data(using: String.Encoding.utf8),
            let shaData = sha256(data)
            else { return nil }
        let rc = shaData.base64EncodedString(options: [])
        return rc
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
