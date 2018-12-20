//
//  addtransactionViewController.swift
//  Marcompte
//
//  Created by CHWATACZ ANTOINE on 18/12/2018.
//  Copyright © 2018 fr.utt.if26. All rights reserved.
//

import UIKit

class addtransactionViewController: UIViewController {

    @IBOutlet weak var TxNomTransaction: UITextField!
    @IBOutlet weak var TxPrix: UITextField!
    @IBOutlet weak var LabelRecapTransaction: UILabel!
    
    var groupeIDtransaction:Int = 0
    
    let bdd = SingletonBdd.shared;
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        print ("---> Groupe ID add : \(groupeIDtransaction) ")
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func Add_Transaction(_ sender: Any) {
        
        if TxNomTransaction.text == "" {
            let alert = UIAlertController(title: "Probleme formulaire", message: "Le formulaire n'et pas remplit correctement il manque le nom de la transaction", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Annuler", style: .cancel, handler: nil))
            self.present(alert, animated: true)
        } else if TxPrix.text == "" {
            let alert = UIAlertController(title: "Probleme formulaire", message: "Le formulaire n'et pas remplit correctement il manque le prix", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Annuler", style: .cancel, handler: nil))
            self.present(alert, animated: true)
        } else {
            bdd.insertTransaction(nom: TxNomTransaction.text!, prix: Int(TxPrix.text!)!, idGroupe: groupeIDtransaction)
            LabelRecapTransaction.text = "Transaction  ajouté, nom : \(TxNomTransaction.text!)  et le montant : \(TxPrix.text!) ."
            
            //Retour en arrière
            _ = navigationController?.popViewController(animated: true)
            
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        
        if segue.destination is TransactionViewController
        {
            let vc = segue.destination as? TransactionViewController
            
            vc?.groupeID = groupeIDtransaction
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
