//
//  PortfolioItemVC.swift
//  coin-portfolio
//
//  Created by Nikita on 04/12/2017.
//  Copyright © 2017 Nikita. All rights reserved.
//

import UIKit

class PortfolioItemVC: UIViewController {
    
    // Vars
    var previousVC = PortfolioVC()
    var selectedItem : PortfolioItem?
    // Outlets
    @IBOutlet weak var cardViewItem: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initCardDesign()
    }
    
    /*
     ******************************* navbar view START **********************************
     **/
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    /*
     ******************************* navbar view END **********************************
     **/
    
    
    
    /*
     ******************************* card view START **********************************
     **/
    func initCardDesign(){
        cardViewItem.layer.cornerRadius = 3
        cardViewItem.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        cardViewItem.layer.shadowOffset = CGSize(width: 0, height: 1.75)
        cardViewItem.layer.shadowRadius = 1.7
        cardViewItem.layer.shadowOpacity = 0.45
    }
    
    /*
     ******************************* card view END **********************************
     **/
    
}
