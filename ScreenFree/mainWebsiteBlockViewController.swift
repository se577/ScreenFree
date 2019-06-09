//
//  mainWebsiteBlockViewController.swift
//  ScreenFree
//
//  Created by Patrick Stewart on 6/8/19.
//  Copyright © 2019 TrickStewart. All rights reserved.
//

import Foundation
import UIKit
import AWSAppSync
import AWSCore
import AWSDynamoDB
import AWSCognitoIdentityProvider
import SafariServices

class mainWebsiteBlockViewController: UIViewController, WebsiteDelegate
{
    func sendWebsiteData(type: String) {
        <#code#>
    }
    
    
    var facebookEnable: Bool?
    var instaEnable: Bool?
    var tumblrEnable: Bool?
    var twitterEnable: Bool?
    
    var response: AWSCognitoIdentityUserGetDetailsResponse?
    var user: AWSCognitoIdentityUser?
    var pool: AWSCognitoIdentityUserPool?
    
    @IBOutlet var facebookSwitch: UISwitch!
    @IBOutlet var instaSwitch: UISwitch!
    @IBOutlet var tumblrSwitch: UISwitch!
    @IBOutlet var twitterSwitch: UISwitch!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.facebookEnable = true
        self.instaEnable = true
        self.tumblrEnable = true
        self.twitterEnable = true
        
        self.pool = AWSCognitoIdentityUserPool(forKey: AWSCognitoUserPoolsSignInProviderKey)
        if (self.user == nil) {
            self.user = self.pool?.currentUser()
        }
        self.refresh()
        
    }

    
    @IBAction func facebookSwitchChanged(_ sender: UISwitch) {
        if (self.facebookEnable == true){
            self.facebookEnable = false
        }
        else {
            self.facebookEnable = true
        }
    }
    
    @IBAction func instaSwitchChanged(_ sender: UISwitch) {
        if (self.instaEnable == true){
            self.instaEnable = false
        }
        else {
            self.instaEnable = true
        }
    }
 
    @IBAction func tumblrSwitchChanged(_ sender: UISwitch) {
        if (self.tumblrEnable == true){
            self.tumblrEnable = false
        }
        else {
            self.tumblrEnable = true
        }
    }
    
    @IBAction func twitterSwitchChanged(_ sender: UISwitch) {
        if (self.twitterEnable == true){
            self.twitterEnable = false
        }
        else {
            self.twitterEnable = true
        }
    }
    
    
@IBAction func submitCurrentWebsites(_ sender: AnyObject) {
    let dynamoDBObjectMapper = AWSDynamoDBObjectMapper.default()
    let addWebsite: UserWebsitesBlocked = UserWebsitesBlocked()
    
    addWebsite._userId = self.user?.deviceId
    addWebsite._facebookBlockedWebsite = self.facebookEnable! ? "facebook.com" : "null";
    addWebsite._instaBlockedWebsite = self.instaEnable! ? "insagram.com" : "null";
    addWebsite._tumblrBlockedWebsite = self.tumblrEnable! ? "tumblr.com" : "null";
    addWebsite._twitterBlockedWebsite = self.twitterEnable! ? "twitter.com" : "null";
    addWebsite._blocked = false
    
    //Save a new item
    dynamoDBObjectMapper.save(addWebsite, completionHandler: {
        (error: Error?) -> Void in
        
        if let error = error {
            print("Amazon DynamoDB Save Error: \(error)")
            return
        }
        print("An item was saved.")
    })
    
    }
    
    func refresh() {
        self.user?.getDetails().continueOnSuccessWith { (task) -> AnyObject? in
            DispatchQueue.main.async(execute: {
                self.response = task.result
            })
            return nil
        }
    }


}
