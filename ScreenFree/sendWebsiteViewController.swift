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
    
    @IBOutlet weak var submitWebsite: UITextField!
    
    var response: AWSCognitoIdentityUserGetDetailsResponse?
    var user: AWSCognitoIdentityUser?
    var pool: AWSCognitoIdentityUserPool?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.pool = AWSCognitoIdentityUserPool(forKey: AWSCognitoUserPoolsSignInProviderKey)
        if (self.user == nil) {
            self.user = self.pool?.currentUser()
        }
        self.refresh()
        
    }
    
    @IBAction func sendWebsite(_ sender: AnyObject) {
        
        let dynamoDBObjectMapper = AWSDynamoDBObjectMapper.default()
        let addWebsite: UserWebsitesBlocked = UserWebsitesBlocked()
        
        addWebsite._userId = self.user?.deviceId
        addWebsite._blockedWebsite = "facebook"
        
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
