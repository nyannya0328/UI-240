//
//  MapViewModel.swift
//  UI-240
//
//  Created by にゃんにゃん丸 on 2021/06/18.
//

import SwiftUI
import MapKit
import CoreLocation

class MapViewModel: NSObject,ObservableObject,CLLocationManagerDelegate{
    
    
    @Published var mapView = MKMapView()
    
    @Published var region : MKCoordinateRegion!
    
    @Published var showAlert = false
    @Published var MSG = ""
    
    @Published var places : [Place] = []
    @Published var mapTipe : MKMapType = .standard
    
    @Published var searchTxt = ""
    
    
    func selectPlace(place : Place){
        
        searchTxt = ""
        
        guard let coordinate = place.placemark.location?.coordinate else {return}
        
        
        let pointAnotation = MKPointAnnotation()
        
        pointAnotation.coordinate = coordinate
        
        pointAnotation.title = place.placemark.name ?? ""
        
        mapView.removeAnnotations(mapView.annotations)
        
        mapView.addAnnotation(pointAnotation)
        
        let coordinateRegion = MKCoordinateRegion(center: coordinate, latitudinalMeters: 10000, longitudinalMeters: 100000)
        
        mapView.setRegion(coordinateRegion, animated: true)
        
        mapView.setVisibleMapRect(mapView.visibleMapRect, animated: true)
        
        
    }
    
    
    func searchQuery(){
        
        places.removeAll()
        
        
        let request = MKLocalSearch.Request()
        
        request.naturalLanguageQuery = searchTxt
        
        MKLocalSearch(request: request).start { responce, _ in
            
            
            guard let result = responce else {return}
            
            self.places = result.mapItems.compactMap({(item) -> Place in
                
            
                return Place(placemark: item.placemark)
                
            })
            
            
        }
        
        
    }
    
    func updateMapType(){
        
        if mapTipe == .standard{
            
            mapTipe = .hybrid
            mapView.mapType = mapTipe
            
        }
        
        else if mapTipe == .hybrid{
            
            mapTipe = .satellite
            mapView.mapType = mapTipe
            
        }
        else{
            
            mapTipe = .standard
            mapView.mapType = mapTipe
            
        }
        
    }
    
    
    func foucingRegion(){
        
        
        
        guard let _ = region else{return}
        
        
        mapView.setRegion(region, animated: true)
        mapView.setVisibleMapRect(mapView.visibleMapRect, animated: true)
        
    }
    
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        
        switch manager.authorizationStatus{
        
        
        case .denied : showAlert.toggle()
        case.notDetermined : manager.requestWhenInUseAuthorization()
        case.authorizedWhenInUse : manager.requestLocation()
            
        default : ()
        
        
        }
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        guard let location = locations.last else {return}
        
        self.region = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: 10000, longitudinalMeters: 10000)
        
        
        self.mapView.setRegion(region, animated: true)
        
        self.mapView.setVisibleMapRect(self.mapView.visibleMapRect, animated: true)
        
        
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        
        print(error.localizedDescription)
        
        
    }
}

