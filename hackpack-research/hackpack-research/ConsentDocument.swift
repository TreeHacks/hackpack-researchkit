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
    
    let consentDocument = ORKConsentDocument()
    consentDocument.title = "Example Consent"
    
    let consentSectionTypes: [ORKConsentSectionType] = [
        .overview,
        .dataGathering,
        .privacy,
        .dataUse,
        .studySurvey,
        .studyTasks,
        .withdrawing
    ]
    
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
        if (contentSectionType == ORKConsentSectionType.privacy){
            consentSection.summary = "We will not be sharing your data with anyone outside our team"
            consentSection.content = "In this study you will be asked to submit exercise information."
        }
        if (contentSectionType == ORKConsentSectionType.dataUse){
            consentSection.summary = "Data will be used to inform your physician and motivate you "
            consentSection.content = "In this study you will be asked to submit exercise information."
        }
        if (contentSectionType == ORKConsentSectionType.studySurvey){
            consentSection.summary = "To understand your results, we ask you to complete a questionnaire on your health history and physical condition."
            consentSection.content = "In this study you will be asked to submit exercise information."
        }
        if (contentSectionType == ORKConsentSectionType.studyTasks){
            consentSection.summary = "As part of the study you will receive occasional notifications in regards to your activity."
            consentSection.content = "In this study you will be asked to submit exercise information."
        }
        if (contentSectionType == ORKConsentSectionType.withdrawing){
            consentSection.summary = "You can withdraw from the study and stop receiving notifications at any time."
            consentSection.content = "In this study you will be asked to submit exercise information."
        }
        return consentSection
    }
    
    consentDocument.sections = consentSections
    
    consentDocument.addSignature(ORKConsentSignature(forPersonWithTitle: nil, dateFormatString: nil, identifier: "ConsentDocumentParticipantSignature"))
    
    
    return consentDocument
}
