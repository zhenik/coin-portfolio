//
//  MarketItemVC.swift
//  coin-portfolio
//
//  Created by Nikita on 29/11/2017.
//  Copyright © 2017 Nikita. All rights reserved.
//

import UIKit

class MarketItemVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
}
