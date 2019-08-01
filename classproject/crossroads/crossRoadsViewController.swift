//
//  crossRoadsViewController.swift
//  classproject
//
//  Created by rchapell on 11/19/18.
//  Copyright © 2018 rchapell. All rights reserved.
//

import UIKit
import MapKit
class crossRoadsViewController: UIViewController {
    var roadlist:roads =  roads()
    
    @IBOutlet weak var addressString: UITextField!
    @IBOutlet weak var latlabel: UILabel!
    @IBOutlet weak var lonlabel: UILabel!
    @IBOutlet weak var streetname: UILabel!
    @IBOutlet weak var indexlabel: UILabel!
    @IBOutlet weak var countlabel: UILabel!
    
    
    let geoCoder = CLGeocoder()
    var long = 0.0
    var latt = 0.0
    var roadindex = 0
    
    
    
    
    
    
    
    @IBAction func getinfo(_ sender: Any) {
        let addressstring = addressString.text!
       
        CLGeocoder().geocodeAddressString(addressstring, completionHandler:
            {(placemarks, error) in
                
                if error != nil {
                    print("Geocode failed: \(error!.localizedDescription)")
                } else if placemarks!.count > 0 {
                    let placemark = placemarks![0]
                    
                    let location = placemark.location
                    let coords = location!.coordinate
                    let lat:Double = coords.latitude
                    let lon:Double = coords.longitude
                    self.long = lon
                    self.latt = lat
                    print(location)
                    
                    
                    
                    let urlAsString = "http://api.geonames.org/findNearbyStreetsJSON?lat=" + String(lat) + "&lng=" + String(lon) + "&username=rchapell"
                    
                    //  print(urlAsString)
                    let url = URL(string: urlAsString)!
                    let urlSession = URLSession.shared
                    
                    let jsonQuery = urlSession.dataTask(with: url, completionHandler: { data, response, error -> Void in
                        if (error != nil) {
                            print(error!.localizedDescription)
                        }
                        var err: NSError?
                        
                        
                        var jsonResult = (try! JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers)) as! NSDictionary
                        if (err != nil) {
                            print("JSON Error \(err!.localizedDescription)")
                        }
                        
                        // print(jsonResult)
                        
                        
                        let setOne = jsonResult["streetSegment"]! as! NSArray
                        print(setOne)
                        self.countlabel.isHidden = false
                        self.latlabel.isHidden = false
                        self.lonlabel.isHidden = false
                        self.streetname.isHidden = false
                        self.indexlabel.isHidden = false
                        for y in setOne{
                            let roa = y as! [String: AnyObject]
                            let streetname = roa["name"] as? NSString
            
                            let newRoad = road(nm: streetname! as String)
                            self.roadlist.addroad(newroad: newRoad)
                            DispatchQueue.main.async
                                {
                                    
                                    self.latlabel.text = String(self.latt)
                                    self.lonlabel.text = String(self.long)
                                    self.countlabel.text = String(self.roadlist.roads.count-1)
                                    self.roadindex = 0
                                   
                                    self.indexlabel.text = String(self.roadindex)
                                    self.streetname.text = self.roadlist.roads[self.roadindex].name
                                    
 
                            }
                        }
                    })
                    jsonQuery.resume()
                }
                
        })
        
        
        
        
        
    }
   
    
    @IBAction func next(_ sender: Any) {
        if(roadlist.roads.count>0 && roadindex<(roadlist.roads.count-1)){
            roadindex = roadindex + 1
            indexlabel.text = String(roadindex)
            streetname.text = roadlist.roads[roadindex].name
        }
    }
    
    @IBAction func prev(_ sender: Any) {
        if(roadindex>0){
            roadindex = roadindex - 1
            indexlabel.text = String(roadindex)
            streetname.text = roadlist.roads[roadindex].name
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
         countlabel.isHidden = true
        latlabel.isHidden = true
        lonlabel.isHidden = true
        streetname.isHidden = true
        indexlabel.isHidden = true
        
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
