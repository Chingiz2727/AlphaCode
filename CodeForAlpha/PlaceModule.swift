//
//  PlaceModule.swift
//  YandexTaxiPlus
//
//  Created by Shyngys Kuandyk on 6/3/19.
//  Copyright © 2019 Чингиз. All rights reserved.
//

import Foundation
import MapKit
struct Place_Module {
    var lat : Double?
    var long : Double?
    var name : String?
    init(lat:Double,long:Double,name:String) {
        self.lat = lat
        self.long = long
        self.name = name
    }
    
}



class addPlace : firs_place_add,second_place_add,makeOrder,make_time_order {
    func makeOrder(time: String, comment: String) {
        
    }
    
    func make_time_order(hour: Double, time: String, comment: String) {
        
    }
    
    func first_selected() {
        self.first_selection = true
        print(first_selection)
    }
    
    func second_selected() {
        self.second_selection = true
        print(second_selection)
    }
    
    
    

    
    func first_added() {
        view?.mapView.removeAnnotation(annotation_first)
        annotation_first.coordinate = CLLocationCoordinate2D(latitude: first_place?.lat ?? 0, longitude: first_place?.long ?? 0)
        view?.mapView.addAnnotation(annotation_first)
    }
    
    let annotation_second : CustomPointAnnotation = {
        let annotation = CustomPointAnnotation()
        annotation.pinCustomImageName = "icon_point_b"
        return annotation
    }()
    
    let annotation_first : CustomPointAnnotation = {
        let annotation = CustomPointAnnotation()
        annotation.pinCustomImageName = "icon_point_a"
        return annotation
    }()
    
    func second_added() {
        
        view?.mapView.removeAnnotation(annotation_second)
        annotation_second.coordinate = CLLocationCoordinate2D(latitude: second_place?.lat ?? 0, longitude: second_place?.long ?? 0)
        view?.mapView.addAnnotation(annotation_second)
    }
    
    func checkStatus() {
  
    }
    
    
    var view : MainTGisView?
    
    
    var first_place: Place_Module? {
        didSet {
            view?.FromButton.setTitle(first_place?.name ?? "Откуда?", for: .normal)
        }
    }
    
    var second_place: Place_Module? {
        didSet {
            view?.toButton.setTitle(second_place?.name ?? "Куда?", for: .normal)
        }
    }
    
    
    
    var controller : UIViewController?
    var first_selection = false
    var second_selection = false
    init (first_place:Place_Module?,second_place:Place_Module?,view:MainTGisView?,controller:UIViewController?) {
        self.first_place = first_place
        self.second_place = second_place
        self.view = view
        self.controller = controller
        checkStatus()
        
        let gesture_from = UITapGestureRecognizer(target: self, action: #selector(handleTap_from(gestureReconizer:)))
        let gesture_to = UITapGestureRecognizer(target: self, action: #selector(handleTap_to(gestureReconizer:)))
        if first_selection == true {
            view?.mapView.addGestureRecognizer(gesture_from)
        }
        if second_selection == true {
            view?.mapView.addGestureRecognizer(gesture_to)
        }
        
    }
    
    @objc func handleTap_from(gestureReconizer: UILongPressGestureRecognizer) {
        
        let location = gestureReconizer.location(in: view?.mapView)
        let coordinate = view?.mapView.convert(location,toCoordinateFrom: view?.mapView)
        first_place?.lat = coordinate?.latitude
        first_place?.long = coordinate?.longitude
        
        annotation_first.coordinate = coordinate!
        view?.mapView.addAnnotation(annotation_first)
    }
    
    @objc func handleTap_to(gestureReconizer: UILongPressGestureRecognizer) {
        
        let location = gestureReconizer.location(in: view?.mapView)
        let coordinate = view?.mapView.convert(location,toCoordinateFrom: view?.mapView)
        second_place?.lat = coordinate?.latitude
        second_place?.long = coordinate?.longitude
        // Add annotation:
        annotation_second.coordinate = coordinate!
        view?.mapView.addAnnotation(annotation_second)
    }
    
    
    func handleTap_ipoint(gestureReconizer: UILongPressGestureRecognizer) {
        
        let location = gestureReconizer.location(in: view?.mapView)
        let coordinate = view?.mapView.convert(location,toCoordinateFrom: view?.mapView)
        
        // Add annotation:
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinate!
        view?.mapView.addAnnotation(annotation)
    }
    
}


