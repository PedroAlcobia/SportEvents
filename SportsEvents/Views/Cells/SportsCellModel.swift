//
//  SportsCellModel.swift
//  SportsEvents
//
//  Created by Pedro Alcobia on 19/01/2022.
//

import Foundation

class SportsCellModel {
    let sportsModel: SportModel
    var collapsed: Bool = false {
        didSet {
            self.previousCollapsed = oldValue
        }
    }
    var previousCollapsed: Bool = false
    
    init(sportsModel: SportModel) {
        self.sportsModel = sportsModel
    }
}
