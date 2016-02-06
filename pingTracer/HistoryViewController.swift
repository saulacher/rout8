//
//  HistoryViewController.swift
//  pingTracer
//
//  Created by Ivan Gutnik on 19/01/16.
//  Copyright (c) 2016 Ivan Gutnik. All rights reserved.
//

import UIKit
import Charts



class HistoryViewController: UIViewController {

    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var tokenString: UITextField!
    
    @IBOutlet weak var lineChartView: LineChartView!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tokenString.text = token
        
        var name = UILabel()
        name.numberOfLines = 1
        name.text = touchedCell
        name.textAlignment = .Center
        //self.title = touchedCell
        
        
        
        
        navigationItem.title = touchedCell
        
        //setNavigationBarTitleText(touchedCell)
        //navigationItem.titleView = name
        //navigationItem.titleView = name
        
        print(touchedCell)
        
        lineChartView.noDataText = "You need to provide data for the chart."

        let months = ["Jan", "Feb", "Mar", "Apr", "May", "Jun"]
        let unitsSold = [20.0, 4.0, 6.0, 3.0, 12.0, 16.0]
        
        setChart(months, values: unitsSold)
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setChart(dataPoints: [String], values: [Double]) {
        
        var dataEntries: [ChartDataEntry] = []
        
        for i in 0..<dataPoints.count {
            let dataEntry = ChartDataEntry(value: values[i], xIndex: i)
            dataEntries.append(dataEntry)
        }
        
        
        
        var colors: [UIColor] = []
        
        for _ in 0..<dataPoints.count {
            let red = Double(arc4random_uniform(256))
            let green = Double(arc4random_uniform(256))
            let blue = Double(arc4random_uniform(256))
            
            let color = UIColor(red: CGFloat(red/255), green: CGFloat(green/255), blue: CGFloat(blue/255), alpha: 1)
            colors.append(color)
        }
        
        
        
        
        let lineChartDataSet = LineChartDataSet(yVals: dataEntries, label: "Units Sold")
        let lineChartData = LineChartData(xVals: dataPoints, dataSet: lineChartDataSet)
        lineChartView.data = lineChartData
        
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
