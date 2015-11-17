//
//  Record.swift
//  Borrowed
//
//  Created by Mitali Chandna on 2015-11-14.
//  Copyright © 2015 Mitali Chandna. All rights reserved.
//

import UIKit

class Record : NSObject, NSCoding{
    
    //MARK: Properties
    
    var borrowed: Bool
    var lent: Bool
    var itemName: String
    var contactName: String //WILL BE CHANGED TO CONTACT 
    var reminderName: String //MIGHT BECOME REMINDER OBJECT?
    var reminderNumber: Int
    
    //MARK: Archiving Paths 
    
    static let DocumentsDirectory = NSFileManager().URLsForDirectory(NSSearchPathDirectory.DocumentDirectory, inDomains: .UserDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.URLByAppendingPathComponent("records")
    
    //MARK: Types
    
    struct PropertyKey {
        static let borrowedKey = "borrowed"
        static let lentKey = "lent"
        static let itemKey = "item"
        static let contactKey = "contact"
        static let reminderKey = "reminder"
        static let reminderNumberKey = "reminderNumber"
    }
    
    //MARK: Initializions
    
    init(borrowed: Bool, lent: Bool, itemName: String, contactName: String, reminderName: String, reminderNumber: Int) {
        self.borrowed = borrowed
        self.lent = lent
        self.itemName = itemName
        self.contactName = contactName
        self.reminderName = reminderName
        self.reminderNumber = reminderNumber
        
        //All cases where initialization could fail are checked before this object is made
        super.init()
    }

    //MARK: NSCoding    
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeBool(borrowed, forKey: PropertyKey.borrowedKey)
        aCoder.encodeBool(lent, forKey: PropertyKey.lentKey)
        aCoder.encodeObject(itemName, forKey: PropertyKey.itemKey)
        aCoder.encodeObject(contactName, forKey: PropertyKey.contactKey)
        aCoder.encodeObject(reminderName, forKey: PropertyKey.reminderKey)
        aCoder.encodeInteger(reminderNumber, forKey: PropertyKey.reminderNumberKey)
    }
    
    required convenience init(coder aDecoder: NSCoder) {
        
        let borrowedObject = aDecoder.decodeBoolForKey(PropertyKey.borrowedKey)
        let lentObject = aDecoder.decodeBoolForKey(PropertyKey.lentKey)
        let itemObject = aDecoder.decodeObjectForKey(PropertyKey.itemKey) as! String
        let contactObject = aDecoder.decodeObjectForKey(PropertyKey.contactKey) as! String
        let reminderNameObject = aDecoder.decodeObjectForKey(PropertyKey.reminderKey) as! String
        let reminderNumberObject = aDecoder.decodeIntegerForKey(PropertyKey.reminderNumberKey)
        
        
        self.init(borrowed: borrowedObject, lent: lentObject, itemName: itemObject, contactName: contactObject, reminderName: reminderNameObject, reminderNumber: reminderNumberObject)
    }
}
