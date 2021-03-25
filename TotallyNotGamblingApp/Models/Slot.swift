//
//  Slot.swift
//  TotallyNotGamblingApp
//
//  Created by jjurlits on 3/23/21.
//

import Foundation

struct Slot: Equatable {
    let id: Int
    let symbol: String
    let payout: Int
    
    static var allValues = [
        Slot(id: 0, symbol: "🍒", payout: 5), Slot(id: 1, symbol: "🍋", payout: 7),
        Slot(id: 2, symbol: "🍊", payout: 10), Slot(id: 3, symbol: "🌸", payout: 14),
        Slot(id: 4, symbol: "🔔", payout: 20), Slot(id: 5, symbol: "🚀", payout: 35),
    ]
    
    static func randomSlots(count: Int) -> [Slot] {
        (1...count).compactMap {
            _ in Self.allValues.randomElement()
        }
    }
}
