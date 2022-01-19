//
//  SportNetworkModel.swift
//  SportsEvents
//
//  Created by Pedro Alcobia on 18/01/2022.
//

struct SportNetworkModel: Codable {
    /// sport id
    let i: String
    /// sport name
    let d: String
    /// eventList
    let e: [EventNetworkModel]
}
