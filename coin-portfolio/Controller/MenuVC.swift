//
//  MenuVC.swift
//  coin-portfolio
//
//  Created by Nikita on 26/11/2017.
//  Copyright © 2017 Nikita. All rights reserved.
//

import UIKit

class MenuVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.revealViewController().rearViewRevealWidth = self.view.frame.size.width - 40
    }
}
