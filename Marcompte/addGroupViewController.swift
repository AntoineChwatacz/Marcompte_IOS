//
//  addGroupViewController.swift
//  Marcompte
//
//  Created by CHWATACZ ANTOINE on 18/12/2018.
//  Copyright © 2018 fr.utt.if26. All rights reserved.
//

import UIKit
//import CommonCrypto



class addGroupViewController: UIViewController {

    @IBOutlet weak var TxNom: UITextField!
    @IBOutlet weak var txNombre: UITextField!
    @IBOutlet weak var LabelRecapGroupe: UILabel!
    @IBOutlet weak var TxMdp: UITextField!
    @IBOutlet weak var TxDeuxiemeMdp: UITextField!
    @IBOutlet weak var btnAdd: UIButton!
    
    let bdd = SingletonBdd.shared;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //button design
        btnAdd.layer.cornerRadius = 5
        btnAdd.layer.borderWidth = 1
        btnAdd.layer.borderColor = UIColor.black.cgColor
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
            
            //VERIF NOMBRE DE PERSONNES
        } else if txNombre.text == "" {
            let alert = UIAlertController(title: "Probleme formulaire", message: "Le formulaire n'et pas remplit correctement il manque le nombre de personnes", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Annuler", style: .cancel, handler: nil))
            self.present(alert, animated: true)
        }else if isStringAnInt(string: txNombre.text!) == false {
            let alert = UIAlertController(title: "Probleme formulaire", message: "Le formulaire n'et pas remplit correctement, le nombre de personnes n'est pas valide", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Annuler", style: .cancel, handler: nil))
            self.present(alert, animated: true)
    
            //VERIF MOT DE PASSE
        }  else if TxMdp.text == "" {
            let alert = UIAlertController(title: "Probleme formulaire", message: "Le formulaire n'et pas remplit correctement il manque le mot de passe", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Annuler", style: .cancel, handler: nil))
            self.present(alert, animated: true)
        }else if TxDeuxiemeMdp.text == "" {
            let alert = UIAlertController(title: "Probleme formulaire", message: "Le formulaire n'et pas remplit correctement il manque la vérification du mot de passe", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Annuler", style: .cancel, handler: nil))
            self.present(alert, animated: true)
        }else if TxMdp.text != TxDeuxiemeMdp.text {
            let alert = UIAlertController(title: "Probleme formulaire", message: "Le formulaire n'et pas remplit correctement les mots de passes ne correspondent pas", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Annuler", style: .cancel, handler: nil))
            self.present(alert, animated: true)
        }else{
            
            //securisation mot de passe
            var mdp_secure = ""
            mdp_secure = sha256(TxMdp.text!)!
            print("l'emprunte du mot de passe est : \(mdp_secure)")
            
            
            bdd.insertGroupe(nom: TxNom.text!, nombre:Int(txNombre.text!)!, motdepasse: mdp_secure)
            LabelRecapGroupe.text = "Groupe ajouté, nom : \(TxNom.text!)  nombre de personnes : \(txNombre.text!) ."
            
            //Retour en arrière
            _ = navigationController?.popViewController(animated: true)
        }
        
    }
    //fonction test entier
    func isStringAnInt(string: String) -> Bool {
        return Int(string) != nil
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
