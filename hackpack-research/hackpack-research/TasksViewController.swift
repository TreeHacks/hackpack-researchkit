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
        //
        //        let viewController = OCKCareCardViewController(carePlanStore: carePlanStoreManager.store)
        //        viewController.maskImage = UIImage(named: "heart")
        //        viewController.smallMaskImage = UIImage(named: "small-heart")
        //        //viewController.maskImageTintColor = UIColor.darkGray()
        let fileManager = FileManager.default
        
        guard let documentDirectory =   fileManager.urls(for: .documentDirectory, in: .userDomainMask).last else {
            fatalError("*** Error: Unable to get the document directory! ***")
        }
        
        let storeURL = documentDirectory.appendingPathComponent("MyCareKitStore")
        if !fileManager.fileExists(atPath: storeURL.path) {
            try! fileManager.createDirectory(at: storeURL,
                                             withIntermediateDirectories: true, attributes: nil)
        }
        
        store = OCKCarePlanStore(persistenceDirectoryURL: storeURL)
        
        
        store?.activity(forIdentifier: "Vicodin") { (success, activityOrNil, errorOrNil) -> Void in
            guard success else {
                // perform real error handling here.
                fatalError("*** An error occurred \(errorOrNil?.localizedDescription) ***")
            }
            
            if let activity = activityOrNil {
                
                // the activity already exists.
                
            } else {
                let startDay = NSDateComponents(year: 2016, month: 3, day: 15)
                let twiceADay = OCKCareSchedule.dailySchedule(withStartDate: startDay as DateComponents, occurrencesPerDay: 2)
                let medication = OCKCarePlanActivity(
                    identifier: "Vicodin",
                    groupIdentifier: nil,
                    type: .intervention,
                    title: "Vicodin",
                    text: "5mg/500mg",
                    tintColor: nil,
                    instructions: "Take twice daily with food. May cause drowsiness. It is not recommended to drive with this medication. For any severe side effects, please contact your physician.",
                    imageURL: nil,
                    schedule: twiceADay,
                    resultResettable: true,
                    userInfo: nil)
                
                self.store?.add(medication, completion: { (bool, error) in
                }) // don't know why it wanted self here
                
            }
        }
        
        
        let careCardViewController = OCKCareCardViewController(carePlanStore: store!)
        //        self.present(careCardViewController, animated: true)
        if let nav = self.navigationController {
            nav.pushViewController(careCardViewController, animated: true)
            print("got it")
        }
        else{
            print("no nav")
        }
        //crashes after this point
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
