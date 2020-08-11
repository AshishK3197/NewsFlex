//
//  HamburgerMenuViewController.swift
//  NewsFeed
//
//  Created by Ashish Kumar on 09/08/20.
//  Copyright © 2020 Ashish Kumar. All rights reserved.
//

import UIKit

enum MenuType: Int{
    case about
    case feedback
    case contactUs
}

class HamburgerMenuViewController: UITableViewController {  
    var didTapMenuType: ((MenuType) -> Void)?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let menuType = MenuType(rawValue: indexPath.row) else {return}
        dismiss(animated: true){ [weak self] in
            print("dismissed")
            self?.didTapMenuType?(menuType)
        }
    }
    
    
}
