//
//  Message+CoreDataProperties.swift
//  iChat
//
//  Created by Lucas Pereira on 22/07/20.
//  Copyright © 2020 LucasChatOS. All rights reserved.
//
//

import Foundation
import CoreData


extension Message {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Message> {
        return NSFetchRequest<Message>(entityName: "Message")
    }

    @NSManaged public var date: Date?
    @NSManaged public var text: String?
    @NSManaged public var friend: Friend?

}
