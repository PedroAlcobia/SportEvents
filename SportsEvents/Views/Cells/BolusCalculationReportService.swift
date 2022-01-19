//
//  BolusCalculationReportService.swift
//  DFree
//
//  Created by Pedro Alcobia on 19/01/2022.
//  Copyright © 2022 Innovagency. All rights reserved.
//

import Foundation

struct BolusCalculationReportService: BasicDataService {
    let baseURL: NetworkingConstants.baseURLs = .defaultUrl
    let path: enpointableEnum = NetworkingConstants.Endpoints.Reports.bolusCalculator
    let method: String = "POST"
}
