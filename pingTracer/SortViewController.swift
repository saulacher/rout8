//
//  SortViewController.swift
//  pingTracer
//
//  Created by Ivan Gutnik on 18/01/16.
//  Copyright (c) 2016 Ivan Gutnik. All rights reserved.
//

import Foundation
import UIKit



class SortViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {


    @IBAction func doneAction(sender: AnyObject) {
        
        self.dismissViewControllerAnimated(true, completion: {});
        //FirstViewController().reloadT()
        print(address)
        print(domens)
        print(numberOfRows)
    }

    @IBOutlet weak var doneSort: UIBarButtonItem!

    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var textInput: UITextField!
    
    @IBAction func addAction(sender: AnyObject) {
    
    textFieldShouldReturn(textInput)
    
    }
        
     
    
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        TableViewCell1().stopPing1()
       
        //pingTimer.invalidate()
        //println(pingTimer)
        //self.navigationItem.leftBarButtonItem = self.editButtonItem()
        self.tableView.setEditing(true, animated: false)
        self.setEditing(true, animated: true)
        textInput.tag = 2
        textInput.returnKeyType = UIReturnKeyType.Done
        
        textInput.delegate = self
        
        let longpress = UILongPressGestureRecognizer(target: self, action: "longPressGestureRecognized:")
        
        tableView.addGestureRecognizer(longpress)
        
