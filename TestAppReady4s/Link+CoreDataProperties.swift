//
//  Link+CoreDataProperties.swift
//  TestAppReady4s
//
//  Created by Anna-Maria Shkarlinska on 25/04/16.
//  Copyright © 2016 Anna-Maria Shkarlinska. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Link {

    @NSManaged var shortURL: String?
    @NSManaged var longURL: String?

}
