//
//  ContentBlockerRequestHandler.swift
//  ContentBlocker
//
//  Created by Patrick Stewart on 6/7/19.
//  Copyright © 2019 TrickStewart. All rights reserved.
//

import UIKit
import MobileCoreServices

class ContentBlockerRequestHandler: NSObject, NSExtensionRequestHandling {
    
    func beginRequest(with context: NSExtensionContext) {
        
        let documentFolder = FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: "group.ScreenFree")
        
        guard let jsonURL = documentFolder?.appendingPathComponent(Constants.blockerListFilename) else {
            return
        }
        
        let attachment = NSItemProvider(contentsOf: Bundle.main.url(forResource: "blockerList", withExtension: "json"))!
        let item = NSExtensionItem()
        item.attachments = [attachment]
        
        context.completeRequest(returningItems: [item], completionHandler: nil)
    }
}
