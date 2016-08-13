//
//  DriverRegistrationViewController.swift
//  BZRide
//
//  Created by Sooraj on 8/13/16.
//  Copyright (c) 2016 Sooraj. All rights reserved.
//

import UIKit

class DriverRegistrationViewController: UIViewController {
    
    @IBOutlet var tbFstName: UITextField!
    @IBOutlet var tbLastName: UITextField!
    @IBOutlet var tbemail: UITextField!
    @IBOutlet var tbPW: UITextField!
    @IBOutlet var tbPWConfrm: UITextField!
    @IBOutlet var tbAddress1: UITextField!
    @IBOutlet var tbAddress2: UITextField!
    @IBOutlet var tbPh: UITextField!
    
    @IBOutlet var btnRegister: UIButton!
    
    @IBOutlet var ScrlViewDriverReg: UIScrollView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        ScrlViewDriverReg.contentSize.height=900
        
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
  
   @IBAction func SaveDriver(sender: AnyObject) {
    
    if tbFstName.text == "" || tbLastName.text == ""  || tbemail.text == "" || tbPW.text == "" || tbPWConfrm.text == "" || tbAddress1.text == "" || tbAddress2.text == "" || tbPh.text == ""  {
        
        
       
            Validation()
        
        

    }
    else{
        if tbPW.text != tbPWConfrm.text{
            
            let myAlert = UIAlertView()
            //myAlert.title = "Title"
            myAlert.message = "Password mismatch"
            myAlert.addButtonWithTitle("Ok")
            myAlert.delegate = self
            myAlert.show()
            
        }
        else{
            
           
            var request = NSMutableURLRequest(URL: NSURL(string: "http://bzride.com/bzride/RegisterDriver.php")!)
            var session = NSURLSession.sharedSession()
            request.HTTPMethod = "POST"
            
            var params = ["FirstName":tbFstName.text, "LastName":tbLastName.text,"email":tbemail.text, "Password":tbPW.text,"Address1":tbAddress1.text, "Address2":tbAddress2.text, "Address1":tbPh.text] as Dictionary<String, String>
            
            var err: NSError?
            request.HTTPBody = NSJSONSerialization.dataWithJSONObject(params, options: nil, error: &err)
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.addValue("application/json", forHTTPHeaderField: "Accept")
            
            var task = session.dataTaskWithRequest(request, completionHandler: {data, response, error -> Void in
                println("Response: \(response)")
                var strData = NSString(data: data, encoding: NSUTF8StringEncoding)
                println("Body: \(strData)")
                var err: NSError?
                var json = NSJSONSerialization.JSONObjectWithData(data, options: .MutableLeaves, error: &err) as? NSDictionary
                
                // Did the JSONObjectWithData constructor return an error? If so, log the error to the console
                if(err != nil) {
                    println(err!.localizedDescription)
                    let jsonStr = NSString(data: data, encoding: NSUTF8StringEncoding)
                    println("Error could not parse JSON: '\(jsonStr)'")
                }
                else {
                    // The JSONObjectWithData constructor didn't return an error. But, we should still
                    // check and make sure that json has a value using optional binding.
                    if let parseJSON = json {
                        // Okay, the parsedJSON is here, let's get the value for 'success' out of it
                        var success = parseJSON["status"] as? String
                        //println("Succes: \(success)")
                        
                        if success == "T"{
                           // println("Succes")
                             let myAlert = UIAlertView()
                            //myAlert.title = "Title"
                            myAlert.message = "Successfully Registered"
                            myAlert.addButtonWithTitle("Ok")
                            myAlert.delegate = self
                            myAlert.show()
                        }
                        else{
                            let myAlert = UIAlertView()
                            //myAlert.title = "Title"
                            myAlert.message = "Please Try Again"
                            myAlert.addButtonWithTitle("Ok")
                            myAlert.delegate = self
                            myAlert.show()
                        }

                        
                    }
                    else {
                        // Woa, okay the json object was nil, something went worng. Maybe the server isn't running?
                        let jsonStr = NSString(data: data, encoding: NSUTF8StringEncoding)
                        println("Error could not parse JSON: \(jsonStr)")
                    }
                }
            })
            
            task.resume()
           // return true
            
            
           // let myAlert = UIAlertView()
            //myAlert.title = "Title"
            //myAlert.message = "Successfully Registered"
            //myAlert.addButtonWithTitle("Ok")
            //myAlert.delegate = self
            //myAlert.show()
        }
        
    }
    
       
    }
    
    func Validation() {
        
        
        
        let myAlert = UIAlertView()
        //myAlert.title = "Title"
        myAlert.message = "Please FIll All Fields"
        myAlert.addButtonWithTitle("Ok")
        myAlert.delegate = self
        myAlert.show()
    }

   
    
    
    
    

}
