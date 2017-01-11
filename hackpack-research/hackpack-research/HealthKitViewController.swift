//
//  HealthKitViewController.swift
//  hackpack-research
//
//  Created by Joy Hsu on 11/27/16.
//  Copyright © 2016 Joy Hsu. All rights reserved.
//

import Foundation
import UIKit
import HealthKit

class HealthKitViewController: UIViewController
{
    let healthStore = HKHealthStore()
    override func viewDidLoad() {
        super.viewDidLoad()
        checkAvailability()
        getStepCount(sender: self)
    }
    
    func checkAvailability() {
        // Checks if healthdata for stepcount and heat and body mass is available from user
        if HKHealthStore.isHealthDataAvailable() {
            let stepsCount = NSSet(object: HKQuantityType.quantityType(forIdentifier: HKQuantityTypeIdentifier.stepCount))
            let sharedObjects = NSSet(objects: HKQuantityType.quantityType(forIdentifier: HKQuantityTypeIdentifier.height),HKQuantityType.quantityType(forIdentifier: HKQuantityTypeIdentifier.bodyMass))
            
            /*
                Insert your own code here to request access to other information from HealthStore aside from step count, height, and body mass! You can test this in simulator by deleting the App from iPhone and re-building it.
            */
            
            healthStore.requestAuthorization(toShare: sharedObjects as? Set<HKSampleType>, read: stepsCount as? Set<HKObjectType>, completion: { (success, err) in
                self.getStepCount(sender: self)
            })
            
        } else {
        }
    }
    
    func recentSteps(completion: @escaping (Double, [Double], NSError?) -> ()) {
        let type = HKSampleType.quantityType(forIdentifier: HKQuantityTypeIdentifier.stepCount)
        
        // Gets date range for last 7 days
        let date = Date()
        let calendar = Calendar.current
        let curryear = calendar.component(.year, from: date)
        let currmonth = calendar.component(.month, from: date)
        let currday = calendar.component(.day, from: date)
        let last = DateComponents(calendar: nil,
                                  timeZone: nil,
                                  era: nil,
                                  year: curryear,
                                  month: currmonth,
                                  day: currday-7,
                                  hour: nil,
                                  minute: nil,
                                  second: nil,
                                  nanosecond: nil,
                                  weekday: nil,
                                  weekdayOrdinal: nil,
                                  quarter: nil,
                                  weekOfMonth: nil,
                                  weekOfYear: nil,
                                  yearForWeekOfYear: nil)
        
        let dates = calendar.date(from: last)!
        
        // Create query and append to allSteps variable
        let predicate = HKQuery.predicateForSamples(withStart: dates, end: Date(), options: [])
        let query = HKSampleQuery(sampleType: type!, predicate: predicate, limit: 0, sortDescriptors: nil) {
            query, results, error in
            var steps: Double = 0
            var allSteps = [Double]()
            if let myResults = results {
                for result in myResults as! [HKQuantitySample] {
                    print(myResults)
                    steps += result.quantity.doubleValue(for: HKUnit.count())
                    allSteps.append(result.quantity.doubleValue(for: HKUnit.count()))
                }
            }
            completion(steps, allSteps, error as NSError?)
            
        }
        
        // Executes query through healthstore
        healthStore.execute(query)
    }
    
    // Sets label text to steps count
    @IBOutlet var stepCount : UILabel!
    @IBOutlet var avgCount : UILabel!
    @IBAction func getStepCount(sender: AnyObject) {
        recentSteps() { steps, allSteps, error in
            // Uses dispatchqueue for difference in UI thread
            DispatchQueue.main.sync {
                var avgStep: Double = 0
                avgStep = steps/7
                self.stepCount.text = "Total \(steps) steps"
                self.avgCount.text = "Avg \(avgStep) steps"
                
                /*
                    You can display the information given from the HealthApp differently here or alter it as you will!
                */
                
            }
            
        };
    }
}




