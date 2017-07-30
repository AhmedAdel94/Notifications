//
//  ViewController.swift
//  Notifications
//
//  Created by Ahmed Adel on 7/27/17.
//  Copyright © 2017 Ahmed Adel. All rights reserved.
//

import UIKit
import UserNotifications

class ViewController: UIViewController,UNUserNotificationCenterDelegate {
    
    @IBOutlet var label: UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge], completionHandler: {didAllow, error in
            // Used to ask the user to allow the application to display notifications
        })
        
        UNUserNotificationCenter.current().delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func action(_ sender: UIButton) {
        
        
        // add a set of options for the user to choose from
        
        let answer1 = UNNotificationAction(identifier: "Answer1", title: "365", options: UNNotificationActionOptions.foreground)
        let answer2 = UNNotificationAction(identifier: "Answer2", title: "356", options: UNNotificationActionOptions.foreground)
        
        let category = UNNotificationCategory(identifier: "MyCategory", actions: [answer1,answer2], intentIdentifiers: [], options: [])
        UNUserNotificationCenter.current().setNotificationCategories([category])
        
        // -------------------
        
        // Set up the notification contents
        
        let content = UNMutableNotificationContent()
        content.title = "How many days are there in one year?"
        content.subtitle = "Do you know?"
        content.body = "Choose the correct answer"
        content.categoryIdentifier = "MyCategory"
        content.badge = 1 // To display the icon of the app in the notification
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false) // create the trigger to show the notifications
        
        let request = UNNotificationRequest(identifier: "timerDone", content: content, trigger: trigger) // Set up the notification request
        
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil) // add the notification to the notification center
        
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        if response.actionIdentifier == "Answer1"
        {
            print("Correct")
            label.text = "You are a genius"
        }
        else
        {
            print("false")
            label.text = "Have you ever went to school?"
        }
        completionHandler()
    }

}

