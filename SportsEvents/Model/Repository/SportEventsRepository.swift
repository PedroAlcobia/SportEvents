//
//  SportEventsRepository.swift
//  SportsEvents
//
//  Created by Pedro Alcobia on 18/01/2022.
//

import Foundation

struct SportEventsRepository {
    private let fetchSportsEvents: FetchSportsEventsService
    
    init() {
        do {
            self.fetchSportsEvents = try FetchSportsEventsService()
        } catch {
            fatalError("Error creating Repository: \(error)")
        }
    }
    
    func getSportsEvents(callback: @escaping ([SportModel]) -> Void) {
        self.fetchSportsEvents.execute { Result in
            switch Result {
            case .success(let value):
                callback(value.map(SportModel.init))
            case .failure(let error):
                callback([])
            }
        }
    }
}
