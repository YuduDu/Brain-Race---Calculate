//
//  SecondViewController.swift
//  Calculate
//
//  Created by Yudu Du on 5/18/17.
//  Copyright © 2017 Yudu Du. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController,UITableViewDataSource, UITableViewDelegate {
    @IBOutlet var lastScore: UILabel!
    var history: [String] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    @IBOutlet var historyTable: UITableView!
    override func viewDidAppear(_ animated: Bool) {
        if let score = UserDefaults.standard.object(forKey: "topScore") {
            lastScore.text = String(describing: score)
        }
        else {
            lastScore.text = "No data"
        }
        if let tmp = UserDefaults.standard.object(forKey: "history"){
            history = tmp as! [String]
        }
        historyTable.reloadData()
        
        
    }
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return history.count
    }
    
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CustomTableViewCell
        
        let record = history[indexPath.row]
        let data = record.components(separatedBy: "-")
        cell.score.text = data[0]
        cell.date.text = data[1]
        cell.number.text = String(indexPath.row + 1)+"."


        return cell
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

