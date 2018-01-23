//
//  ViewController.swift
//  Swifty
//
//  Created by Jeremy SCHOTTE on 1/22/18.
//  Copyright © 2018 Jeremy SCHOTTE. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    var token : String = ""
    var userId : Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getTokenAccess()
        self.navigationItem.rightBarButtonItem = nil
        self.text.delegate = self
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func displayError(e: NSError)
    {
        let myalert = UIAlertController(title: "Error", message: NSError.description(), preferredStyle: UIAlertControllerStyle.alert)
        
        myalert.addAction(UIAlertAction(title: "OK", style: .default) { (action:UIAlertAction!) in
            print("Selected")
        })
        self.present(myalert, animated: true)
    }
    
    @IBOutlet weak var text: UITextField!
    
    func getUserId(user: String)
    {
        let params = "\(user.addingPercentEncoding(withAllowedCharacters:NSCharacterSet.urlQueryAllowed)!)"
        let url = NSURL(string : "https://api.intra.42.fr/v2/users?filter[login]=\(params)")
        let request = NSMutableURLRequest(url: url! as URL)
        request.httpMethod = "GET"
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        let task = URLSession.shared.dataTask(with: request as URLRequest)
        {
            (data, response, error) in
            //print(response!)
            if error != nil{
                self.displayError(e: error! as NSError)
            }
            else if let d = data
            {
                do {
                    if let dic : NSArray = try JSONSerialization.jsonObject(with: d, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSArray
                    {
                        DispatchQueue.main.async
                        {
                            if (dic.count == 1)
                            {
                                self.ouptLbl.text = "user found, loading..."
                                UIApplication.shared.isNetworkActivityIndicatorVisible = true

                                let x = dic.object(at: 0) as? NSDictionary
                                self.userId = x!["id"]! as! Int
                                print(self.userId)
                                self.getUserData()
                            }
                            else
                            {
                                self.ouptLbl.text = "user not found"
                            }
                        }
                    }
                }
                catch (let err){
                    self.displayError(e: err as NSError)
                }
            }
        }
        task.resume()
    }
    @IBOutlet weak var ouptLbl: UILabel!
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        print("test")
        self.view.endEditing(true)
        if (textField.text != "")
        {
            getUserId(user: text.text!)
        }
        return true
    }
    
    func getUserData()
    {
        
        let url = NSURL(string : "https://api.intra.42.fr/v2/users/\(userId)")
        let request = NSMutableURLRequest(url: url! as URL)
        request.httpMethod = "GET"
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        let task = URLSession.shared.dataTask(with: request as URLRequest)
        {
            (data, response, error) in
            //print(response!)
            if error != nil{
                self.displayError(e: error! as NSError)
            }
            else if let d = data
            {
                do {
                    if let dic : NSDictionary = try JSONSerialization.jsonObject(with: d, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSDictionary
                    {
                        print(dic)
                        DispatchQueue.main.async
                        {
                            self.ouptLbl.text = ""
                            UIApplication.shared.isNetworkActivityIndicatorVisible = false
                            self.performSegue(withIdentifier: "showDetail", sender: dic)
                        }
                    }
                }
                catch (let err){
                    self.displayError(e: err as NSError)
                }
            }
        }
        task.resume()
    }
    
    
    func getTokenAccess()
    {
        
        let CUSTOMER_KEY = "XXXX"
        let CUSTOMER_SECRET = "XXXX"
        
        let url = NSURL(string: "https://api.intra.42.fr/oauth/token")
        let request = NSMutableURLRequest(url: url! as URL)
        request.httpMethod = "POST"
        request.httpBody = "grant_type=client_credentials&client_id=\(CUSTOMER_KEY)&client_secret=\(CUSTOMER_SECRET)&redirect_uri=https://intra.42.fr".data(using: String.Encoding.utf8)
        let task = URLSession.shared.dataTask(with: request as URLRequest)
        {
            (data, response, error) in
            //print(response!)
            if error != nil{
                self.displayError(e: error! as NSError)
            }
            else if let d = data {
                do {
                    if let dic : NSDictionary = try JSONSerialization.jsonObject(with: d, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSDictionary
                    {
                        //print(dic)
                        self.token = dic["access_token"] as! String
                        DispatchQueue.main.async
                        {
                            print(self.token)
                        }
                    }
                }
                catch (let err){
                    self.displayError(e: err as NSError)
                }
            }
        }
        task.resume()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.identifier == "showDetail"
        {
            if let vc = segue.destination as? TestView
            {
                vc.data = sender as? NSDictionary
            }
        }
    }

}

