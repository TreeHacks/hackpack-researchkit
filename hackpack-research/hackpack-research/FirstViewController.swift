//
//  FirstViewController.swift
//  hackpack-research
//
//  Created by Joy Hsu on 11/10/16.
//  Copyright © 2016 Joy Hsu. All rights reserved.
//

import Foundation
import UIKit
import ResearchKit
import CareKit

class FirstViewController: UIViewController {
    
    //@IBOutlet weak var consentLabel: UILabel!
    //@IBOutlet weak var surveyLabel: UILabel!
    //@IBOutlet weak var startButton: UIButton!
    
    var store: OCKCarePlanStore?
    @IBAction func tasksTapped(_ sender: AnyObject) {
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
        
        
        store?.activity(forIdentifier: "Steps") { (success, activityOrNil, errorOrNil) -> Void in
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
                    identifier: "Steps",
                    groupIdentifier: nil,
                    type: .intervention,
                    title: "Steps",
                    text: "10,000 Steps",
                    tintColor: nil,
                    instructions: "Data shows the more you walk the less pain you have and the better quality of living. So step outside and enjoy the fresh air and birds chirping by walking your way to a PAD free life",
                    imageURL: nil,
                    schedule: twiceADay,
                    resultResettable: true,
                    userInfo: nil)
                
                self.store?.add(medication, completion: { (bool, error) in
                }) // don't know why it wanted self here
                
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
    
    var isSurvey = false
    
    @IBAction func consentTapped(sender : AnyObject) {
        let taskViewController = ORKTaskViewController(task: ConsentTask, taskRun: nil)
        taskViewController.view.tintColor = UIColor.blue // pick the color
        taskViewController.delegate = self
        present(taskViewController, animated: true, completion: nil)
    }
    
    @IBAction func surveyTapped(sender : AnyObject) {
        let taskViewController = ORKTaskViewController(task: SurveyTask, taskRun: nil)
        taskViewController.delegate = self
        taskViewController.view.tintColor = UIColor.blue // pick the color
        present(taskViewController, animated: true, completion: nil)
        isSurvey = true
        //surveyLabel.backgroundColor = UIColor.blue
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //startButton.alpha = 0.0
        isSurvey = false
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}




extension FirstViewController : ORKTaskViewControllerDelegate {
    
    func taskViewController(
        _ taskViewController: ORKTaskViewController,
        didFinishWith reason: ORKTaskViewControllerFinishReason,
        error               : Error?) {
        
        print("entering the dismiss function")
        if error != nil {
            NSLog("Error: \(error)")
        }
        else {
            // Handle results with taskViewController.result
            switch reason {
            case .completed:
                // Check if the result is the user's consent signature
                if let signatureResult =
                    taskViewController.result.stepResult(forStepIdentifier:
                        "your identifier"
                        )?.firstResult as? ORKConsentSignatureResult {
                    if signatureResult.consented {
                        // Got the user signature
                        //consentLabel.backgroundColor = UIColor.blue
                    }
                }
                else {
                    // Survey forms
                }
                
            default: break
            }
        }
        
        // Dismiss the task’s view controller when the task finishes
        taskViewController.dismiss(animated: true, completion: nil)
        //consentLabel.backgroundColor = UIColor.blue
        if isSurvey == true {
            //surveyLabel.backgroundColor = UIColor.blue
            //startButton.alpha = 1.0
        } else {
            //consentLabel.backgroundColor = UIColor.blue
        }
        print("hello")
    }
    
}
