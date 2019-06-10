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

class mainWebsiteBlockViewController: UIViewController
{

    let dynamoDBObjectMapper = AWSDynamoDBObjectMapper.default()
    let addWebsite: UserWebsitesBlocked = UserWebsitesBlocked()
    
    var facebookEnable: Bool?
    var instaEnable: Bool?
    var tumblrEnable: Bool?
    var twitterEnable: Bool?
    var blockEnable: Bool?
    
    var response: AWSCognitoIdentityUserGetDetailsResponse?
    var user: AWSCognitoIdentityUser?
    var pool: AWSCognitoIdentityUserPool?
    
    @IBOutlet var facebookSwitch: UISwitch!
    @IBOutlet var instaSwitch: UISwitch!
    @IBOutlet var tumblrSwitch: UISwitch!
    @IBOutlet var twitterSwitch: UISwitch!
    @IBOutlet var blockSwitch: UISwitch!
    
    @IBOutlet weak var customWebsite: UITextField!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.facebookEnable = true
        self.instaEnable = true
        self.tumblrEnable = true
        self.twitterEnable = true
        self.blockEnable = true
        
        self.pool = AWSCognitoIdentityUserPool(forKey: AWSCognitoUserPoolsSignInProviderKey)
        if (self.user == nil) {
            self.user = self.pool?.currentUser()
        }
        self.refresh()
        
        self.title = self.user?.username
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setToolbarHidden(true, animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setToolbarHidden(false, animated: true)
    }
    
    @IBAction func blockSwitchChanged(_ sender: UISwitch) {
        if (self.blockEnable == true){
            
            let date = Date()
            let format = DateFormatter()
            format.dateFormat = "yyyy-MM-dd HH:mm:ss"
            let formattedDate = format.string(from: date)
            
            addWebsite._blockStartDate = formattedDate
            addWebsite._userId = self.user?.username
            addWebsite._customBlockedWebsite = customWebsite.text!
            addWebsite._facebookBlockedWebsite = self.facebookEnable! ? "facebook.com" : "null";
            addWebsite._instaBlockedWebsite = self.instaEnable! ? "instagram.com" : "null";
            addWebsite._tumblrBlockedWebsite = self.tumblrEnable! ? "tumblr.com" : "null";
            addWebsite._twitterBlockedWebsite = self.twitterEnable! ? "twitter.com" : "null";
            
            addWebsite._blocked = true
            
            //Save a new item
            dynamoDBObjectMapper.save(addWebsite, completionHandler: {
                (error: Error?) -> Void in
                
                if let error = error {
                    print("Amazon DynamoDB Save Error: \(error)")
                    return
                }
                print("An item was saved.")
            })
           self.blockEnable = false
        }
        else {
            self.blockEnable = true
            
            let date = Date()
            let format = DateFormatter()
            format.dateFormat = "yyyy-MM-dd HH:mm:ss"
            let formattedDate = format.string(from: date)
            
            addWebsite._blockStopDate = formattedDate
            addWebsite._blocked = false
            dynamoDBObjectMapper.save(addWebsite, completionHandler: {
                (error: Error?) -> Void in
                
                if let error = error {
                    print("Amazon DynamoDB Save Error: \(error)")
                    return
                }
                print("An item was saved.")
            })
        }
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
    
    
    func submitCurrentWebsites() {
    
    addWebsite._userId = self.user?.deviceId
    addWebsite._facebookBlockedWebsite = self.facebookEnable! ? "facebook.com" : "null";
    addWebsite._instaBlockedWebsite = self.instaEnable! ? "instagram.com" : "null";
    addWebsite._tumblrBlockedWebsite = self.tumblrEnable! ? "tumblr.com" : "null";
    addWebsite._twitterBlockedWebsite = self.twitterEnable! ? "twitter.com" : "null";
    addWebsite._customBlockedWebsite? = customWebsite.text!
    addWebsite._blocked = true
    
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
    
    @IBAction func signOut(_ sender: AnyObject) {
        self.user?.signOut()
        self.title = nil
        self.response = nil
        self.refresh()
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
