//
//  CompViewController.swift
//  classproject
//
//  Created by rchapell on 11/14/18.
//  Copyright © 2018 rchapell. All rights reserved.
//

import UIKit
import MapKit

class CompViewController: UIViewController, MKMapViewDelegate {

    
    @IBOutlet weak var map: MKMapView!
    @IBOutlet weak var textfield: UITextField!
    @IBOutlet weak var mapType: UISegmentedControl!
    @IBOutlet weak var bobalabel: UILabel!
    
    let addressString = "521 S College Ave #11, Tempe, AZ 85281"
    let geoCoder = CLGeocoder();
    var coord:CLLocationCoordinate2D?
    
    
    
    
    @IBAction func showMap(_ sender: Any) {
        switch(mapType.selectedSegmentIndex)
        {
        case 0:
            map.mapType = MKMapType.standard
            
        case 1:
            map.mapType = MKMapType.satellite
            
        case 2:
            map.mapType = MKMapType.hybrid
            
        default:
            map.mapType = MKMapType.standard
        }
    }
    
    @IBAction func clearanno(_ sender: Any) {
       var annotationsarray = map.annotations
        var x:Int! = 0
        for ann in annotationsarray{
            let ancoord = ann.coordinate
            if ancoord.latitude == coord!.latitude && ancoord.longitude == coord!.longitude{
                annotationsarray.remove(at: x)
            }
            x = x + 1
        }
        map.removeAnnotations(annotationsarray)
            bobalabel.isHidden = true
    }
    @IBAction func searchit(_ sender: Any) {
        let request = MKLocalSearchRequest()
        request.naturalLanguageQuery = textfield.text!
        if textfield.text! == "Boba"||textfield.text! == "boba"||textfield.text! == "coffee"||textfield.text! == "Coffee"{
            bobalabel.isHidden = false
        }
        request.region = map.region
        let search = MKLocalSearch(request: request)
        
        search.start { response, _ in
            guard let response = response else {
                return
            }
            print( response.mapItems )
            var matchingItems:[MKMapItem] = []
            matchingItems = response.mapItems
            if matchingItems.count == 1{
                let place = matchingItems[0].placemark
                let ani = MKPointAnnotation()
                ani.coordinate = place.location!.coordinate
                ani.title = place.name
                ani.subtitle = place.subLocality
                self.map.addAnnotation(ani)
            }
            else if matchingItems.count == 0{
                print("noitems found")//no items found
            }
            else{
                for i in 1...matchingItems.count - 1
                {
                    let place = matchingItems[i].placemark
                    let ani = MKPointAnnotation()
                    ani.coordinate = place.location!.coordinate
                    ani.title = place.name
                    ani.subtitle = place.subLocality
                    self.map.addAnnotation(ani)
                
                
                }
            }
            // self.tableView.reloadData()
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bobalabel.isHidden = true
        CLGeocoder().geocodeAddressString(addressString, completionHandler:
            {(placemarks, error) in
                
                if error != nil {
                    print("Geocode failed: \(error!.localizedDescription)")
                } else if placemarks!.count > 0 {
                    let placemark = placemarks![0]
                    
                    let location = placemark.location
                    let coords = location!.coordinate
                    print(location)
                   
                    
                    let span = MKCoordinateSpanMake(0.05, 0.05)
                    let region = MKCoordinateRegion(center: placemark.location!.coordinate, span: span)
                    self.map.setRegion(region, animated: true)
                    let ani = MKPointAnnotation()
                    ani.coordinate = placemark.location!.coordinate
                    self.coord = ani.coordinate
                    ani.subtitle = placemark.subLocality
                    self.map.addAnnotation(ani)
                    
                    
                }
        })
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
