//
//  SurveyTask.swift
//  hackpack-research
//
//  Created by Joy Hsu on 11/10/16.
//  Updated by Olivia Brown on 1/27/18.
//  Copyright © 2018 TreeHacks. All rights reserved.
//

import Foundation
import ResearchKit

public var SurveyTask: ORKOrderedTask {
    
    var steps = [ORKStep]()
    
    let instructionStep = ORKInstructionStep(identifier: "IntroStep")
    instructionStep.title = "Basic Information"
    instructionStep.text = "The following will be some basic information about yourself"
    steps += [instructionStep]
    
    let nameAnswerFormat = ORKTextAnswerFormat(maximumLength: 20)
    nameAnswerFormat.multipleLines = false
    let nameQuestionStepTitle = "What is your name?"
    let nameQuestionStep = ORKQuestionStep(identifier: "QuestionStep", title: nameQuestionStepTitle, answer: nameAnswerFormat)
    steps += [nameQuestionStep]
    
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
    
    let nameAnswerFormat4 = ORKTextAnswerFormat(maximumLength: 20)
    nameAnswerFormat4.multipleLines = false
    let nameQuestionStepTitle4 = "What is your weight?"
    let nameQuestionStep4 = ORKQuestionStep(identifier: "QuestionStep4", title: nameQuestionStepTitle4, answer: nameAnswerFormat4)
    steps += [nameQuestionStep4]
    
    let questQuestionStepTitle = "What is your gender?"
    let textChoices = [
        ORKTextChoice(text: "Male", value: 0 as NSCoding & NSCopying & NSObjectProtocol),
        ORKTextChoice(text: "Female", value: 1 as NSCoding & NSCopying & NSObjectProtocol),
        ORKTextChoice(text: "Other", value: 2 as NSCoding & NSCopying & NSObjectProtocol)
    ]
    let questAnswerFormat: ORKTextChoiceAnswerFormat = ORKAnswerFormat.choiceAnswerFormat(with: .singleChoice, textChoices: textChoices)
    let questQuestionStep = ORKQuestionStep(identifier: "TextChoiceQuestionStep", title: questQuestionStepTitle, answer: questAnswerFormat)
    steps += [questQuestionStep]
    
    let questQuestionStepTitle2 = "Do you have diabetes?"
    let textChoices2 = [
        ORKTextChoice(text: "Yes", value: 0 as NSCoding & NSCopying & NSObjectProtocol),
        ORKTextChoice(text: "No", value: 1 as NSCoding & NSCopying & NSObjectProtocol)
    ]
    let questAnswerFormat2: ORKTextChoiceAnswerFormat = ORKAnswerFormat.choiceAnswerFormat(with: .singleChoice, textChoices: textChoices2)
    let questQuestionStep2 = ORKQuestionStep(identifier: "TextChoiceQuestionStep2", title: questQuestionStepTitle2, answer: questAnswerFormat2)
    steps += [questQuestionStep2]
    
    let questQuestionStepTitle3 = "Do you have heart disease?"
    let textChoices3 = [
        ORKTextChoice(text: "Yes", value: 0 as NSCoding & NSCopying & NSObjectProtocol),
        ORKTextChoice(text: "No", value: 1 as NSCoding & NSCopying & NSObjectProtocol)
    ]
    let questAnswerFormat3: ORKTextChoiceAnswerFormat = ORKAnswerFormat.choiceAnswerFormat(with: .singleChoice, textChoices: textChoices3)
    let questQuestionStep3 = ORKQuestionStep(identifier: "TextChoiceQuestionStep3", title: questQuestionStepTitle3, answer: questAnswerFormat3)
    steps += [questQuestionStep3]
    
    let summaryStep = ORKCompletionStep(identifier: "SummaryStep")
    summaryStep.title = "Done"
    summaryStep.text = "Thank you for participating!"
    steps += [summaryStep]
    
    return ORKOrderedTask(identifier: "SurveyTask", steps: steps)
}
