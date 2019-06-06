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

class LogoutViewController: UIViewController{
    
    @IBOutlet weak var noteIdInput: UITextField!
    @IBOutlet weak var messagetitleInput: UITextField!
    @IBOutlet weak var contentInput: UITextField!
    
    
    @IBAction func addNewMessage(_ sender: Any) {
        
        let credentialsProvider = AWSCognitoCredentialsProvider(regionType: .USEast1, identityPoolId: CognitoIdentityUserPoolId)
        let configuration = AWSServiceConfiguration(region: .USEast1, credentialsProvider: credentialsProvider)
        AWSServiceManager.default().defaultServiceConfiguration = configuration
        
        let dynamoDbObjectMapper = AWSDynamoDBObjectMapper.default()
        
        let notesItem: MyNotes = MyNotes()
        
        notesItem._userId = credentialsProvider.identityId
        
        notesItem._noteId = self.noteIdInput.text
        notesItem._title = self.messagetitleInput.text
        notesItem._content = self.contentInput.text
        
        //Save a new item
        dynamoDbObjectMapper.save(notesItem, completionHandler: {
            (error: Error?) -> Void in
            
            if let error = error {
                print("Amazon DynamoDB Save Error: \(error)")
                return
            }
            print("An item was saved.")
        })
    }
    
}
