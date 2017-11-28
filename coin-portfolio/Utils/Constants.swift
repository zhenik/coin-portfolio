//
//  Constants.swift
//  coin-portfolio
//
//  Created by Nikita on 28/11/2017.
//  Copyright © 2017 Nikita. All rights reserved.
//

import Foundation

// Custom closjure to handle async requests
typealias CompletionHandler = (_ Success: Bool) -> ()

// API URLS
let BASE_URL = "https://api.coinmarketcap.com/v1/ticker/?convert=NOK&limit=10"

