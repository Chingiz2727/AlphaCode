//
//  MainTGisView.swift
//  YandexTaxiPlus
//
//  Created by Shyngys Kuandyk on 5/9/19.
//  Copyright © 2019 Чингиз. All rights reserved.
//

import UIKit
import SnapKit
import MapKit

class MainTGisView: UIView,MKMapViewDelegate,CLLocationManagerDelegate {
    
    let status_label : UILabel = {
        let label = UILabel()
        label.text = "Заявка принята ожидайте водителя"
        label.font = UIFont(name: "Arial", size: 30)
        label.textColor = .black
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    let cancel_button : UIButton = {
        let button = UIButton()
        button.setTitle("Отменить заказ", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.contentEdgeInsets = UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 10)
        button.backgroundColor = maincolor
        return button
    }()
    
    func wait_order() {
        stackbutton.isHidden = true
        
        self.addSubview(status_label)
        self.addSubview(cancel_button)
        cancel_button.isHidden = false
        status_label.isHidden = false
        status_label.snp.makeConstraints { (cons) in
            cons.center.equalTo(self)
            cons.left.right.equalTo(self).inset(30)
        }
        
        cancel_button.snp.makeConstraints { (cons) in
            cons.top.equalTo(self).inset(20)
            cons.right.equalTo(self).inset(20)
        }
    }
    
    var from_text : String = "Откуда" {
        didSet {
            FromButton.Title(title: from_text)
        }
    }
    var to_text : String = "Куда" {
        didSet {
            toButton.Title(title: to_text)
        }
    }
    
    
    var FromButton : MainButton = MainButton()
    var toButton : MainButton = MainButton()
    var HourButton : MainButton = MainButton()
    var Send : MainButton = MainButton()
    let manager = CLLocationManager()
    
    lazy var stackbutton : UIStackView = {
        let stack = UIStackView(arrangedSubviews: [FromButton,toButton,HourButton,Send])
        stack.axis = .vertical
        stack.distribution = .fillEqually
        stack.spacing = 10
        stack.isHidden = false
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    
    
    
    
    lazy var mapView: MKMapView = {
        let mapView = MKMapView()
        mapView.showsCompass = true
        mapView.showsUserLocation = true
        mapView.mapType = .standard
        
        mapView.showsPointsOfInterest = false
        mapView.showsBuildings = false
        mapView.showsTraffic = false
        return mapView
    }()
    var my_location : CLLocation?
    
    let Detect : UIButton = {
        let next = UIButton()
        next.layer.cornerRadius = 18.0
        next.layer.shadowRadius = 1.0
        next.layer.shadowColor = UIColor.black.cgColor
        next.layer.shadowOffset = CGSize(width: 1, height: 1)
        next.layer.shadowOpacity = 0.4
        next.imageView?.contentMode = .scaleAspectFit
        next.addTarget(self, action: #selector(Detection), for: .touchUpInside)
        return next
    }()
    
    @objc func Detection() {
        let span : MKCoordinateSpan = MKCoordinateSpan(latitudeDelta: 0.01 , longitudeDelta: 0.01 )
        let myloc : CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: my_location!.coordinate.latitude , longitude: my_location!.coordinate.longitude )
        let region : MKCoordinateRegion = MKCoordinateRegion(center: myloc, span: span)
        mapView.setRegion(region, animated: true)
    }
    
    private let tilesOverlay = DGSTileOverlay()
    
    func addview() {
        self.addSubview(mapView)
        mapView.delegate = self
        mapView.snp.makeConstraints { (cons) in
            cons.left.right.top.bottom.equalTo(self).inset(0)
        }
        self.mapView.insertOverlay(self.tilesOverlay, at: 0, level: .aboveLabels)
        self.mapView.autoresizingMask = [ .flexibleHeight, .flexibleWidth ]
        status_label.isHidden = true
        cancel_button.isHidden = true
        FromButton.initialize()
        toButton.initialize()
        Send.initialize()
        HourButton.initialize()
        HourButton.Title(title: "По часовой тариф")
        Send.Title(title: "Заказать")
        FromButton.setColorTitle(color: maincolor)
        toButton.setColorTitle(color: maincolor)
        FromButton.Title(title: from_text)
        toButton.Title(title: to_text)
        FromButton.backgroundColor = .white
        toButton.backgroundColor = .white
        FromButton.tag = 0
        toButton.tag = 1
        self.addSubview(stackbutton)
        self.addSubview(Detect)
        Detect.snp.makeConstraints { (cons) in
            cons.right.equalTo(self).inset(10)
            cons.bottom.equalTo(FromButton.snp.top).offset(-20)
            cons.width.height.equalTo(36)
        }
        stackbutton.snp.makeConstraints { (cons) in
            cons.left.right.bottom.equalTo(self).inset(10)
            cons.height.equalTo(240)
        }
    }
    
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if !(annotation is CustomPointAnnotation) {
            return nil
        }
        
        let reuseId = "test"
        
        var anView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseId)
        if anView == nil {
            anView = MKAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
            anView?.canShowCallout = true
        }
        else {
            anView?.annotation = annotation
        }
        
        let cpa = annotation as! CustomPointAnnotation
        anView!.image = UIImage(named:cpa.pinCustomImageName)
        anView?.frame.size = CGSize(width: 30, height: 30)
        return anView
    }
    
    
    public func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        return MKTileOverlayRenderer(overlay: overlay)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addview()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
        if let loc = my_location {
            updatemyloc()
            
        }
    }
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations[0]
        self.my_location = location
        
    }
    func updatemyloc() {
        let span : MKCoordinateSpan = MKCoordinateSpan(latitudeDelta: 0.01 , longitudeDelta: 0.01 )
        let myloc : CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: my_location!.coordinate.latitude, longitude: my_location!.coordinate.longitude)
        let region : MKCoordinateRegion = MKCoordinateRegion(center: myloc, span: span)
        if let location = my_location {
            getLocationByCoord.get(lat: location.coordinate.latitude, long: location.coordinate.longitude) { (loc) in
                self.from_text = loc.result?.items?[0].name ?? "Откуда?"
            }
        }
        
        mapView.setRegion(region, animated: true)
        mapView.showsUserLocation = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

