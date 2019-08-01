//
//  MessageViewController.swift
//  classproject
//
//  Created by rchapell on 11/12/18.
//  Copyright © 2018 rchapell. All rights reserved.
//

import UIKit
import CoreData
class MessageViewController: UIViewController {
    @IBOutlet weak var textbox: UITextView!
    let managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var   tempresults =   [ItemEntity]()
    

    
    
    
    
    @IBAction func cleartext(_ sender: Any) {
        textbox.text = "\t\tInventory"
    }
    
    @IBAction func boba(_ sender: Any) {
        let catname = "Bobas"
       var tempString = "\n\t\tBobas\n\n"
        for items in tempresults{
            let item = items
            if (item.itemCat == catname){
                tempString = tempString + (item.itemName!) + ":\t\t" + (String(item.itemQuantity)) + "\n"
            }
        }
        textbox.text = textbox.text + tempString
    }
    
    @IBAction func coffee(_ sender: Any) {
        let catname = "Coffee"
        var tempString = "\n\t\t" + (catname) + "\n\n"
        for items in tempresults{
            let item = items
            if (item.itemCat == catname){
                tempString = tempString + (item.itemName!) + ":\t\t" + (String(item.itemQuantity)) + "\n"
            }
        }
        textbox.text = textbox.text + tempString
    }
    
    @IBAction func dairy(_ sender: Any) {
        let catname = "Dairy"
        var tempString = "\n\t\t" + (catname) + "\n\n"
        for items in tempresults{
            let item = items
            if (item.itemCat == catname){
                tempString = tempString + (item.itemName!) + ":\t\t" + (String(item.itemQuantity)) + "\n"
            }
        }
        textbox.text = textbox.text + tempString
    }
    
    @IBAction func fruits(_ sender: Any) {
        let catname = "Fruits"
        var tempString = "\n\t\t" + (catname) + "\n\n"
        for items in tempresults{
            let item = items
            if (item.itemCat == catname){
                tempString = tempString + (item.itemName!) + ":\t\t" + (String(item.itemQuantity)) + "\n"
            }
        }
        textbox.text = textbox.text + tempString
    }
    @IBAction func monin(_ sender: Any) {
        let catname = "Monin"
        var tempString = "\n\t\t" + (catname) + "\n\n"
        for items in tempresults{
            let item = items
            if (item.itemCat == catname){
                tempString = tempString + (item.itemName!) + ":\t\t" + (String(item.itemQuantity)) + "\n"
            }
        }
        textbox.text = textbox.text + tempString
    }
    
    @IBAction func syrups(_ sender: Any) {
        let catname = "Syrups"
        var tempString = "\n\t\t" + (catname) + "\n\n"
        for items in tempresults{
            let item = items
            if (item.itemCat == catname){
                tempString = tempString + (item.itemName!) + ":\t\t" + (String(item.itemQuantity)) + "\n"
            }
        }
        textbox.text = textbox.text + tempString
    }
    
    @IBAction func tea(_ sender: Any) {
        let catname = "Tea"
        var tempString = "\n\t\t" + (catname) + "\n\n"
        for items in tempresults{
            let item = items
            if (item.itemCat == catname){
                tempString = tempString + (item.itemName!) + ":\t\t" + (String(item.itemQuantity)) + "\n"
            }
        }
        textbox.text = textbox.text + tempString
    }

    @IBAction func powder(_ sender: Any) {
        let catname = "Powders"
        var tempString = "\n\t\t" + (catname) + "\n\n"
        for items in tempresults{
            let item = items
            if (item.itemCat == catname){
                tempString = tempString + (item.itemName!) + ":\t\t" + (String(item.itemQuantity)) + "\n"
            }
        }
        textbox.text = textbox.text + tempString
    }
    @IBAction func misc(_ sender: Any) {
        let catname = "Misc"
        var tempString = "\n\t\t" + (catname) + "\n\n"
        for items in tempresults{
            let item = items
            if (item.itemCat == catname){
                tempString = tempString + (item.itemName!) + ":\t\t" + (String(item.itemQuantity)) + "\n"
            }
        }
        textbox.text = textbox.text + tempString
    }
    @IBAction func bathroom(_ sender: Any) {
        let catname = "Bathroom"
        var tempString = "\n\t\t" + (catname) + "\n\n"
        for items in tempresults{
            let item = items
            if (item.itemCat == catname){
                tempString = tempString + (item.itemName!) + ":\t\t" + (String(item.itemQuantity)) + "\n"
            }
        }
        textbox.text = textbox.text + tempString
    }
    @IBAction func cleaning(_ sender: Any) {
        let catname = "Cleaning"
        var tempString = "\n\t\t" + (catname) + "\n\n"
        for items in tempresults{
            let item = items
            if (item.itemCat == catname){
                tempString = tempString + (item.itemName!) + ":\t\t" + (String(item.itemQuantity)) + "\n"
            }
        }
        textbox.text = textbox.text + tempString
    }
    @IBAction func cups(_ sender: Any) {
        let catname = "Cups"
        var tempString = "\n\t\t" + (catname) + "\n\n"
        for items in tempresults{
            let item = items
            if (item.itemCat == catname){
                tempString = tempString + (item.itemName!) + ":\t\t" + (String(item.itemQuantity)) + "\n"
            }
        }
        textbox.text = textbox.text + tempString
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textbox.isEditable = true
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "ItemEntity")
        
        // Execute the fetch request, and cast the results to an array of ItemEntity objects
        tempresults = ((try? managedObjectContext.fetch(fetchRequest)) as? [ItemEntity])!
        
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
