//
//  sendWebsiteViewController.swift
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


class sendWebsiteViewController: UIViewController{
    
    /// The text property for "Passing data forward with properties"
    var text:String = ""
    
    /// The view controller property for "Passing data back with properties"
    var mainWebsiteBlockViewController:mainWebsiteBlockViewController?
    
    /// The delegate property for "Passing data back with delegation"
    var delegate:WebsiteDelegate?
    
    /// Closure property for "Passing Data Back With A Closure"
    var completionHandler:((String) -> Int)?
    
    
    @IBOutlet weak var submitWebsite: UITextField!
    
    var response: AWSCognitoIdentityUserGetDetailsResponse?
    var user: AWSCognitoIdentityUser?
    var pool: AWSCognitoIdentityUserPool?
    let dynamoDBObjectMapper = AWSDynamoDBObjectMapper.default()
    let addWebsite: UserWebsitesBlocked = UserWebsitesBlocked()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.pool = AWSCognitoIdentityUserPool(forKey: AWSCognitoUserPoolsSignInProviderKey)
        if (self.user == nil) {
            self.user = self.pool?.currentUser()
        }
        self.refresh()
        
    }
    
    @IBAction func sendWebsite(_ sender: AnyObject) {
        addWebsite._userId = self.user?.deviceId
        addWebsite._customBlockedWebsite? = submitWebsite.text!
        addWebsite._customBlockedWebsite = "reddit.com"
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
    
    
    func refresh() {
        self.user?.getDetails().continueOnSuccessWith { (task) -> AnyObject? in
            DispatchQueue.main.async(execute: {
                self.response = task.result
            })
            return nil
        }
    }

}
