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
    
    @IBOutlet weak var noteIdInput: UITextField!
    @IBOutlet weak var messagetitleInput: UITextField!
    @IBOutlet weak var contentInput: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
        
        sendNotes.userId = "us-east-1_38156831-c111-4f45-9138-066a59c92b19"
        
        sendNotes.noteId = "note1"
        sendNotes.title = "myNote"
        sendNotes.content = "hello"
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
}