        tableView.tableFooterView = UIView(frame: CGRectZero)

    
        
        
        
    }

    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }


    func textFieldDidEndEditing(textField: UITextField) {
        
        
        
        if textInput.tag == 2 &&   textInput.text != ""{
            
            
            numberOfSort+=1
            
            print(numberOfSort)
            
            domens+=["sort"]
            address += [String(UTF8String: textInput.text!)!]
            pushNotifications+=[false]
            addNew = true
            pocketInterval+=[1]
            ttl+=[1]
            pocketSize+=[1]
            pingArray += ["sort"]
            
            
            
            let domensData = NSKeyedArchiver.archivedDataWithRootObject(domens)
            var addressData = NSKeyedArchiver.archivedDataWithRootObject(address)
            var ttlData = NSKeyedArchiver.archivedDataWithRootObject(ttl)
            var pocketSizeData = NSKeyedArchiver.archivedDataWithRootObject(pocketSize)
            var pocketIntervalData = NSKeyedArchiver.archivedDataWithRootObject(pocketInterval)
            var pushNotificationsArrayData = NSKeyedArchiver.archivedDataWithRootObject(pushNotifications)
            
            
            
            NSUserDefaults.standardUserDefaults().setInteger(numberOfRows, forKey: "numberOfRows")
            NSUserDefaults.standardUserDefaults().setInteger(numberOfSort, forKey: "numberOfSort")

            
            NSUserDefaults.standardUserDefaults().setObject(domensData, forKey: "domainsArray")
            NSUserDefaults.standardUserDefaults().setObject(addressData, forKey: "addressArray")
            NSUserDefaults.standardUserDefaults().setObject(pushNotificationsArrayData, forKey: "pushNotificationsArray")
            NSUserDefaults.standardUserDefaults().setObject(ttlData, forKey: "ttlArray")
            NSUserDefaults.standardUserDefaults().setObject(pocketSizeData, forKey: "pocketSizeArray")
            NSUserDefaults.standardUserDefaults().setObject(pocketIntervalData, forKey: "pocketIntervalArray")
            NSUserDefaults.standardUserDefaults().synchronize()
            
            
            let indexPath = NSIndexPath(forRow: 0, inSection: 0)
            
            self.tableView.insertRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
            //self.tableView.reloadData()
            textInput.text = ""
                
                
            }
            
            
            
        
            
        
    }

    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }

    //////////////////// long press moving
    
    
    func longPressGestureRecognized(gestureRecognizer: UIGestureRecognizer) {
        
        let longPress = gestureRecognizer as! UILongPressGestureRecognizer
        
        let state = longPress.state
        
        var locationInView = longPress.locationInView(tableView)
        
        var indexPath = tableView.indexPathForRowAtPoint(locationInView)
        
        struct My {
            
            static var cellSnapshot : UIView? = nil
            
        }
        struct Path {
            
            static var initialIndexPath : NSIndexPath? = nil
            
        }
        
        switch state {
        case UIGestureRecognizerState.Began:
            if indexPath != nil {
                Path.initialIndexPath = indexPath
                let cell = tableView.cellForRowAtIndexPath(indexPath!) as UITableViewCell!
                My.cellSnapshot  = snapshopOfCell(cell)
                var center = cell.center
                
                My.cellSnapshot!.center = center
                
                My.cellSnapshot!.alpha = 0.0
                
                tableView.addSubview(My.cellSnapshot!)
                
                UIView.animateWithDuration(0.25, animations: { () -> Void in
                    center.y = locationInView.y
                    
                    My.cellSnapshot!.center = center
                    
                    My.cellSnapshot!.transform = CGAffineTransformMakeScale(1.05, 1.05)
                    
                    My.cellSnapshot!.alpha = 0.98
                    
                    cell.alpha = 0.0
                    
                    }, completion: { (finished) -> Void in
                        
                        if finished {
                            
                            cell.hidden = true
                            
                        }
                        
                })
                
            }
        case UIGestureRecognizerState.Changed:
            var center = My.cellSnapshot!.center
            center.y = locationInView.y
            My.cellSnapshot!.center = center
            if ((indexPath != nil) && (indexPath != Path.initialIndexPath)) {
                swap(&domens[numberOfRows + numberOfSort - indexPath!.row - 1], &domens[numberOfRows + numberOfSort - Path.initialIndexPath!.row - 1])
                swap(&address[numberOfRows + numberOfSort - 1 - indexPath!.row], &address[numberOfRows + numberOfSort - 1 - Path.initialIndexPath!.row])
                swap(&ttl[numberOfRows + numberOfSort - 1 - indexPath!.row], &ttl[numberOfRows + numberOfSort - 1 - Path.initialIndexPath!.row])
                swap(&pocketSize[numberOfRows + numberOfSort - 1 - indexPath!.row], &pocketSize[numberOfRows + numberOfSort - 1 - Path.initialIndexPath!.row])
                swap(&pocketInterval[numberOfRows + numberOfSort - 1 - indexPath!.row], &pocketInterval[numberOfRows + numberOfSort - 1 - Path.initialIndexPath!.row])
                swap(&pushNotifications[numberOfRows + numberOfSort - 1 - indexPath!.row], &pushNotifications[numberOfRows + numberOfSort - 1 - Path.initialIndexPath!.row])
               /* swap(&pingArray[numberOfRows + numberOfSort - 1 - indexPath!.row], &pingArray[numberOfRows + numberOfSort - 1 - Path.initialIndexPath!.row]) */
                
                
                var domensData = NSKeyedArchiver.archivedDataWithRootObject(domens)
                var addressData = NSKeyedArchiver.archivedDataWithRootObject(address)
                var ttlData = NSKeyedArchiver.archivedDataWithRootObject(ttl)
                var pocketSizeData = NSKeyedArchiver.archivedDataWithRootObject(pocketSize)
                var pocketIntervalData = NSKeyedArchiver.archivedDataWithRootObject(pocketInterval)
                var pushNotificationsArrayData = NSKeyedArchiver.archivedDataWithRootObject(pushNotifications)
                
                
                
                
                NSUserDefaults.standardUserDefaults().setInteger(numberOfRows, forKey: "numberOfRows")
                NSUserDefaults.standardUserDefaults().setInteger(numberOfSort, forKey: "numberOfSort")
                NSUserDefaults.standardUserDefaults().setObject(domensData, forKey: "domainsArray")
                NSUserDefaults.standardUserDefaults().setObject(addressData, forKey: "addressArray")
                NSUserDefaults.standardUserDefaults().setObject(pushNotificationsArrayData, forKey: "pushNotificationsArray")
                NSUserDefaults.standardUserDefaults().setObject(ttlData, forKey: "ttlArray")
                NSUserDefaults.standardUserDefaults().setObject(pocketSizeData, forKey: "pocketSizeArray")
                NSUserDefaults.standardUserDefaults().setObject(pocketIntervalData, forKey: "pocketIntervalArray")
                NSUserDefaults.standardUserDefaults().synchronize()

                
                tableView.moveRowAtIndexPath(Path.initialIndexPath!, toIndexPath: indexPath!)
                Path.initialIndexPath = indexPath
            }
        default:
            let cell = tableView.cellForRowAtIndexPath(Path.initialIndexPath!) as UITableViewCell!
            cell.hidden = false
            cell.alpha = 0.0
            UIView.animateWithDuration(0.25, animations: { () -> Void in
                My.cellSnapshot!.center = cell.center
                My.cellSnapshot!.transform = CGAffineTransformIdentity
                My.cellSnapshot!.alpha = 0.0
                cell.alpha = 1.0
                }, completion: { (finished) -> Void in
                    if finished {
                        Path.initialIndexPath = nil
                        My.cellSnapshot!.removeFromSuperview()
                        My.cellSnapshot = nil
                    }
            })
        }
    //self.tableView.reloadData()
    }
    
    func snapshopOfCell(inputView: UIView) -> UIView {
        UIGraphicsBeginImageContextWithOptions(inputView.bounds.size, false, 0.0)
        inputView.layer.renderInContext(UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext() as UIImage
        UIGraphicsEndImageContext()
        let cellSnapshot : UIView = UIImageView(image: image)
        cellSnapshot.layer.masksToBounds = false
        cellSnapshot.layer.cornerRadius = 0.0
        cellSnapshot.layer.shadowOffset = CGSizeMake(-5.0, 0.0)
        cellSnapshot.layer.shadowRadius = 5.0
        cellSnapshot.layer.shadowOpacity = 0.4
        return cellSnapshot
    }
    


    //////////////////// Table view data source
    let startCellHeight: CGFloat = 100
    
    let normalCellHeight: CGFloat = 66.0
    
    let sortCellHeight: CGFloat = 33.0
    
   // var newCellIndexPath: NSIndexPath?

    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        
        /*if newCellIndexPath == indexPath {
            newCellIndexPath = nil
            return startCellHeight
        }*/
        if domens[numberOfRows + numberOfSort  - indexPath.row - 1] == "sort"  {
            
            print(numberOfRows + numberOfSort  - indexPath.row - 1)
            //newCellIndexPath = nil
            return sortCellHeight
            
        }
        
        
        print(domens)
        print(numberOfRows + numberOfSort  - indexPath.row - 1)
        
        return normalCellHeight
        
        
        
        
        
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return numberOfRows + numberOfSort
    }

    
    var cellPath = NSIndexPath()
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        // Configure the cell...
        
        let cell = self.tableView.dequeueReusableCellWithIdentifier("domenCell2", forIndexPath: indexPath) as! TableViewCellSort
        
        //var waitImage = UIImage(named: imageName)
        print("tableview")
        
        
        
        /*
        if address.last == address[numberOfRows + numberOfSort  - indexPath.row - 1 ] && addNew {
            newCellIndexPath = indexPath ; addNew = false}
        
        tableView.beginUpdates()
        tableView.endUpdates()
        
        if newCellIndexPath != nil {
            // This ensures, that the cell is fully visible once expanded
            tableView.scrollToRowAtIndexPath(indexPath, atScrollPosition: .None, animated: true)
        }
        */
        
        
        if domens[numberOfRows + numberOfSort  - indexPath.row - 1] == "sort" {
            
            
            
            cell.textLabel!.backgroundColor = UIColor.clearColor()
            cell.contentView.backgroundColor = UIColor.lightGrayColor()
            cell.backgroundColor = UIColor.lightGrayColor()
            
            
            cell.affressLabel.text = ""
            cell.sortLabel.text = ""
            cell.textLabel!.text = address[numberOfRows + numberOfSort  - indexPath.row - 1]
            cell.textLabel?.textAlignment = .Center
            cell.textLabel?.textColor = UIColor.whiteColor()
            cell.userInteractionEnabled = true
            
            
            
            
            
            
            
        }
            
            
            
        else { cell.contentView.backgroundColor = UIColor.whiteColor()
            cell.backgroundColor = UIColor.whiteColor()
            cell.textLabel?.textColor = UIColor.blackColor()
            cell.userInteractionEnabled = true
            cell.imageMove = UIImageView(image: UIImage(named: "move.png"))
            cell.affressLabel.text = address[numberOfRows + numberOfSort  - indexPath.row - 1]
            cell.sortLabel.text = ""
             }
        
        /*
        
        else if waitCellArray != [String()] { if  contains(waitCellArray, address[numberOfRows + numberOfSort  - indexPath.row - 1]) {
            
            //let frame = cell.textLabel?.frame
            
            cell.imageMove = UIImageView(image: UIImage(named: "move.png"))
            cell.affressLabel.text = address[numberOfRows + numberOfSort  - indexPath.row - 1]
            cell.sortLabel.text = ""
            //tableView.insertRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Bottom )
            //cell.textLabel!.text = address[numberOfRows + numberOfSort  - indexPath.row - 1];
            //cell.detailTextLabel?.text = waitText
            //cell.textLabel?.textAlignment = .Left
            //cell.textLabel!.frame.origin.x = 20
            //cell.imageView?.image = waitImage
            //cell.accessoryView = UIImageView(image: UIImage(named: "sowGB.png"))
            //cell.accessoryView!.frame = CGRectMake(0, 0, 22, 22)
            cell.contentView.backgroundColor = UIColor.whiteColor()
            cell.backgroundColor = UIColor.whiteColor()
            cell.textLabel?.textColor = UIColor.blackColor()
            cell.userInteractionEnabled = true
            
            
            //waitInCell()
            
            
            /*timer = NSTimer(timeInterval: 2.0, target: self, selector: "waitInCell", userInfo: nil, repeats: true)
            NSRunLoop.currentRunLoop().addTimer(timer, forMode: NSRunLoopCommonModes)*/
            
            /*if waitCellArray != [String]() { var delay = NSTimer.scheduledTimerWithTimeInterval(4, target: self, selector: ("waitInCell()"), userInfo: nil, repeats: false) } */
            } }
        else {
            
            cell.imageMove = UIImageView(image: UIImage(named: "move.png"))
            println(waitCellArray)
            
            //let frame = cell.textLabel?.frame
            //cell.textLabel!.text = address[numberOfRows + numberOfSort  - indexPath.row - 1];
            cell.affressLabel.text = address[numberOfRows + numberOfSort  - indexPath.row - 1]
            cell.sortLabel.text = ""
            
            //cell.accessoryView = UIImageView()
            //cell.detailTextLabel?.text = waitText
            //cell.textLabel?.textAlignment = .Left
            //cell.textLabel!.frame.origin.x = 20
            cell.textLabel?.textColor = UIColor.blackColor()
            cell.userInteractionEnabled = true
            //cell.imageView?.image = waitImage
            //cell.accessoryView = UIImageView(image: UIImage(named: "sowGB.png"))
            //cell.accessoryView!.frame = CGRectMake(0, 0, 22, 22)
            
            
            cell.contentView.backgroundColor = UIColor.whiteColor()
            cell.backgroundColor = UIColor.whiteColor() } }
            
        else {
            cell.imageMove = UIImageView(image: UIImage(named: "move.png"))
            
            cell.affressLabel.text = address[numberOfRows + numberOfSort  - indexPath.row - 1]
            cell.sortLabel.text = ""
            
            //let frame = cell.textLabel?.frame
            println(address)
            //println([indexPath.row])
            //cell.textLabel!.text = address[numberOfRows + numberOfSort  - indexPath.row - 1];
            //cell.accessoryView = UIImageView(image: UIImage(named: "sowGB.png"))
            //cell.accessoryView!.frame = CGRectMake(0, 0, 22, 22)
            //cell.accessoryView = UIImageView()
            //cell.detailTextLabel?.text = waitText
            //cell.textLabel?.textAlignment = .Left
            //cell.textLabel!.frame.origin.x = 20
            cell.textLabel?.textColor = UIColor.blackColor()
            cell.userInteractionEnabled = true
            //cell.imageView?.image = waitImage
            
            
            cell.contentView.backgroundColor = UIColor.whiteColor()
            cell.backgroundColor = UIColor.whiteColor()
            
        } */
        
        return cell
    }

    func delButton() {
    
        
        tableView(tableView, commitEditingStyle: UITableViewCellEditingStyle.Delete, forRowAtIndexPath: cellPath)
        //tableView(tableView, editActionsForRowAtIndexPath: cellPath)
        
    }
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }

    /*
    func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [AnyObject]?  {
        // 1
        
        var shareAction = UITableViewRowAction(style: UITableViewRowActionStyle.Default, title: "Share" , handler: { (action:UITableViewRowAction!, indexPath:NSIndexPath!) -> Void in
            // 2
            /*let shareMenu = UIAlertController(title: nil, message: "Share using", preferredStyle: .ActionSheet)
            
            let twitterAction = UIAlertAction(title: "Twitter", style: UIAlertActionStyle.Default, handler: nil)
            let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel, handler: nil)
            
            shareMenu.addAction(twitterAction)
            shareMenu.addAction(cancelAction) */
            
            
            //self.presentViewController(shareMenu, animated: true, completion: nil)
        })
        // 3
        var rateAction = UITableViewRowAction(style: UITableViewRowActionStyle.Default, title: "Rate" , handler: { (action:UITableViewRowAction!, indexPath:NSIndexPath!) -> Void in
            
            
            // 4
            /*
            let rateMenu = UIAlertController(title: nil, message: "Rate this App", preferredStyle: .ActionSheet)
            
            let appRateAction = UIAlertAction(title: "Rate", style: UIAlertActionStyle.Default, handler: nil)
            let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel, handler: nil)
            
            rateMenu.addAction(appRateAction)
            rateMenu.addAction(cancelAction)
            
            self.presentViewController(rateMenu, animated: true, completion: nil)*/
        })
        //rateAction.backgroundColor =  UIColor(patternImage: UIImage(named:"settings.png")!)
        // 5
        return [shareAction,rateAction]
    }
    */
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
        if editingStyle == UITableViewCellEditingStyle.Delete {
        
            
            var sort = false
            
            if domens[numberOfRows + numberOfSort  - indexPath.row - 1] == "sort" {sort = true}
            
            domens.removeAtIndex(numberOfRows + numberOfSort  - indexPath.row - 1)
            address.removeAtIndex(numberOfRows + numberOfSort  - indexPath.row - 1)
            pushNotifications.removeAtIndex(numberOfRows + numberOfSort  - indexPath.row - 1)
            pocketInterval.removeAtIndex(numberOfRows + numberOfSort  - indexPath.row - 1)
            pocketSize.removeAtIndex(numberOfRows + numberOfSort  - indexPath.row - 1)
            ttl.removeAtIndex(numberOfRows + numberOfSort  - indexPath.row - 1)
           // pingArray.removeAtIndex(numberOfRows + numberOfSort  - indexPath.row - 1)

            
            if !sort{
                numberOfRows -= 1}
                
            else if sort {  print(numberOfSort); numberOfSort -= 1}
            
            sendingAgain = true
            //NSUserDefaults.standardUserDefaults().setBool(true, forKey: "sendingAgain")
            
            let domensData = NSKeyedArchiver.archivedDataWithRootObject(domens)
            var addressData = NSKeyedArchiver.archivedDataWithRootObject(address)
            var ttlData = NSKeyedArchiver.archivedDataWithRootObject(ttl)
            var pocketSizeData = NSKeyedArchiver.archivedDataWithRootObject(pocketSize)
            var pocketIntervalData = NSKeyedArchiver.archivedDataWithRootObject(pocketInterval)
            var pushNotificationsArrayData = NSKeyedArchiver.archivedDataWithRootObject(pushNotifications)

            
            
            
            NSUserDefaults.standardUserDefaults().setInteger(numberOfRows, forKey: "numberOfRows")
            NSUserDefaults.standardUserDefaults().setInteger(numberOfSort, forKey: "numberOfSort")
            NSUserDefaults.standardUserDefaults().setObject(domensData, forKey: "domainsArray")
            NSUserDefaults.standardUserDefaults().setObject(addressData, forKey: "addressArray")
            NSUserDefaults.standardUserDefaults().setObject(pushNotificationsArrayData, forKey: "pushNotificationsArray")
            NSUserDefaults.standardUserDefaults().setObject(ttlData, forKey: "ttlArray")
            NSUserDefaults.standardUserDefaults().setObject(pocketSizeData, forKey: "pocketSizeArray")
            NSUserDefaults.standardUserDefaults().setObject(pocketIntervalData, forKey: "pocketIntervalArray")
            NSUserDefaults.standardUserDefaults().synchronize()
            
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
            
            //tableView.insertRowsAtIndexPaths([4], withRowAnimation: UITableViewRowAnimation.Automatic)
            //self.tableView.reloadData()
            
            
            //self.tableView.reloadData()
            
            fromDelete = true
            FirstViewController().sendingAgainFunc()

        
        
        
        }
    
    
    
    
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
    }














}