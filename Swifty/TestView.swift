//
//  TestView.swift
//  Swifty
//
//  Created by Jeremy SCHOTTE on 1/22/18.
//  Copyright © 2018 Jeremy SCHOTTE. All rights reserved.
//

import UIKit

class TestView: UIViewController ,UITableViewDelegate, UITableViewDataSource
{
    var data : NSDictionary?
    var level : Double = 0.0
    var cursus : NSDictionary = [:]
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        tableVIew.delegate = self
        tableVIew.dataSource = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBOutlet weak var tableVIew: UITableView!
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return 3
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.row == 1 || indexPath.row == 2
        {
            return 300 // for static cell height
        }
        else {
            return 200 // for dynamic cell height
        }
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.row == 1 || indexPath.row == 2
        {
            return 300
        }
        else
        {
            return 200
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        
        if (indexPath.row == 0)
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "customCell") as? customCell
            
            if let name : String = data?["displayname"] as? String
            {
                cell?.nameLbl.text = name
            }
            
            if let mail : String = data?["email"] as? String
            {
                cell?.mailLbl.text = mail
            }
            
            if let phone : String = data?["phone"] as? String
            {
                cell?.phoneLbl.text = phone
            }
            
            //cell?.mailLbl.text = data?["email"] as? String
            //cell?.phoneLbl.text = data?["phone"] as? String
            
            //let x = data!["wallet"]
            //cell?.walletLbl.text = "\(x!)₳"
            
            if let x : Int = data?["wallet"] as? Int
            {
                cell?.walletLbl.text = "\(x)₳"
            }
            
            //cell?.pntLbl.text = "\(data!["correction_point"]!)"
            
            if let point : Int = data?["correction_point"] as? Int
            {
                cell?.pntLbl.text = "\(point)"
            }
            
            DispatchQueue.global(qos: .userInitiated).async
            {
                let imageUrl:NSURL = NSURL(string: (self.data?["image_url"] as? String)!)!
                
                if let imageData = NSData(contentsOf: imageUrl as URL)
                {
                    let image = UIImage(data: imageData as Data)
                    DispatchQueue.main.async
                    {
                        cell?.imageVIew.image = image
                    }
                }
            }
            
            if let cursus : NSArray = data!["cursus_users"] as? NSArray
            {
                let x = cursus.object(at: 0) as? NSDictionary
                self.cursus = x!
                self.level = x!["level"] as! Double
                cell?.lvlLbl.text = "\(String(describing: x!["level"]!))"
                cell?.progressLbl.progress = Float(self.level.truncatingRemainder(dividingBy: 1))
            }
            
            return cell!
        }
        else if (indexPath.row == 1)
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cellSkills")  as? skillCell
            
            if let skills : NSArray = cursus["skills"] as? NSArray
            {
                cell?.skills = skills
                
            }
            return cell!
        }
        else
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cellProject")  as? projectCell
            
            if let project : NSMutableArray = data!["projects_users"] as? NSMutableArray
            {
                //let x = project.object(at: 0) as? NSDictionary
                //cell?.project = project
                //print(project)
                let newproj : NSMutableArray = []
                for proj in project
                {
                    let dic = proj as? NSDictionary
                    if let arraytest = dic!["cursus_ids"] as! NSArray?
                    {
                        print(arraytest)
                        
                        if (arraytest.contains(1))
                        {
                            for elem in arraytest
                            {
                                print(elem)
                            }
                            if let pro : NSDictionary = dic!["project"] as? NSDictionary
                            {
                                if (pro["parent_id"] is NSNull)
                                {
                                    newproj.add(proj)
                                    //print("new")
                                }
                            }
                        }
                    }
                }
                //print(newproj)
                cell?.project = newproj
            }
            return cell!
        }
    }
}
