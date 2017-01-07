//
//  TasksViewController.swift
//  hackpack-research
//
//  Created by Joy Hsu on 11/14/16.
//  Copyright © 2016 Joy Hsu. All rights reserved.
//

import Foundation
import UIKit
import CareKit

class TasksViewController: UIViewController {
    
    var store: OCKCarePlanStore?
    override func viewDidLoad() {
        super.viewDidLoad()

        let fileManager = FileManager.default
        
        guard let documentDirectory =   fileManager.urls(for: .documentDirectory, in: .userDomainMask).last else {
            fatalError("Error: Unable to get the document directory")
        }
        
        let storeURL = documentDirectory.appendingPathComponent("MyCareKitStore")
        if !fileManager.fileExists(atPath: storeURL.path) {
            try! fileManager.createDirectory(at: storeURL,
                                             withIntermediateDirectories: true, attributes: nil)
        }
        
        store = OCKCarePlanStore(persistenceDirectoryURL: storeURL)
        
        
        store?.activity(forIdentifier: "Sample") { (success, activityOrNil, errorOrNil) -> Void in
            guard success else {
                // perform real error handling here.
                fatalError("An error occurred \(errorOrNil?.localizedDescription)")
            }
            
            if let activity = activityOrNil {
                // the activity already exists.
                
            } else {
                let startDay = NSDateComponents(year: 2016, month: 3, day: 15)
                let twiceADay = OCKCareSchedule.dailySchedule(withStartDate: startDay as DateComponents, occurrencesPerDay: 2)
                let medication = OCKCarePlanActivity(
                    identifier: "Sample",
                    groupIdentifier: nil,
                    type: .intervention,
                    title: "Sample",
                    text: "Test",
                    tintColor: nil,
                    instructions: "Instructions here.",
                    imageURL: nil,
                    schedule: twiceADay,
                    resultResettable: true,
                    userInfo: nil)
                
                self.store?.add(medication, completion: { (bool, error) in
                })
                
            }
        }
        
        
        let careCardViewController = OCKCareCardViewController(carePlanStore: store!)
        if let nav = self.navigationController {
            nav.pushViewController(careCardViewController, animated: true)
            print("got it")
        }
        else{
            print("no nav")
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
}
