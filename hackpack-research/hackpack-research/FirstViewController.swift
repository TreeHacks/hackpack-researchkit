//
//  FirstViewController.swift
//  hackpack-research
//
//  Created by Joy Hsu on 1/7/17.
//  Copyright © 2017 Joy Hsu. All rights reserved.
//

import Foundation
import UIKit
import ResearchKit


class FirstViewController: UIViewController {
    
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
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
            switch reason {
            case .completed:
                if let signatureResult =
                    taskViewController.result.stepResult(forStepIdentifier:
                        "your identifier"
                        )?.firstResult as? ORKConsentSignatureResult {
                    if signatureResult.consented {
                        
                    }
                }
                else {
                }
                
            default: break
            }
        }
        
        // Dismiss the task’s view controller when the task finishes
        taskViewController.dismiss(animated: true, completion: nil)

    }
    
    
}

