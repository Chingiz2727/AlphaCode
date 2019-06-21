//
//  MainTGisViewController.swift
//  YandexTaxiPlus
//
//  Created by Shyngys Kuandyk on 5/9/19.
//  Copyright © 2019 Чингиз. All rights reserved.
//

import UIKit
import MapKit
//import SideMenu


//let url = "http://185.236.130.126/profile/uploads/\(avatar)"

class MainTGisViewController: UIViewController {
    var type : String?
    var mainview : MainTGisView  {return self.view as! MainTGisView}
    var first_place : Place_Module?
    var second_place : Place_Module?
    var placing :  addPlace?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isTranslucent = false
        mainview.FromButton.addTarget(self, action: #selector(go), for: .touchUpInside)
        mainview.toButton.addTarget(self, action: #selector(go), for: .touchUpInside)
       
        placing = addPlace(first_place: first_place, second_place: second_place,view: mainview,controller: self)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
    }
    
    @objc func go(sender:UIButton) {
        let choose = ChooseTgisTableViewController()
        switch sender.tag {
        case 0:
            choose.proto_first = placing
        default:
            choose.proto_second = placing
        }
        self.navigationController?.pushViewController(choose, animated: true)
    }
    
 
    
    
   
    
    override func loadView() {
        super.loadView()
        self.view = MainTGisView(frame: self.view.bounds)
    }
    
    
    
    
}




extension UIViewController {
    func reloadViewFromNib() {
        let parent = view.superview
        view.removeFromSuperview()
        view = nil
        parent?.addSubview(view) // This line causes the view to be reloaded
    }
}
