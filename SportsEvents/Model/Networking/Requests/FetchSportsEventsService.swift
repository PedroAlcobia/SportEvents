//
//  FetchSportsEventsService.swift
//  SportsEvents
//
//  Created by Pedro Alcobia on 18/01/2022.
//

import Foundation

public struct FetchSportsEventsService {
    let url: URL
    
    init() throws{
        guard let urlTest = URL(string: "https://618d3aa7fe09aa001744060a.mockapi.io/api/sports")
        else { throw NetworkingErrors.InvalidURL }
        self.url = urlTest
    }
    
    func execute(callback: @escaping (Result<[SportNetworkModel], Error>) -> Void) {
        URLSession.shared.dataTask(with: self.url) { data, response, error in
            if let error = error {
                callback(.failure(NetworkingErrors.genericError(error.localizedDescription)))
                return
            }
            
            guard let data = data
            else {
                callback(.failure(NetworkingErrors.dataWasNotReceived))
                return
            }
            
            do {
                let sportsList = try JSONDecoder().decode([SportNetworkModel].self, from: data)
                callback(.success(sportsList))
            } catch {
                callback(.failure(NetworkingErrors.decodingFailed))
            }
            
        }.resume()
    }
    
}
