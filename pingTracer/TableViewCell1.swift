//
//  FirstTableViewCell.swift
//  pingTracer
//
//  Created by Ivan Gutnik on 21/01/16.
//  Copyright (c) 2016 Ivan Gutnik. All rights reserved.
//

import UIKit
import GBPing
var pingTimer = NSTimer()

var pingArray = [String]()

class TableViewCell1: UITableViewCell, GBPingDelegate {

    
    //var ping1 = GBPing()
    
    
    var ping1 = GBPing()
    
    
    var n = 0
    
    func ping(pinger: GBPing!, didFailToSendPingWithSummary summary: GBPingSummary!, error: NSError!) {
        print("FFSENT> \(summary) \(error)")
    }
    
    func ping(pinger: GBPing!, didFailWithError error: NSError!) {
        print("FAIL> \(error)")
    }
    
    func ping(pinger: GBPing!, didReceiveReplyWithSummary summary: GBPingSummary!) {
        
        var reply = String(stringInterpolationSegment: summary.rtt)
        
        if numberOfRows != 0{
            var i = 0
            
            for v in 1...numberOfRows {
                
                if nameLabel.text == String(address[v-1]) {
                    i = v-1 }
                
            
               // pingArray[i] = reply.substringToIndex(reply.startIndex.advancedBy(5))
                print(pingArray)
            }}
            
        
        
         self.pingLabel1.textColor = UIColor.blueColor()
        
        pingLabel1.text = reply.substringToIndex(reply.startIndex.advancedBy(5))
        //FirstViewController().reloadT()

        
        
        
        print("1REPLY> \(summary)")
        
    }
    
    func ping(pinger: GBPing!, didReceiveUnexpectedReplyWithSummary summary: GBPingSummary!) {
        
        //pingLabel1.text = String(stringInterpolationSegment: summary.rtt)
        //FirstViewController().reloadT()
        print("RREPLY> \(summary)")
        
        
    }
    
    func ping(pinger: GBPing!, didSendPingWithSummary summary: GBPingSummary!) {
        
        
        
        
        print("SENT> \(summary)")
        
        
    }
    
    func ping(pinger: GBPing!, didTimeoutWithSummary summary: GBPingSummary!) {
        print("TIMEOUT> \(summary)")
    }
    
    func startPing() {
        
        
        if numberOfRows != 0{
    var i = 0
        
        for v in 1...numberOfRows {
        
            if nameLabel.text == String(address[v-1]) {
                i = v-1 }
        
        }
            
                
        

            
        
                    
            
                    
                    ping1.host = nameLabel.text
                    ping1.delegate = self
                    ping1.timeout = NSTimeInterval(Float(pocketInterval[i])/10)
                    print(ping1.timeout)
                    ping1.pingPeriod = 0.9
                    ping1.ttl = UInt(ttl[i])
                    ping1.payloadSize = UInt(pocketSize[i])
            
                    print(ping1.pingPeriod)
        
        if internetReachabolity == false {
            statusLabel.text = "no internet"}
        else if internetReachabolity == true { statusLabel.text = "" }
                    ping1.setupWithBlock({ success, error in
                        if success {
                            self.ping1.startPinging()
                            let ns = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: Selector("stopPing1"), userInfo: nil, repeats: false)
                            
                            
                            
                        }
                        
                        else { self.pingLabel1.text = "0.0"; self.pingLabel1.textColor = UIColor.redColor()   }
                        
                    })
        
        
                    
        }} /*
        
        }
        
        else if i == 2 {
            
            
            
            
            ping2.host = nameLabel.text
            ping2.delegate = self
            ping2.timeout = 1.0
            ping2.pingPeriod = 0.9
            println(ping2.host)
            ping2.setupWithBlock({ success, error in
                if success {
                    self.ping2.startPinging()
                    let ns = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: Selector("stopPing2"), userInfo: nil, repeats: false)
                    
                }
                
            })
            
        }
        
        
            } */
    
    
    
    func stopPing1() {
        
        ping1.stop()
        ping1 = GBPing()
        
        
    }
    /*
    func stopPing2() {
        
        ping2.stop()
        ping2 = GBPing()
        
        
    } */

    @IBOutlet weak var statusLabel: UILabel!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var nameLabel2: UILabel!
    
    
    
    @IBOutlet weak var pingLabel1: UILabel!
    
    
    @IBOutlet weak var lanLabel: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        statusLabel.text = "no internet"
        //pingLabel1.text = ""
        
        if numberOfRows != 0 {
        
        if nameLabel.text != "sort" {
            
            
            
            startPing() }
        
        if nameLabel.text != "sort" {
        
            var i = 0
            
            for v in 1...numberOfRows {
                
                if nameLabel.text == String(address[v-1]) {
                    i = v-1 }
                
            }
            
            
            
        pingTimer = NSTimer(timeInterval: 2.0, target: self, selector: "startPing", userInfo: nil, repeats: true)
                NSRunLoop.currentRunLoop().addTimer(pingTimer, forMode: NSRunLoopCommonModes)
        
            n = numberOfRows}}
        
        
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    

}
