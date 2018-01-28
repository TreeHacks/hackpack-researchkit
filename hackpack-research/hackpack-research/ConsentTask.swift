//
//  ConsentTask.swift
//  hackpack-research
//
//  Created by Joy Hsu on 11/10/16.
//  Updated by Olivia Brown on 1/27/18.
//  Copyright © 2018 TreeHacks. All rights reserved.
//

import Foundation
import ResearchKit

public var ConsentTask: ORKOrderedTask {
    
    var steps = [ORKStep]()
    
    let consentDocument = ConsentDocument
    let visualConsentStep = ORKVisualConsentStep(identifier: "VisualConsentStep", document: consentDocument)
    steps += [visualConsentStep]
    
    let signature = consentDocument.signatures!.first as ORKConsentSignature!
    
    let reviewConsentStep = ORKConsentReviewStep(identifier: "ConsentReviewStep", signature: signature, in: consentDocument)
    
    reviewConsentStep.text = "Review Consent"
    reviewConsentStep.reasonForConsent = "Consent to join study"
    
    steps += [reviewConsentStep]
    
    return ORKOrderedTask(identifier: "ConsentTask", steps: steps)
    
    
}
