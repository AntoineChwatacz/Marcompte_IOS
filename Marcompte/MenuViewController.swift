//
//  MenuViewController.swift
//  Marcompte
//
//  Created by CHWATACZ ANTOINE on 13/12/2018.
//  Copyright © 2018 fr.utt.if26. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var add_groups: UIButton!
    @IBOutlet weak var TableView: UITableView!
    @IBOutlet weak var btnAddGroup: UIButton!
    
    let bdd = SingletonBdd.shared;
    var groupes: [Groupe] = []
    let c = Groupe()
    
 override func viewDidLoad() {
        super.viewDidLoad()
    
    //button design
    btnAddGroup.layer.cornerRadius = 5
    btnAddGroup.layer.borderWidth = 1
    btnAddGroup.layer.borderColor = UIColor.black.cgColor
    
    bdd.createTable()
    if bdd.CountTableGroups() == 0 {

        bdd.insertGroupe(nom: "test", nombre:2, motdepasse: "A6xnQhbz4Vx2HuGl4lXwZ5U2I8iziLRFnhP5eNfIRvQ=") // mot de passe : 1234
        bdd.insertGroupe(nom: "test2", nombre:3, motdepasse: "mvFbM25qlhmShTffMLLmojdlafz51+dz7M7eZWBlKaA=") // mot de passe : 0000
    }
    
        groupes = bdd.selectAllGroupe()!

        TableView.delegate = self
        TableView.dataSource = self
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        groupes = bdd.selectAllGroupe()!
        TableView.delegate = self
        TableView.dataSource = self
        
        //Reload tableView
        TableView.reloadData()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell = tableView.dequeueReusableCell(withIdentifier: "celluleModule")
        if cell == nil {
            cell = UITableViewCell(style: UITableViewCellStyle.value2, reuseIdentifier: "celluleModule")
        }
        
        cell?.textLabel?.text = "Nom du groupe : \(groupes[indexPath.row].nomGroupe)"
        cell?.detailTextLabel?.text = "Nombre de personnes : \(groupes[indexPath.row].nombre)"
    
        return cell!
    }
    
    /* func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
     // cell selected code here
     }*/
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return bdd.CountTableGroups()
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
    
    @IBAction func AjouteGroupe() {
        
    }
    
    
    /*func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "MonSegue", sender: groupes[indexPath.row])

    }*/
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        
        if segue.destination is TransactionViewController
        {
            let vc = segue.destination as? TransactionViewController
            //vc?.groupeID = sender as! Int
            if let indexPath = self.TableView.indexPathForSelectedRow {
                vc?.groupeID =  groupes[indexPath.row].id_groupe
                vc?.NomGroupe =  groupes[indexPath.row].nomGroupe
                vc?.motDePasse = groupes[indexPath.row].MotdePasse
                vc?.nombrePers = groupes[indexPath.row].nombre
            }
        }
    }


}
