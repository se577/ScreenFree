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

class mainWebsiteBlockViewController: UIViewController{
    
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


    
    func refresh() {
        self.user?.getDetails().continueOnSuccessWith { (task) -> AnyObject? in
            DispatchQueue.main.async(execute: {
                self.response = task.result
            })
            return nil
        }
    }
}
