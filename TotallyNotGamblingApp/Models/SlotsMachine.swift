//
//  SlotsMachine.swift
//  TotallyNotGamblingApp
//
//  Created by jjurlits on 3/23/21.
//

import Foundation

class SlotsMachineViewModel: ObservableObject {
    struct UniqueSlot: Identifiable {
        let id = UUID()
        let symbol: String
    }
    
    @Published private var machine: SlotsMachine
    var previousCreditsCount: Int
    
    var creditsDifference: Int {
        machine.credits - previousCreditsCount
    }
    
    var slots: [UniqueSlot] {
        machine.slots.compactMap { UniqueSlot(symbol: $0.symbol) }
    }
    
    var credits: String {
        "\(machine.credits)"
    }
    
    var shouldShowPayoutLabel: Bool {
        return creditsDifference > 0
    }
    
    var payout: String {
        "+\(creditsDifference + 1)🤩"
    }
    
    func spinButtonTapped() {
        previousCreditsCount = machine.credits
        machine.spin()
    }
    
    func resetButtonTapped() {
        machine.reset()
    }
    
    init(_ machine: SlotsMachine) {
        self.machine = machine
        self.previousCreditsCount = machine.credits
    }

}

struct SlotsMachine {
    private var count: Int = 0
    private(set) var credits: Int = 0
    private(set) var slots: [Slot] = []
    
    private func generateNewSlotsArray() -> [Slot] {
        Slot.randomSlots(count: self.count)
    }
    
    //sort of slots algorythm, not the real one :)
    private func calculatePayout() -> Int {
        var payout = 0
        for slot in slots {
            let count = slots.filter({ $0 == slot }).count
            if count > 1 {
                payout += slot.payout * (count - 1)
            } else { continue }
        }
        return payout
    }
    
    mutating func spin() {
        credits -= 1
        slots = generateNewSlotsArray()
        credits += calculatePayout()
    }
    
    mutating func reset() {
        setInitialValues()
    }
    
    mutating private func setInitialValues() {
        count = 3
        credits = 50
        slots = generateNewSlotsArray()
    }
    
    init() {
        setInitialValues()
    }
}


//class SlotsMachine: ObservableObject {
//    private var count: Int = 0
//    private(set) var credits: Int = 0
//
//    @Published
//    private var _slots: [Slot] = []
//
//    var slots: [String] {
//        _slots.compactMap { $0.symbol }
//    }
//
//    private func generateNewSlotsArray() -> [Slot] {
//        Slot.randomSlots(count: self.count)
//    }
//
//    //sort of slots algorythm, not the real one :)
//    private func calculatePayout() -> Int {
//        var payout = 0
//        for slot in _slots {
//            let count = _slots.filter({ $0 == slot }).count
//            if count > 1 {
//                payout += slot.payout * count
//            } else { continue }
//        }
//        return payout
//    }
//
//    func spin() {
//        credits -= 1
//        _slots = generateNewSlotsArray()
//        credits += calculatePayout()
//    }
//
//    func reset() {
//        setInitialValues()
//    }
//
//    private func setInitialValues() {
//        count = 3
//        credits = 50
//        _slots = generateNewSlotsArray()
//    }
//
//    init() {
//        setInitialValues()
//    }
//}
