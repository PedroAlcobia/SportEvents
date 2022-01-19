//
//  EventNetworkModel.swift
//  SportsEvents
//
//  Created by Pedro Alcobia on 18/01/2022.
//

struct EventNetworkModel: Codable {
    /// event id
    let i: String
    /// sport id
    let si: String
    /// event name
    let d: String
    /// event timestamp (unix)
    let tt: Double
}
