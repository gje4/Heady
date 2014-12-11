//
//  FeedItem.swift
//  Heady
//
//  Created by George Fitzgibbons on 12/10/14.
//  Copyright (c) 2014 Nanigans. All rights reserved.
//

import Foundation
import CoreData

class FeedItem: NSManagedObject {

    @NSManaged var caption: String
    @NSManaged var filtered: NSNumber
    @NSManaged var image: NSData
    @NSManaged var latitude: NSNumber
    @NSManaged var longitude: NSNumber
    @NSManaged var thumbNail: NSData
    @NSManaged var uniqueID: String
    @NSManaged var userID: String
    @NSManaged var price: String

}
