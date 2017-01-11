//
//  ConsentDocument.swift
//  hackpack-research
//
//  Created by Joy Hsu on 11/10/16.
//  Copyright © 2016 Joy Hsu. All rights reserved.
//


import Foundation
import ResearchKit

public var ConsentDocument: ORKConsentDocument {
    
    // Creates new consent document with title
    let consentDocument = ORKConsentDocument()
    consentDocument.title = "Example Consent"
    
    // Creates consent in-built types
    let consentSectionTypes: [ORKConsentSectionType] = [
        .overview,
        .dataGathering,
        .privacy,
        .dataUse,
        .studySurvey,
        .studyTasks,
        .withdrawing
    ]
    
    // Sets text
    let consentSections: [ORKConsentSection] = consentSectionTypes.map { contentSectionType in
        let consentSection = ORKConsentSection(type: contentSectionType)
        if (contentSectionType == ORKConsentSectionType.overview){
            consentSection.summary = "The following will inform you about our study"
            consentSection.content = "In this study you will be asked to submit exercise information."
        }
        if (contentSectionType == ORKConsentSectionType.dataGathering){
            consentSection.summary = "We will primarily be tracking your activity levels"
            consentSection.content = "In this study you will be asked to submit exercise information."
        }
        /* 
         Insert your own code here that creates the summary and content for .privacy,.dataUse,.studySurvey,.studyTasks,.withdrawing!
        */
        return consentSection
    }
    
    consentDocument.sections = consentSections
    
    // Add signature
    consentDocument.addSignature(ORKConsentSignature(forPersonWithTitle: nil, dateFormatString: nil, identifier: "ConsentDocumentParticipantSignature"))
    
    
    return consentDocument
}
