# hackpack-researchkit

This iOS hackpack uses Swift 3, ResearchKit 1.4 to request consent from users & distribute survey, as well as HealthKit to access data from the Health App.

To begin, first git clone [https://github.com/ResearchKit/ResearchKit](https://github.com/ResearchKit/ResearchKit), run the Xcode project then drag the ResearchKit project to your own Xcode project.

Then, in Capabilities turn on HealthKit access.

In your info.plist, right click to open as source code, then paste in:
```swift
    <key>NSHealthShareUsageDescription</key>
    <string>Need to share healthkit information</string>
    <key>NSHealthUpdateUsageDescription</key>
    <string>Need healthkit to track steps</string>
```

These install ResearchKit and HealthKit for your Xcode project.

**Main.storyboard** creates navigation controller, buttons to link to functions, and a separate view controller for HealthKit data.

**FirstViewController.swift** links buttons to its functions.

**ConsentDocument.swift** and **ConsentTasks.swift** asks for user consent to research study.

**SurveyTask.swift** creates a simple survey form for users.

**HealthKitViewController.swift** asks for HealthKit access and gets steps count.
