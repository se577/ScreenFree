//
//  BlockerViewController.swift
//  ScreenFree
//
//  Created by Patrick Stewart on 6/7/19.
//  Copyright © 2019 TrickStewart. All rights reserved.
//

import UIKit
import SafariServices

class BlockerViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        SFContentBlockerManager.reloadContentBlocker(withIdentifier: "TrickStewart.ScreenFree.ContentBlocker", completionHandler: { error in
            print(error as Any)
        })
        
    }
}
