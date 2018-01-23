//
//  skillCell.swift
//  Swifty
//
//  Created by Jeremy SCHOTTE on 1/22/18.
//  Copyright © 2018 Jeremy SCHOTTE. All rights reserved.
//

import UIKit

class skillCell: UITableViewCell, UITableViewDataSource, UITableViewDelegate{

    var skills : NSArray = []
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
        skillTable.delegate = self
        skillTable.dataSource = self
        
        skillTable.estimatedRowHeight = 300
        skillTable.rowHeight = UITableViewAutomaticDimension
        // Initialization code
    }

    @IBOutlet weak var skillTable: UITableView!
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBOutlet weak var tableVIew: UITableView!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return skills.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "subSkill") as? subSkill
        
        let dic = skills[indexPath.row] as? NSDictionary
        
        let name = dic!["name"] as! String
        let level = dic!["level"] as! Double
        
        cell?.nameSkill?.text = "\(name)) - \(level)"
        cell?.progressSkill.progress = Float(level.truncatingRemainder(dividingBy: 1))
        cell?.nameSkill.numberOfLines = 0
        
        return cell!
    }

}
