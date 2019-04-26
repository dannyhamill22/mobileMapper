
import UIKit
import MapKit //importing package w/ map stuff

class ViewController: UIViewController, CLLocationManagerDelegate {
    
    @IBOutlet weak var mapView: MKMapView!
    
    let locationManager = CLLocationManager()
    
    var parks: [MKMapItem] = []
    
    var currentLocation: CLLocation!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        locationManager.requestWhenInUseAuthorization()
        mapView.showsUserLocation = true
     locationManager.delegate = self
       locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()
        
        
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    currentLocation = locations[0]
    
    
    
    
    }
    @IBAction func searchButton(_ sender: UIBarButtonItem) {
    let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = "Parks"
    let coordinateSpan = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        let center = currentLocation.coordinate
    request.region = MKCoordinateRegion(center: center, span: coordinateSpan)
    let search = MKLocalSearch(request: request)
        search.start {(response,error) in
            guard let response = response else{return}
            for dog in response.mapItems{
                self.parks.append(dog)
                let annotation = MKPointAnnotation()
                annotation.coordinate = dog.placemark.coordinate
                annotation.title = dog.name
                self.mapView.addAnnotation(annotation)
            }
            
            
        }
    }
    
    @IBAction func zoomButton(_ sender: UIBarButtonItem) {
    let coordinateSpan = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        let center = currentLocation.coordinate
        let region = MKCoordinateRegion(center: center, span: coordinateSpan)
        mapView.setRegion(region, animated: true)
    
    
    
    
    }
    


}

