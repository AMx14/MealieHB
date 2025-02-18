//
//  Item.swift
//  Mealie
//
//  Created by Akshat Maithani on 18/02/25.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
