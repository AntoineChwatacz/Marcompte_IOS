//
//  addtransactionViewController.swift
//  Marcompte
//
//  Created by CHWATACZ ANTOINE on 18/12/2018.
//  Copyright © 2018 fr.utt.if26. All rights reserved.
//

import UIKit

class addtransactionViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate{

    @IBOutlet weak var TxNomTransaction: UITextField!
    @IBOutlet weak var TxPrix: UITextField!
    @IBOutlet weak var LabelRecapTransaction: UILabel!
    @IBOutlet weak var BtnAddT: UIButton!
    @IBOutlet weak var dropDownCategorie: UIPickerView!
    
    //lite : Nourriture, Logement, Transport, Cadeaux, Autres
    let categorie = ["","Nourriture", "Logement", "Transport", "Cadeaux","Autres"]
    var mycategorie:String = ""
    var groupeIDtransaction:Int = 0
    
    let bdd = SingletonBdd.shared;
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        print ("---> Groupe ID add : \(groupeIDtransaction) ")
        
        
        self.dropDownCategorie.delegate = self
        self.dropDownCategorie.dataSource = self
        
        //button design
        BtnAddT.layer.cornerRadius = 5
        BtnAddT.layer.borderWidth = 1
        BtnAddT.layer.borderColor = UIColor.black.cgColor
        // Do any additional setup after loading the view.
    }


// Sets number of columns in picker view
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
    return 1
    }
    
    // The number of rows of data
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
    return categorie.count
    }
    
    // The data to return fopr the row and component (column) that's being passed in
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int)-> String? {
    return categorie[row]
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Capture the picker view selection
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        // This method is triggered whenever the user makes a change to the picker selection.
        // use the row to get the selected row from the picker view
        // using the row extract the value from your datasource (array[row])
        mycategorie = categorie[row] as String
        
    }
    
    
    @IBAction func Add_Transaction(_ sender: Any) {
        
        if TxNomTransaction.text == "" {
            let alert = UIAlertController(title: "Probleme formulaire", message: "Le formulaire n'et pas remplit correctement il manque le nom de la transaction", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Annuler", style: .cancel, handler: nil))
            self.present(alert, animated: true)
            
            //VERIF PRIX
        } else if TxPrix.text == "" {
            let alert = UIAlertController(title: "Probleme formulaire", message: "Le formulaire n'et pas remplit correctement il manque le prix", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Annuler", style: .cancel, handler: nil))
            self.present(alert, animated: true)
        }else if isStringAnInt(string: TxPrix.text!) == false {
            let alert = UIAlertController(title: "Probleme formulaire", message: "Le formulaire n'et pas remplit correctement, le prix n'est pas valide", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Annuler", style: .cancel, handler: nil))
            self.present(alert, animated: true)
            
            //VERIF CATEGORIE
        }else if mycategorie == "" {
                let alert = UIAlertController(title: "Probleme formulaire", message: "Le formulaire n'et pas remplit correctement la catégorie est vide", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Annuler", style: .cancel, handler: nil))
                self.present(alert, animated: true)
        } else {
            bdd.insertTransaction(nom: TxNomTransaction.text!, prix: Int(TxPrix.text!)!, categorie: mycategorie,  idGroupe: groupeIDtransaction)
            LabelRecapTransaction.text = "Transaction  ajouté, nom : \(TxNomTransaction.text!)  et le montant : \(TxPrix.text!) ."
            
            //Retour en arrière
            _ = navigationController?.popViewController(animated: true)
            
        }
    }
    
    
    //fonction test entier
    func isStringAnInt(string: String) -> Bool {
        return Int(string) != nil
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
