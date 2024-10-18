//
//  Item.swift
//  SkyBlue
//
//  Created by Russell Toon on 14/10/2024.
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
