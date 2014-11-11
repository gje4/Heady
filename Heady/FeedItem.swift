//
//  FeedItem.swift
//  Heady
//
//  Created by George Fitzgibbons on 11/10/14.
//  Copyright (c) 2014 Nanigans. All rights reserved.
//

import Foundation
import CoreData


@objc (FeedItem)
class FeedItem: NSManagedObject {

    @NSManaged var caption: String
    @NSManaged var image: NSData

}
