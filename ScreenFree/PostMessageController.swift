//
//  PostNote.swift
//  ScreenFree
//
//  Created by Patrick Stewart on 6/5/19.
//  Copyright © 2019 TrickStewart. All rights reserved.
//

import Foundation
import UIKit
import AWSAppSync
import AWSCore
import AWSDynamoDB
import AWSCognitoIdentityProvider

class PostMessageController: UIViewController{
    
    var response: AWSCognitoIdentityUserGetDetailsResponse?
    var user: AWSCognitoIdentityUser?
    var pool: AWSCognitoIdentityUserPool?
    
    @IBOutlet weak var noteIdInput: UITextField!
    @IBOutlet weak var messagetitleInput: UITextField!
    @IBOutlet weak var contentInput: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.pool = AWSCognitoIdentityUserPool(forKey: AWSCognitoUserPoolsSignInProviderKey)
        if (self.user == nil) {
            self.user = self.pool?.currentUser()
        }
        self.refresh()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setToolbarHidden(false, animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setToolbarHidden(true, animated: true)
    }
    
    

    
    @IBAction func addNewMessage(_ sender: Any) {
        
        let dynamoDBObjectMapper = AWSDynamoDBObjectMapper.default()
        let sendNotes: Notes = Notes()
        
        sendNotes.userId = self.user?.deviceId
        
        sendNotes.noteId = "note1"
        sendNotes.title = "myNote"
        sendNotes.content = "hellonew"
        sendNotes.creationDate = "date"
        
        //Save a new item
        dynamoDBObjectMapper.save(sendNotes, completionHandler: {
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
