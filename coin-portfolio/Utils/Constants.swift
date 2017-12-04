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
let BASE_API_URL = "https://api.coinmarketcap.com/v1/ticker/?convert=NOK&limit=10"
let IMG_API_URL = "https://files.coinmarketcap.com/static/img/coins/32x32/"


// SEGUES
let TO_MARKET_ITEM = "toMarketItem"
let TO_PORTFOLIO_ITEM = "toPortfolioItem"

