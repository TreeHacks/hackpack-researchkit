# hackpack-researchkit

In this iOS hackpack we will be tackling on Apple's ResearchKit and Healthkit using Swift 3 and XCode 8. The functions include creating a consent form to request consent from users, distributing a survey form with different types of questions, and access point for the iOS App to collect data from iPhone's Health App.

--------------------------------------------------------------------------------

To begin, let's create a standard XCode project. We want to embed ResearchKit and HealthKit into our iOS App through the steps below.

**Step 1:** To download the latest version of ResearchKit, and type in  Terminal *git clone [https://github.com/ResearchKit/ResearchKit](https://github.com/ResearchKit/ResearchKit)*. The, build the project by running ResearchKit framework.

**Step 2:** Drag *ResearchKit.xcodeproj* into your current iOS project.

![addresearch](https://cloud.githubusercontent.com/assets/6894456/21839806/9a6d44d8-d78e-11e6-8c07-640776371eb2.png)

**Step 3:** Go to *General* settings on your project and scroll down to *Embedded Binaries*. Clik the + button and add in ResearchKit.

![embed](https://cloud.githubusercontent.com/assets/6894456/21839842/d9c05b98-d78e-11e6-9857-5e3a72ee917d.png)

**Step 4:** To use HealthKit, go to *Capabilities* settings and scroll to the bottom to turn on HealthKit access, and it should automatically add it in your project.

**Step 5:** In your info.plist, right click to open as source code, then paste in:
```swift
    <key>NSHealthShareUsageDescription</key>
    <string>Need to share healthkit information</string>
    <key>NSHealthUpdateUsageDescription</key>
    <string>Need healthkit to track steps</string>
```

**Step 6:** *(optional)* If you are testing your code in XCode simulator, you have to simulate data from the Health App in order to get results form HealthStore. To do so, run the iPhone simulator, click on the hardware tab home button, then navigate to the Health App. Tap on the category you want, and use the + button to add in data. For example, when getting step count, go to *Activities* to add in different amounts of exercise for different days.

These steps above install ResearchKit and HealthKit for your Xcode project!

--------------------------------------------------------------------------------

The *master* branch includes the completed code with ResearchKit consent & survey forms as well as HealthKit access & step count. The *starterkit* branch includes the code with comments on each part of the project. 

**Main.storyboard** creates navigation controller, buttons to link to functions for Consent, Survey, and Steps Count, textboxes to describe uses, and a separate view controller for HealthKit data. Buttons and textboxes are aligns to fit every spec of iPhone product.

**FirstViewController.swift** links consent and survey buttons to their specific functions, which presents a new taskViewController with specific tasks (ex. ConsentTask, SurveyTasks) executed. The taskViewController inherits from ORKTaskViewController to dismiss viewController after action is completed.

**ConsentDocument.swift** and **ConsentTasks.swift** creates a consent form to ask for user consent to research study. **ConsentTasks.swift** creates an ORKOrderedTask to increment through the created document. **ConsentDocument.swift** makes an ORKConsentDocument with specific question for users to agree to, and a signature portion of the form. An example of pre-built consent items looks like this:
```Swift
let consentSectionTypes: [ORKConsentSectionType] = [
        .overview,
        .dataGathering,
        .privacy,
        .dataUse,
        .studySurvey,
        .studyTasks,
        .withdrawing
    ]
```

**SurveyTask.swift** creates a simple survey form for users to fill out. It is also an ORKOrderedTask that initializes format and details of questions asked as well as a summary step to increment through. A sample question looks like this:
```Swift
    let nameAnswerFormat = ORKTextAnswerFormat(maximumLength: 20)
    nameAnswerFormat.multipleLines = false
    let nameQuestionStepTitle = "What is your name?"
    let nameQuestionStep = ORKQuestionStep(identifier: "QuestionStep", title: nameQuestionStepTitle, answer: nameAnswerFormat)
    steps += [nameQuestionStep]
```

**HealthKitViewController.swift** asks for HealthKit access and gets user's step count from the past seven days. Keep in mind that the HealthKit access form will only appear once as the user only needs to accepts the agreement once. Sample code for requesting authorization of information looks like this:
```Swift
        if HKHealthStore.isHealthDataAvailable() {
            let stepsCount = NSSet(object: HKQuantityType.quantityType(forIdentifier: HKQuantityTypeIdentifier.stepCount))
            let sharedObjects = NSSet(objects: HKQuantityType.quantityType(forIdentifier: HKQuantityTypeIdentifier.height),HKQuantityType.quantityType(forIdentifier: HKQuantityTypeIdentifier.bodyMass))
            
            healthStore.requestAuthorization(toShare: sharedObjects as? Set<HKSampleType>, read: stepsCount as? Set<HKObjectType>, completion: { (success, err) in
                self.getStepCount(sender: self)
            })
            
        } 
```
and creating a query for HealthStore to execute looks like this:
```Swift
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
```

These are some of the functionalities of Swift 3 & XCode 8 with ResearchKit and HealthKit. You can easily customize these items and save information to utilize in other parts of the iOS App to create a healthcare hack!
