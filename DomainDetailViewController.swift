//
//  DomainDetailViewController.swift
//  pingTracer
//
//  Created by Ivan Gutnik on 08/01/16.
//  Copyright (c) 2016 Ivan Gutnik. All rights reserved.
//

import UIKit
import SwiftyJSON
import GBPing


class DomainDetailViewController: UIViewController {
    
    let path : String = NSBundle.mainBundle().pathForResource("jsonFile", ofType: "json") as String!
   // let jonData = NSData(contentsOfFile: path)
    //let readebleJSON = JSON(data: jsoonData, options: NSJSONReadingOptions.MutableContainers, error: nil)
    
    var name: String = ""
    var adress: String = ""
    var macAdress: String = ""
    var port: String = ""
    var chooseLan: Bool = false
    //var allowPush: Bool = true
    
    //var token: String = "sample"
    
    // create the request & response
    var request = NSMutableURLRequest(URL: NSURL(string: server)!, cachePolicy: NSURLRequestCachePolicy.ReloadIgnoringLocalCacheData, timeoutInterval: 5)
    var response: NSURLResponse?
    var error: NSError?
    
    // create some JSON data and configure the request
    
    //var dict = ["name" : "", "token" : ""]  // The dictionary key has to be a String for JSON encoding
    
    
    
    @IBOutlet weak var controller: UISegmentedControl!
    
    @IBAction func controllerAction(sender: AnyObject) {
        if controller.selectedSegmentIndex == 0 { chooseLan = false}
        else if controller.selectedSegmentIndex == 1 { chooseLan = true}
    }
    
   /* @IBOutlet weak var allowPush: UISwitch!
    
    @IBAction func allowPushAction(sender: UISwitch) {
        
        if allowPush.on {
        
        }
        else {    }
        
    } */
    
    
    @IBOutlet weak var domainName: UITextField!
    
    @IBOutlet weak var domainAddres: UITextField!
    
    @IBOutlet weak var macAddres: UITextField!
    
    @IBOutlet weak var portNumber: UITextField!
    
    
    /*func completeJSON(){
        
        
        //var jsonData = NSData(contentsOfFile: path) as NSData!
        //var readebleJSON = JSON(data: jsonData, options: NSJSONReadingOptions.MutableContainers, error: nil)
        //numberOfRows = readebleJSON["numberOfDomains"].intValue
        
        if numberOfRows != 0 {
            
            readebleJSON["numberOfDomains"] = JSON(numberOfRows)
            readebleJSON["token"] = JSON(token)
            
            readebleJSON["settings"]["pocketInterval"] = JSON(pocketInterval)
            readebleJSON["settings"]["ttl"] = JSON(ttl)
            readebleJSON["settings"]["pocketSize"] = JSON(pocketSize)
            readebleJSON["settings"]["pingCount"] = JSON(pingCount)
            readebleJSON["settings"]["pushNotifications"] = JSON(pushNotifications)
            readebleJSON["settings"]["email"] = JSON(email)
            
            for i in 1...numberOfRows {
                
                var domain = "domain"+String(i)
                
                
                
                readebleJSON["domains"][domain]["name"] = JSON(domens[i-1])
                readebleJSON["domains"][domain]["domain"] = JSON(address[i-1])
                readebleJSON["domains"][domain]["mac"] = JSON(mac[i-1])
                readebleJSON["domains"][domain]["port"] = JSON(portArray[i-1])
                readebleJSON["domains"][domain]["selectedLan"] = JSON(selectedLan[i-1])
                
                println(readebleJSON["domains"][domain]["name"])
                
                
                
                
                
            }
            
            
            
            
            
            
            
            
            println(domens)  }
    
    } */

    
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        
        name = domainName.text
       //dict.updateValue(name, forKey: "name")
       //dict.updateValue(token, forKey: "token")
        
        let jsonData = NSData(contentsOfFile: path) as NSData!
        var readebleJSON = JSON(data: jsonData, options: NSJSONReadingOptions.MutableContainers, error: nil)
        var request = NSMutableURLRequest(URL: NSURL(string: server)!, cachePolicy: NSURLRequestCachePolicy.ReloadIgnoringLocalCacheData, timeoutInterval: 5)
        var response: NSURLResponse?
        var error: NSError?
        
