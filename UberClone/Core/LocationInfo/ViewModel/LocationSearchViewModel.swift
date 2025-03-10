//
//  LocationSearchViewModel.swift
//  UberClone
//
//  Created by Johanan Edmeade on 1/7/24.
//

import Foundation
import MapKit

class LocationSearchViewModel: NSObject, ObservableObject {
    
    //completes search query when typing in
    @Published var results = [MKLocalSearchCompletion]()
    //data model for location/title
    @Published var selectedLocation: UberLocation?
    //new instance of query finisher
    var userMainLocation: CLLocationCoordinate2D?
    
    @Published var pickupTime: String?
    @Published var dropOfTime: String?
    
    
    private let searchCompletor = MKLocalSearchCompleter()
    var queryFragment: String = ""{
        didSet{
            searchCompletor.queryFragment = queryFragment
        }
    }
    //so when the page is initalized, i set the location to nil so nothing is saved from the previous query yet its still there
    override init() {
        super.init()
        searchCompletor.delegate = self
        searchCompletor.queryFragment = queryFragment
    }
    
    func selectLocation(_ localSearch: MKLocalSearchCompletion){
        locationSearch(forLocalSearchCompletion: localSearch){ response, error in
            if let error = error{
                print("DEBUG: Location search failed with error \(error.localizedDescription)")
                return
            }
//            self.selectedLocationCoordinate = nil
            //map item object
            guard let item = response?.mapItems.first else{return}
            let coordinates = item.placemark.coordinate
            self.selectedLocation = UberLocation(title: localSearch.title, coordinates: coordinates)
            
//            print("DEBUG: Coordinates for selected location \(coordinates)")
            
        }
    }
    func getDestinationRoute(from userLocation: CLLocationCoordinate2D, to destinationLocation: CLLocationCoordinate2D, completion: @escaping(MKRoute) -> Void) {
        let userPlacemark = MKPlacemark(coordinate: userLocation)
        let destPlacemark = MKPlacemark(coordinate: destinationLocation)
        let request = MKDirections.Request()
        request.source = MKMapItem(placemark: userPlacemark)
        request.destination = MKMapItem(placemark: destPlacemark)
        let directions = MKDirections(request: request)
        directions.calculate { response, error in
            if let error = error{
                print("DEBUG: Failed in getting directions, error is \(error.localizedDescription)")
                return
            }
            guard let route = response?.routes.first else {return}
            self.computePickupAndDropoffTime(with: route.expectedTravelTime)
            completion(route)
        }
    }
    func computePickupAndDropoffTime(with expectedTravelTime: Double){
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm a"
        
        pickupTime = formatter.string(from: Date())
        dropOfTime = formatter.string(from: Date() + expectedTravelTime)
    }
    //used to convert string to coordinates for map view
    func locationSearch(forLocalSearchCompletion localSearch: MKLocalSearchCompletion, completion: @escaping MKLocalSearch.CompletionHandler){
        let searchRequest = MKLocalSearch.Request()
        searchRequest.naturalLanguageQuery = localSearch.title.appending(localSearch.subtitle)
        
        let search = MKLocalSearch(request: searchRequest)
        search.start(completionHandler: completion)
    }
    
    func computeRidePrice(forType type: RideType)-> Double {
        //get destination coordinates
        guard let coordinate = self.selectedLocation?.coordinates else {return 0.0}
        //get user location, updates from home page/uberRepPage
        guard let userLocations = self.userMainLocation else {return 0.0}
        
        //get lat and long
        let destinationCoordinates = CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)
        let userCoordinates = CLLocation(latitude: userLocations.latitude, longitude: userLocations.longitude)
        //swift way of getting destination in meters
        let distanceInMeters = userCoordinates.distance(from: destinationCoordinates)
        //func from rideType model 
        return type.fairCalculator(distanceInMeters: distanceInMeters)
    }
}

extension LocationSearchViewModel: MKLocalSearchCompleterDelegate{
    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        self.results = completer.results
    }
}
