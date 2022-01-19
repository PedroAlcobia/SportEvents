//
//  NetworkingErrors.swift
//  SportsEvents
//
//  Created by Pedro Alcobia on 18/01/2022.
//

import Foundation

enum NetworkingErrors: Error {
    case InvalidURL
    case genericError(String)
    case dataWasNotReceived
    case decodingFailed
}