        if segue.identifier == "Done" && domainName.text != "" {
            
              numberOfRows+=1
            println(numberOfRows)
              domens+=[domainName.text]
              address+=[domainAddres.text]
              mac+=[macAddres.text]
              portArray+=[portNumber.text]
              selectedLan+=[chooseLan.boolValue]
            
            var domensData = NSKeyedArchiver.archivedDataWithRootObject(domens)
            var addressData = NSKeyedArchiver.archivedDataWithRootObject(address)
            var macData = NSKeyedArchiver.archivedDataWithRootObject(mac)
            var portArrayData = NSKeyedArchiver.archivedDataWithRootObject(portArray)
            var selectedLanData = NSKeyedArchiver.archivedDataWithRootObject(selectedLan)
            
            
            NSUserDefaults.standardUserDefaults().setInteger(numberOfRows, forKey: "numberOfRows")
            NSUserDefaults.standardUserDefaults().setObject(domensData, forKey: "domainsArray")
            NSUserDefaults.standardUserDefaults().setObject(addressData, forKey: "addressArray")
            NSUserDefaults.standardUserDefaults().setObject(macData, forKey: "macArray")
            NSUserDefaults.standardUserDefaults().setObject(portArrayData, forKey: "portArray")
            NSUserDefaults.standardUserDefaults().setObject(selectedLanData, forKey: "selectedLanArray")
            NSUserDefaults.standardUserDefaults().synchronize()
            
            //completeJSON()
            
            if numberOfRows != 0 {
                
                readebleJSON["numberOfDomains"] = JSON(numberOfRows)
                readebleJSON["token"] = JSON(token)
                
                readebleJSON["settings"]["pocketInterval"] = JSON(pocketInterval)
                readebleJSON["settings"]["ttl"] = JSON(ttl)
                readebleJSON["settings"]["pocketSize"] = JSON(pocketSize)
                readebleJSON["settings"]["pingCount"] = JSON(pingCount)
                readebleJSON["settings"]["pushNotifications"] = JSON(pushNotifications)
                readebleJSON["settings"]["email"] = JSON(email)
                
                for i in 1...numberOfRows {
                    
                    var domain = "domain"+String(i)
                    
                    
                    
                    readebleJSON["domains"][domain]["name"] = JSON(domens[i-1])
                    readebleJSON["domains"][domain]["domain"] = JSON(address[i-1])
                    readebleJSON["domains"][domain]["mac"] = JSON(mac[i-1])
                    readebleJSON["domains"][domain]["port"] = JSON(portArray[i-1])
                    readebleJSON["domains"][domain]["selectedLan"] = JSON(selectedLan[i-1])
                    
                    println(readebleJSON["domains"][domain]["name"])
                    
                    
                    
                    
                    
                }}
            
        request.HTTPBody = jsonData
        request.HTTPMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        NSURLConnection.sendSynchronousRequest(request, returningResponse: &response, error: &error)
        
        if let httpResponse = response as? NSHTTPURLResponse {
            if segue.identifier == "Done" && name != "" {
                
                
                
                
                
                
                //println(jsonString)
                 println("HTTP response: \(httpResponse.statusCode)")
            }
            
        } else {
            if segue.identifier == "Done" && name != "" {
                
                
                waitCellArray.append(domainName.text)
                var waitInCellData = NSKeyedArchiver.archivedDataWithRootObject(waitCellArray)
                NSUserDefaults.standardUserDefaults().setObject(waitInCellData, forKey: "waitCellArray")
                NSUserDefaults.standardUserDefaults().synchronize() 
                
                sendingAgain = true
                
                
                
                /*timer3 = NSTimer(timeInterval: 2.0, target: self, selector: "waitSettingsFunc", userInfo: nil, repeats: true)
                NSRunLoop.currentRunLoop().addTimer(timer3, forMode: NSRunLoopCommonModes) */
                
            
            
            
            
            println("No HTTP response")
            }
        
       
            } }}
    
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        domainName.returnKeyType = UIReturnKeyType.Done
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        view.addGestureRecognizer(tap)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
