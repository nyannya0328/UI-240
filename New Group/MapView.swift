//
//  MapView.swift
//  UI-240
//
//  Created by にゃんにゃん丸 on 2021/06/18.
//

import SwiftUI
import MapKit

struct MapView: UIViewRepresentable {
    func makeCoordinator() -> Coordinator {
        return MapView.Coordinator()
    }
    
    
    @EnvironmentObject var model : MapViewModel
    
    func makeUIView(context: Context) -> MKMapView {
        
        let view = model.mapView
        view.showsUserLocation = true
        view.delegate = context.coordinator
        return view
        
        
        
        
    }
    
    func updateUIView(_ uiView: MKMapView, context: Context) {
        
    }
    
    class Coordinator : NSObject,MKMapViewDelegate{
        
        
        func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
            
            if annotation.isKind(of: MKUserLocation.self) {return nil}
            
            else{
                
                let pinAnotation = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "PIN_USER")
                
                pinAnotation.animatesDrop = true
                pinAnotation.tintColor = .green
                pinAnotation.canShowCallout = true
                
                return pinAnotation
                
            }
            
        }
        
        
    }

}


