//
//  projectCell.swift
//  Swifty
//
//  Created by Jeremy SCHOTTE on 1/22/18.
//  Copyright © 2018 Jeremy SCHOTTE. All rights reserved.
//

import UIKit

class projectCell: UITableViewCell, UITableViewDataSource, UITableViewDelegate{
    
    var project : NSArray = []
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
        projectTable.delegate = self
        projectTable.dataSource = self
        
        projectTable.estimatedRowHeight = 300
        projectTable.rowHeight = UITableViewAutomaticDimension
        // Initialization code
    }
    
    @IBOutlet weak var projectTable: UITableView!
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return project.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "subProject") as? subProject
        
        //cell?.testLbl.text = "42"
        
        print("------")
        let dic = project[indexPath.row] as? NSDictionary
        print(dic!)
        print("------")
        
        if let pro : NSDictionary = dic!["project"] as? NSDictionary
        {
            cell?.testLbl.text = pro["name"] as? String
        }
        
        //print(dic!["final_mark"]!)
        
        if !(dic!["final_mark"]! is NSNull)
        {
            cell?.percent.text = "\(dic!["final_mark"]! as! Int)%"
            if (dic!["validated?"] as! Int == 0)
            {
                cell?.percent.textColor = UIColor.red
            }
            else
            {
                cell?.percent.textColor = UIColor.green
            }
        }
        else
        {
            cell?.percent.text = "~"
            cell?.percent.textColor = UIColor.black
        }
        return cell!
    }
    
}

