//
//  logout.swift
//  ScreenFree
//
//  Created by Patrick Stewart on 6/2/19.
//  Copyright © 2019 TrickStewart. All rights reserved.
//

import Foundation
import AWSCognitoIdentityProvider

class LogoutViewController : UITableViewController {
    
    var user: AWSCognitoIdentityUser?
    var pool: AWSCognitoIdentityUserPool?

//override func viewDidLoad() {
    //super.viewDidLoad()
    //self.pool = AWSCognitoIdentityUserPool(forKey: AWSCognitoUserPoolsSignInProviderKey)
//    if (self.user == nil) {
//        self.user = self.pool?.currentUser()
//    }

 //}

    override func viewDidLoad() {
        super.viewDidLoad()
        self.pool = AWSCognitoIdentityUserPool.init(forKey: AWSCognitoUserPoolsSignInProviderKey)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }



@IBAction func signOut(_ sender: AnyObject) {
    self.user?.signOut()
    
 }
}
