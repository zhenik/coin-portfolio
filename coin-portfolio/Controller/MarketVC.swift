//
//  MarketVC.swift
//  coin-portfolio
//
//  Created by Nikita on 28/11/2017.
//  Copyright © 2017 Nikita. All rights reserved.
//

import UIKit

class MarketVC: UIViewController {

    
    @IBOutlet weak var menuBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        initSlideReveal()
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        
    }
    
    func initSlideReveal(){
        menuBtn.addTarget(self.revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)), for: .touchUpInside)
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        self.view.addGestureRecognizer(self.revealViewController().tapGestureRecognizer())
    }


}
