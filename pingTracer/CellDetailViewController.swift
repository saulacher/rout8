//
//  CellDetailViewController.swift
//  pingTracer
//
//  Created by Ivan Gutnik on 08/01/16.
//  Copyright (c) 2016 Ivan Gutnik. All rights reserved.
//

import UIKit
import SystemConfiguration
import SwiftyJSON


class CellDetailViewController: UIViewController {

    
    let path : String = NSBundle.mainBundle().pathForResource("jsonFile", ofType: "json") as String!
    
    var chooseLan:Bool = false
    
    
    @IBOutlet weak var domainNameEdit: UITextField!
    
    
    @IBOutlet weak var domainAdressEdit: UITextField!
    
    
    @IBOutlet weak var macEdit: UITextField!
    
    
    @IBOutlet weak var portEdit: UITextField!
    
    
    
    @IBOutlet weak var lanController: UISegmentedControl!
    
    @IBAction func lanCobtrollerAction(sender: AnyObject) {
        
        if lanController.selectedSegmentIndex == 0 { chooseLan = false}
        else if lanController.selectedSegmentIndex == 1 { chooseLan = true}
        
    }
    
    var editDomen  = 0
    
  /*  func editTapped(){
    
    navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Done", style: .Plain, target: self, action: "doneTapped")
    
        //domainNameEdit.text = touchedCell
        
        domainNameEdit.text = domens[editDomen]
        
        if selectedLan[editDomen] == (true) { lanController.selectedSegmentIndex = 1; chooseLan = true  }
        else { lanController.selectedSegmentIndex = 0; chooseLan = false }
        
        domainAdressEdit.text = address[editDomen]
        
        macEdit.text = mac[editDomen]
        
        portEdit.text = portArray[editDomen]
        
        
        
        /*
        for i in 1...numberOfRows {
            
            if touchedCell == domens[i-1] {
                
                
                editDomen = i-1
                
                domainAdressEdit.text = address[i-1]
                
                macEdit.text = mac[i-1]
                
                portEdit.text = portArray[i-1]
                if selectedLan[i-1] == (true) { lan.text = "lan"  }
                else { lan.text = "not lan" }
                
            }
            
            
            
        } */
        
        domainNameEdit.userInteractionEnabled = true
        domainAdressEdit.userInteractionEnabled = true
        macEdit.userInteractionEnabled = true
        portEdit.userInteractionEnabled = true
        lanController.userInteractionEnabled = true
        
        domainName.hidden = true
        domainAddress.hidden = true
        macText.hidden = true
        portText.hidden = true
        lan.hidden = true
        
        domainNameEdit.hidden = false
        domainAdressEdit.hidden = false
        macEdit.hidden = false
        portEdit.hidden = false
        lanController.hidden = false
        
    } */
  /*
    func completeJSON(){
        
        
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
    println(readebleJSON)
    
    } */

    
    
 /*   func doneTapped(){
    
    navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Edit", style: .Plain, target: self, action: "editTapped")
        
        

        let jsonData = NSData(contentsOfFile: path) as NSData!
        var readebleJSON = JSON(data: jsonData, options: NSJSONReadingOptions.MutableContainers, error: nil)
        var request = NSMutableURLRequest(URL: NSURL(string: server)!, cachePolicy: NSURLRequestCachePolicy.ReloadIgnoringLocalCacheData, timeoutInterval: 5)
        var response: NSURLResponse?
        var error: NSError?

        
        domens[editDomen] = domainNameEdit.text
        address[editDomen] = domainAdressEdit.text
        mac[editDomen] = macEdit.text
        portArray[editDomen] = portEdit.text
        if chooseLan {
            selectedLan[editDomen] = true }
        else if !chooseLan { selectedLan[editDomen] = false }
        
        domainName.text = domainNameEdit.text
        
        
        
        domainName.text = domens[editDomen]
        
        if selectedLan[editDomen] == (true) { lan.text = "lan"  }
        else { lan.text = "not lan" }
        domainAddress.text = address[editDomen]
        
        macText.text = mac[editDomen]
        
        portText.text = portArray[editDomen]

        
        
        domainNameEdit.userInteractionEnabled = false
        domainAdressEdit.userInteractionEnabled = false
        macEdit.userInteractionEnabled = false
        portEdit.userInteractionEnabled = false
        lanController.userInteractionEnabled = false
    
        domainName.hidden = false
        domainAddress.hidden = false
        macText.hidden = false
        portText.hidden = false
        lan.hidden = false
        
        domainNameEdit.hidden = true
        domainAdressEdit.hidden = true
        macEdit.hidden = true
        portEdit.hidden = true
        lanController.hidden = true
        
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
            
                
                
                
                
                
                
                //println(jsonString)
                println("HTTP response: \(httpResponse.statusCode)")
            
            
        } else {
            
                
            if !contains(waitCellArray, domainAddress.text!){
                
                waitCellArray.append(domainAddress.text!)}
            sendingAgain = true

            
                var waitInCellData = NSKeyedArchiver.archivedDataWithRootObject(waitCellArray)
                NSUserDefaults.standardUserDefaults().setObject(waitInCellData, forKey: "waitCellArray")
                NSUserDefaults.standardUserDefaults().synchronize()
                
                
                FirstViewController().sendingAgainFunc()
                
                
                
                
                
                println("No HTTP response")
        
            
            
        } } */

    
    
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        //modalTransitionStyle = .FlipHorizontal
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        view.addGestureRecognizer(tap)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Edit", style: .Plain, target: self, action: "editTapped")
        println(touchedCell)
        for i in 1...numberOfRows + numberOfSort {
            
            if touchedCell == address[i-1] {
                
                
                editDomen = i-1}}

        
       // domainName.text = touchedCell
        
        
        
        domainNameEdit.userInteractionEnabled = true
        domainAdressEdit.userInteractionEnabled = false
        macEdit.userInteractionEnabled = false
        portEdit.userInteractionEnabled = false
        lanController.userInteractionEnabled = false
        
        
        domainNameEdit.text = domens[editDomen]
        
        if selectedLan[editDomen] == (true) { lanController.selectedSegmentIndex = 1  }
        else { lanController.selectedSegmentIndex = 0 }
        
        chooseLan = selectedLan[editDomen]
        
        domainAdressEdit.text = address[editDomen]
        
        macEdit.text = mac[editDomen]
        
        portEdit.text = portArray[editDomen]

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
