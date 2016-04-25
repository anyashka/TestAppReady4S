//
//  Link.swift
//  TestAppReady4s
//
//  Created by Anna-Maria Shkarlinska on 25/04/16.
//  Copyright © 2016 Anna-Maria Shkarlinska. All rights reserved.
//

import Foundation
import CoreData


class Link: NSManagedObject {

// Insert code here to add functionality to your managed object subclass
    func configure(shortURL: String, longURL: String) {
        self.shortURL = shortURL
        self.longURL = longURL
    }


}
