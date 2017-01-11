//
//  SurveyTask.swift
//  hackpack-research
//
//  Created by Joy Hsu on 11/10/16.
//  Copyright © 2016 Joy Hsu. All rights reserved.
//

import Foundation
import ResearchKit

public var SurveyTask: ORKOrderedTask {
    
    // Creates variable to keep track of ORKSteps
    var steps = [ORKStep]()
    
    // Creates instruction steps with title and text
    let instructionStep = ORKInstructionStep(identifier: "IntroStep")
    instructionStep.title = "Basic Information"
    instructionStep.text = "The following will be some basic information about yourself"
    steps += [instructionStep]
    
    // Initializes format and details
    let nameAnswerFormat = ORKTextAnswerFormat(maximumLength: 20)
    nameAnswerFormat.multipleLines = false
    let nameQuestionStepTitle = "What is your name?"
    let nameQuestionStep = ORKQuestionStep(identifier: "QuestionStep", title: nameQuestionStepTitle, answer: nameAnswerFormat)
    // Adds to steps variable
    steps += [nameQuestionStep]
    
    //Create numbers 1-75
    var textChoices1 = [ORKTextChoice]()
    for x in 1...75{
        let idx = x-1
        textChoices1.append(ORKTextChoice(text: "\(x)", value: idx as NSCoding & NSCopying & NSObjectProtocol))
    }
    
    let nameAnswerFormat2 = ORKValuePickerAnswerFormat(textChoices:textChoices1)
    let nameQuestionStepTitle2 = "What is your age?"
    let nameQuestionStep2 = ORKQuestionStep(identifier: "QuestionStep2", title: nameQuestionStepTitle2, answer: nameAnswerFormat2)
    steps += [nameQuestionStep2]
    
    let nameAnswerFormat3 = ORKHeightAnswerFormat()
    let nameQuestionStepTitle3 = "What is your height?"
    let nameQuestionStep3 = ORKQuestionStep(identifier: "QuestionStep3", title: nameQuestionStepTitle3, answer: nameAnswerFormat3)
    steps += [nameQuestionStep3]
    
    /* 
        Insert code here to create your own questions to add to the survey! You can test out different types of question formats to fit different needs.
    */
    
    let summaryStep = ORKCompletionStep(identifier: "SummaryStep")
    summaryStep.title = "Done"
    summaryStep.text = "Thank you for participating!"
    steps += [summaryStep]
    
    return ORKOrderedTask(identifier: "SurveyTask", steps: steps)
}
