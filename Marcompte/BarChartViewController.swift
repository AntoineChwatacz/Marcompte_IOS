//
//  BarChartViewController.swift
//  Marcompte
//
//  Created by CHWATACZ ANTOINE on 07/01/2019.
//  Copyright © 2019 fr.utt.if26. All rights reserved.
//

import UIKit
import Charts

class BarChartViewController: UIViewController {

    
    @IBOutlet weak var LabelNomGroupe: UILabel!
    @IBOutlet weak var pieView: PieChartView!
    
    var groupeIDtransaction:Int = 0
    var NomGroupe:String = ""

    let bdd = SingletonBdd.shared;
    var transactions: [Transaction] = []
    var  colors: [UIColor] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        LabelNomGroupe?.text = String(NomGroupe)
        transactions = bdd.selectTransactions(id_groupe: groupeIDtransaction)!
        // Do any additional setup after loading the view.
        
        setupPieChart()
    }

    
    func setupPieChart(){
        pieView.chartDescription?.enabled = false
        pieView.drawHoleEnabled = false
        pieView.rotationAngle = 0
        pieView.rotationEnabled = false
        pieView.isUserInteractionEnabled = false
        
        var entries: [PieChartDataEntry] = Array()
        
        for transaction in transactions {
            entries.append(PieChartDataEntry(value:Double(transaction.prix), label: "\(transaction.nom_transaction): \(transaction.prix)€"))
        }
        
        
        let dataSet = PieChartDataSet(values: entries, label:"")
        
        
        for i in 0..<transactions.count {
            let red = Double(arc4random_uniform(256))
            let green = Double(arc4random_uniform(256))
            let blue = Double(arc4random_uniform(256))

            let color = UIColor(red: CGFloat(red/255), green: CGFloat(green/255), blue: CGFloat(blue/255), alpha: 1)
            colors.append(color)
        }
        
        dataSet.colors = colors
        
        dataSet.drawValuesEnabled = false
        pieView.data = PieChartData(dataSet: dataSet)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
