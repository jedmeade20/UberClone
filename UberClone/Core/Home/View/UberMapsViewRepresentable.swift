//
//  UberMapsViewRepresentable.swift
//  UberClone
//
//  Created by Johanan Edmeade on 1/6/24.
//

import SwiftUI
import MapKit

//Creates Wrapped view to work with SwiftUi view
struct UberMapsViewRepresentable: UIViewRepresentable{
    
    
    //new instance of map
    let mapView = MKMapView()
    //gets user location
    let locationManager = LocationManager()
    //ties enum that changes map state
    @Binding var mapState: MapViewState
    //one instance to rule them all
    @EnvironmentObject var locationViewModel: LocationSearchViewModel
    
    
    //make UI view
    
    func makeUIView(context: Context) -> some UIView {
        mapView.delegate = context.coordinator
        mapView.isRotateEnabled = false
        mapView.showsUserLocation = true
        mapView.userTrackingMode = .follow
        
        return mapView
    }
    //Updates view
    func updateUIView(_ uiView: UIViewType, context: Context) {
        print("DEBUG: Map state view is \(mapState)")
//        if let coordinate = locationViewModel.selectedLocationCoordinate{
//            context.coordinator.addAndSelectAnnotation(withCoordinate: coordinate)
//            context.coordinator.configPolyLine(with: coordinate)
//            //            print("Selected location on map view is \(coordinate)")
//        }
//        //clears maps and recenters
//        if mapState == .noInput{
//            context.coordinator.clearPolyLinesAndResetMapLocation()
//        }
        //only uses the applicable state vs running multiple ones
        switch mapState {
        case .noInput:
            context.coordinator.clearPolyLinesAndResetMapLocation()
            break
        case .searchingForLocation:
            break
        case .locationSelected:
            if let coordinate = locationViewModel.selectedLocation?.coordinates{
                context.coordinator.addAndSelectAnnotation(withCoordinate: coordinate)
                context.coordinator.configPolyLine(with: coordinate)
                //            print("Selected location on map view is \(coordinate)")
            }
            break
        case .polyLineAdded:
            break
        }
    }
    //Pushes changes across application
    func makeCoordinator() -> MapCoordinator {
        return MapCoordinator(parent: self)
    }
}

//adds addidtional features to mapview
extension UberMapsViewRepresentable{
    
    class MapCoordinator: NSObject, MKMapViewDelegate{
        
        let parent: UberMapsViewRepresentable
        var userLocation: CLLocationCoordinate2D?
        var currentRegion : MKCoordinateRegion?
        
        init(parent: UberMapsViewRepresentable) {
            self.parent = parent
            super.init()
        }
        func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
            self.userLocation = userLocation.coordinate
            //defines region for mapview
            let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: userLocation.coordinate.latitude, longitude: userLocation.coordinate.longitude),
                                            span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05))
            self.currentRegion = region
            
            parent.mapView.setRegion(region, animated: true)
            
        }
        //creates polyline for map
        func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
            let polyline = MKPolylineRenderer(overlay: overlay)
            polyline.strokeColor = .systemBlue
            polyline.lineWidth = 6
            return polyline
        }
        //adds marker to map?
        func addAndSelectAnnotation(withCoordinate coordinate: CLLocationCoordinate2D){
            parent.mapView.removeAnnotations(parent.mapView.annotations)
            let anno = MKPointAnnotation()
            anno.coordinate = coordinate
            self.parent.mapView.addAnnotation(anno)
            self.parent.mapView.selectAnnotation(anno, animated: true)
            
//            parent.mapView.showAnnotations(parent.mapView.annotations, animated: true)
        }
        //adds polyline to map
        func configPolyLine(with destinationCoordinate: CLLocationCoordinate2D){
            
            guard let userLocationCoordintates = self.userLocation else {return}
            //gets func from viewModel
            parent.locationViewModel.getDestinationRoute(from: userLocationCoordintates, to: destinationCoordinate) { route in
//                self.parent.mapView.removeOverlay(route.polyline)
                self.parent.mapView.addOverlay(route.polyline)
                self.parent.mapState = .polyLineAdded
                let rect = self.parent.mapView.mapRectThatFits(route.polyline.boundingMapRect, edgePadding: .init(top: 64, left: 32, bottom: 500, right: 32))
                self.parent.mapView.setRegion(MKCoordinateRegion(rect), animated: true)
                
            }
        }
        //gets user location and destination, makes request to find routes and returns the fastest one 
        
        func clearPolyLinesAndResetMapLocation(){
            parent.mapView.removeAnnotations(parent.mapView.annotations)
            parent.mapView.removeOverlays(parent.mapView.overlays)
            
            if let currentRegion = currentRegion{
                parent.mapView.setRegion(currentRegion, animated: true)
            }
        }
    }
}

