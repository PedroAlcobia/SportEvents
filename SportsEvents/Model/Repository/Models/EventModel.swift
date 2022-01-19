//
//  EventModel.swift
//  SportsEvents
//
//  Created by Pedro Alcobia on 18/01/2022.
//

import Foundation

class EventModel: Comparable {
    let eventId: String
    let sportId: String
    let eventName: String
    let eventDate: Date
    
    private var favourite: Bool = false
    
    init(from: EventNetworkModel) {
        self.eventId = from.i
        self.sportId = from.si
        self.eventName = from.d
        self.eventDate = Date(timeIntervalSince1970: from.tt)
    }
    
    func toggleFavourite() {
        self.favourite = !self.favourite
    }
    
    func isFavourite() -> Bool {
        return self.favourite
    }
    
    func getDateDiferenceTopresent() -> String {
        let distance = Date(timeIntervalSince1970: self.eventDate.timeIntervalSince1970 - Date().timeIntervalSince1970)
        return distance.dateFormated(format: Date.daysPendingFormat)
    }
    
    static func == (lhs: EventModel, rhs: EventModel) -> Bool {
        return lhs.eventId == rhs.eventId
    }
    
    static func < (lhs: EventModel, rhs: EventModel) -> Bool {
        return rhs.favourite ? false : lhs.favourite
    }
}
