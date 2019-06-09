//
//  WebsiteDelegate.swift
//  ScreenFree
//
//  Created by Patrick Stewart on 6/9/19.
//  Copyright © 2019 TrickStewart. All rights reserved.
//

import Foundation

// Note: this protocol is used in "Passing Data Back With Delegation"
protocol WebsiteDelegate
{
    func sendWebsiteData(type: String)
}
