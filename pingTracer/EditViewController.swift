//
//  EditViewController.swift
//  pingTracer
//
//  Created by Ivan Gutnik on 19/01/16.
//  Copyright (c) 2016 Ivan Gutnik. All rights reserved.
//

import UIKit
import SwiftyJSON

class EditViewController: UIViewController , UITextFieldDelegate{

    let path : String = NSBundle.mainBundle().pathForResource("jsonFile", ofType: "json") as String!
    
   
    
    @IBOutlet weak var addressInput: UITextField!
    
    @IBOutlet weak var nameInput: UITextField!
    
    @IBAction func cancelEdit(segue:UIStoryboardSegue) {
        _ = segue.sourceViewController as! EditViewController
    }
    
    @IBAction func saveEdit(segue:UIStoryboardSegue) {
        _ = segue.sourceViewController as! EditViewController
    }
    
    
    
    
    
    @IBAction func done(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: {})
        
    }
    
    
    
    @IBOutlet weak var packetSizeSlider: UISlider!
    
    @IBOutlet weak var packetSizeNumber: UILabel!
    
    @IBAction func packetSizeSliderAction(sender: UISlider) {
        let currentValue = Int(sender.value)
        
        packetSizeNumber.text = String(stringInterpolationSegment: currentValue)
        
        if currentValue == 63 { packetSizeNumber.text = "ICMP header only"   }
    }
    
    
    
    
    @IBOutlet weak var ttlSlider: UISlider!
    
    @IBOutlet weak var ttlNumber: UILabel!
    
    @IBAction func ttlSliderAction(sender: UISlider) {
        
        let currentValue = Int(sender.value)
        
        ttlNumber.text = String(stringInterpolationSegment: currentValue)

    }
    
    
    
    @IBOutlet weak var timeIntervalSlider: UISlider!
    
    @IBAction func timeIntervalSliderAction(sender: UISlider) {
        let currentValue = Float(sender.value)
        
        /*timeIntervalNumber.text = String(UTF8String: (String(stringInterpolationSegment: currentValue).substringToIndex(String(stringInterpolationSegment: currentValue).startIndex.advancedBy(3)))) */
        timeIntervalNumber.text = (String(stringInterpolationSegment: currentValue).substringToIndex(String(stringInterpolationSegment: currentValue).startIndex.advancedBy(3)))
        if timeIntervalNumber.text == "1.0" { timeIntervalNumber.text = "1" }
        if timeIntervalNumber.text == "2.0" { timeIntervalNumber.text = "2" }
        if timeIntervalNumber.text == "3.0" { timeIntervalNumber.text = "3" }
        if timeIntervalNumber.text == "4.0" { timeIntervalNumber.text = "4" }
        if timeIntervalNumber.text == "5.0" { timeIntervalNumber.text = "5" }
        
        print(timeIntervalSlider.value)
        print(timeIntervalNumber.text)
    }
    
    @IBOutlet weak var timeIntervalNumber: UILabel!
    
    
    
    @IBOutlet weak var pushNot: UISwitch!
    
    @IBAction func pushNotAction(sender: AnyObject) {
        
        for i in 1...numberOfRows {
            
            if address[i-1] == touchedCell{
        
        if pushNot.on {
            pushNotifications[i-1] = true
            
            
        }
        else {
            pushNotifications[i-1] = false
            
            
            
                } }}
        
    }
    
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    func lanCheck(addresss: String) -> Bool {
        
        var ret = false
        
        if addresss.characters.count >= 3{
            
            let m = addresss.substringToIndex(addresss.startIndex.advancedBy(3))
            
            if m == "192" || m == "172"{
                ret = true } }
        
        return ret
        
    }
    
    func textFieldDidChange(textField: UITextField) {
        
        if lanCheck(addressInput.text!) { pushNot.setOn(false, animated: true) }
        
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addressInput.delegate = self
        
        addressInput.addTarget(self, action: "textFieldDidChange:", forControlEvents: UIControlEvents.EditingChanged)
        
        if lanCheck(touchedCell) {  pushNot.enabled = false  }

        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        view.addGestureRecognizer(tap)
        
        timeIntervalSlider.minimumValue = 0.1
        timeIntervalSlider.maximumValue = 5
        ttlSlider.minimumValue = 1
        ttlSlider.maximumValue = 255
        packetSizeSlider.minimumValue = 63
        packetSizeSlider.maximumValue = 2432
        
        for i in 1...numberOfRows {
        
            if touchedCell == address[i-1] {
            
            timeIntervalSlider.value = Float(pocketInterval[i-1])/10
            timeIntervalNumber.text = String(Float(pocketInterval[i-1])/10)
                if timeIntervalNumber.text == "1.0" {timeIntervalNumber.text = "1"}
                if timeIntervalNumber.text == "2.0" {timeIntervalNumber.text = "2"}
                if timeIntervalNumber.text == "3.0" {timeIntervalNumber.text = "3"}
                if timeIntervalNumber.text == "4.0" {timeIntervalNumber.text = "4"}
                if timeIntervalNumber.text == "5.0" {timeIntervalNumber.text = "5"}
            ttlSlider.value = Float(ttl[i-1])
            ttlNumber.text = String(ttl[i-1])
            packetSizeSlider.value = Float(pocketSize[i-1])
            packetSizeNumber.text = String(pocketSize[i-1])
            
            addressInput.text = touchedCell
            nameInput.text = domens[i-1]
            
                if pushNotifications[i-1] == true {
                    
                    pushNot.setOn(true, animated: false)
                    
                    
                    
                    
                }
                    
                else if pushNotifications[i-1] == false {
                    
                    pushNot.setOn(false, animated: false)
                    
                    
                    
                    
                }}
        
        
        
        
        
        
        
        
        
        }
        
        
        
        

        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        
        
        
        let jsonData = NSData(contentsOfFile: path) as NSData!
        var readebleJSON = JSON(data: jsonData, options: NSJSONReadingOptions.MutableContainers, error: nil)
        let request = NSMutableURLRequest(URL: NSURL(string: server)!, cachePolicy: NSURLRequestCachePolicy.ReloadIgnoringLocalCacheData, timeoutInterval: 5)
        var response: NSURLResponse?
        var error: NSError?
        
        if segue.identifier == "Save"  {
            
            
            if numberOfRows != 0 {
            for i in 1...numberOfRows {
                
                if address[i-1] == touchedCell{
                    
            domens[i-1] = nameInput.text!
            pocketInterval[i-1] = Int(Float(timeIntervalSlider.value)*10)
                    print(pocketInterval[i-1])
            ttl[i-1] = Int(ttlSlider.value)
            pocketSize[i-1] = Int(packetSizeSlider.value)
            
            
            address[i-1] = addressInput.text!
                    if lanCheck(addressInput.text!) {  pushNotifications[i-1] = false  }
            //email = emailText.text
                    let domensData = NSKeyedArchiver.archivedDataWithRootObject(domens)
                    let ttlData = NSKeyedArchiver.archivedDataWithRootObject(ttl)
                    let pocketSizeData = NSKeyedArchiver.archivedDataWithRootObject(pocketSize)
                    let pocketIntervalData = NSKeyedArchiver.archivedDataWithRootObject(pocketInterval)
                    
                    
                    let pushNotificationsArrayData = NSKeyedArchiver.archivedDataWithRootObject(pushNotifications)
                    NSUserDefaults.standardUserDefaults().setObject(domensData, forKey: "domainsArray")
                    NSUserDefaults.standardUserDefaults().setObject(pushNotificationsArrayData, forKey: "pushNotificationsArray")
                    NSUserDefaults.standardUserDefaults().setObject(ttlData, forKey: "ttlArray")
                    NSUserDefaults.standardUserDefaults().setObject(pocketSizeData, forKey: "pocketSizeArray")
                    NSUserDefaults.standardUserDefaults().setObject(pocketIntervalData, forKey: "pocketIntervalArray")
                    
                    
            NSUserDefaults.standardUserDefaults().synchronize()
            
            //completeJSON()
                }
                
                } }
            if numberOfRows != 0 {
                
                let sum = numberOfRows + numberOfSort
                var array = [Int]()
                
                readebleJSON["numberOfDomains"] = JSON(numberOfRows)
                readebleJSON["token"] = JSON(token)
                
                
                readebleJSON["settings"]["email"] = JSON(email)
                
                
                for i in 1...sum { if domens[i-1] != "sort" { array += [i]  } }
                
                print(array)
                for i in 1...numberOfRows {
                    
                    let s = array[i-1]
                    
                    
                    
                    let domain = "domain"+String(i)
                    
                    
                    
                    
                    readebleJSON["domains"][domain]["domain"] = JSON(address[s-1])
                    readebleJSON["domains"][domain]["pushNotifications"] = JSON(pushNotifications[s-1])
                    
                    
                }
            
            print(readebleJSON)
            
            
            
            
            
            
        }
        
        request.HTTPBody = jsonData
        request.HTTPMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        print(readebleJSON)
        
        do {
            try NSURLConnection.sendSynchronousRequest(request, returningResponse: &response)
        } catch let error1 as NSError {
            error = error1
        }
        
        
        
        
        if let httpResponse = response as? NSHTTPURLResponse {
            if segue.identifier == "Done"  {
                
                
                
                
                
                
                //println(jsonString)
                print("HTTP response: \(httpResponse.statusCode)")
            }
            
        } else {
            if segue.identifier == "Done" {
                
                
                sendingAgain = true
                //NSUserDefaults.standardUserDefaults().setBool(true, forKey: "waitSettings")
                
                
                
                
                
                print("No HTTP response")
            }
            
            
        
        
        }
    
        } }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
