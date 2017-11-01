//
//  LocationServives.swift
//  ChestNut
//
//  Created by 龚欢 on 2017/10/31.
//  Copyright © 2017年 龚欢. All rights reserved.
//

import Foundation
import CoreLocation

enum LocationServicesError: Error {
    case FailureToGetLocation
    case FailureToGetAuthorize
}

class LocationServices: NSObject {

    typealias Addresses = [String: Any]
    typealias CompletionHandler = (_ addresses: Addresses?, _ error: Error?) -> Void
    
    public static let shared = LocationServices()
    public var finishedToGetLocationHandler: CompletionHandler?
    private lazy var locationManager: CLLocationManager = {
        let manager = CLLocationManager()
        manager.distanceFilter  = 1000
        manager.desiredAccuracy = 1000
        
        return manager
    }()
    
    override init() {
        super.init()
        setupActiveNotification()
    }
    
    private func setupActiveNotification() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(LocationServices.applicationDidBecomeActive(notification:)),
                                               name: Notification.Name.UIApplicationDidBecomeActive,
                                               object: nil)
    }
    
    @objc func applicationDidBecomeActive(notification: Notification) {
        requestLocation()
    }
    
    private func requestLocation() {
        locationManager.delegate = self
        
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            locationManager.requestLocation()
        }
        else {
            locationManager.requestWhenInUseAuthorization()
        }
    }
    
    private func successToGetLocation(location: CLLocation) {
        let geoCoder = CLGeocoder()
        geoCoder.reverseGeocodeLocation(location) { (placemarks, error) in
            if let e = error {
                self.finishedToGetLocationHandler!(nil, e)
            }
            else {
                let placeArray = placemarks
                
                var placeMark: CLPlacemark!
                
                placeMark = placeArray?[0]
                
                guard let address = placeMark.addressDictionary as? Addresses else {
                    return
                }
                
                self.finishedToGetLocationHandler!(address, nil)
            }
        }
    }
    
}

extension LocationServices: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            successToGetLocation(location: location)
            manager.delegate = nil
            
            manager.stopUpdatingLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            manager.requestLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        dump(error)
    }
}






