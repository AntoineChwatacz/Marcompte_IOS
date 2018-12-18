//
//  addGroupViewController.swift
//  Marcompte
//
//  Created by CHWATACZ ANTOINE on 18/12/2018.
//  Copyright © 2018 fr.utt.if26. All rights reserved.
//

import UIKit

class addGroupViewController: UIViewController {

    @IBOutlet weak var TxNom: UITextField!
    @IBOutlet weak var txNombre: UITextField!
    @IBOutlet weak var LabelRecapGroupe: UILabel!
    
    let bdd = SingletonBdd.shared;
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func Btn_add() {
        
        if TxNom.text == "" {
            let alert = UIAlertController(title: "Probleme formulaire", message: "Le formulaire n'et pas remplit correctement il manque le nom", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Annuler", style: .cancel, handler: nil))
            self.present(alert, animated: true)
        } else if txNombre.text == "" {
            let alert = UIAlertController(title: "Probleme formulaire", message: "Le formulaire n'et pas remplit correctement il manque le nombre de personnes", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Annuler", style: .cancel, handler: nil))
            self.present(alert, animated: true)
        } else {
            bdd.insertGroupe(nom: TxNom.text!, nombre:Int(txNombre.text!)!)
            LabelRecapGroupe.text = "Groupe ajouté, nom : \(TxNom.text!)  nombre de personnes : \(txNombre.text!) ."
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
