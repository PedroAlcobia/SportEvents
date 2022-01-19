//
//  SportModel.swift
//  SportsEvents
//
//  Created by Pedro Alcobia on 18/01/2022.
//

struct SportModel {
    let sportId: String
    let sportName: String
    let eventList: [EventModel]
    
    init(from: SportNetworkModel) {
        self.sportId = from.i
        self.sportName = from.d
        self.eventList = from.e.map(EventModel.init)
    }
}
