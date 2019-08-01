//
//  CategoryTableViewController.swift
//  classproject
//
//  Created by rchapell on 11/5/18.
//  Copyright © 2018 rchapell. All rights reserved.
//

import UIKit
import CoreData

class CategoryTableViewController: UITableViewController {
    var categorytype:Int?
    var frontList:frontcat?
    var backList:backcat?
    
    @IBOutlet var catTable: UITableView!
    
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var amount:Int?
        if(categorytype! == 0){
            amount = frontList!.frontcat.count
        }
        else if(categorytype! == 1){
            amount = backList!.backcat.count
        }
        return amount!
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "catCell", for: indexPath) as! CategoryTableViewCell
        cell.layer.borderWidth = 1.0
        if(categorytype! == 0){
            cell.catname.text = frontList!.frontcat[indexPath.row].catName
        }
        else if(categorytype! == 1){
            cell.catname.text = backList!.backcat[indexPath.row].catName
        }
        
        
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool
    {
        return false
    }
    
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle { return UITableViewCellEditingStyle.none }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let selectedIndex: IndexPath = self.catTable.indexPath(for: sender as! UITableViewCell)!
        var itemType:Int?
        var itemTypeString:String?
        
        let managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        var fetchItemResults = [ItemEntity]()
        var   fetchResults =   [ItemEntity]()
        
        
        if segue.identifier == "toitem"{
            if let tableviewController: ItemTableViewController = segue.destination as? ItemTableViewController{
                tableviewController.categoryType = categorytype
                itemType = selectedIndex.row
                
                switch categorytype{
                case 0://frontstore
                    switch itemType{
                    case 0://bobas
                        itemTypeString = "Bobas"
                        break
                    case 1://coffee
                        itemTypeString = "Coffee"
                        break
                    case 2://dairy
                        itemTypeString = "Dairy"
                        break
                    case 3://fruits
                        itemTypeString = "Fruits"
                        break
                    case 4://monin
                        itemTypeString = "Monin"
                        break
                    case 5://syrups
                        itemTypeString = "Syrups"
                        break
                    case 6://tea
                        itemTypeString = "Tea"
                        break
                    case 7://powders
                        itemTypeString = "Powders"
                        break
                    case 8://misc
                        itemTypeString = "Misc"
                        break
                    default:
                        itemTypeString = "Misc"
                    }
                    break
                case 1://backstore
                    switch itemType{
                    case 0://bathroom
                        itemTypeString = "Bathroom"
                        break
                    case 1://cleaning
                        itemTypeString = "Cleaning"
                        break
                    case 2://cups
                        itemTypeString = "Cups"
                        break
                    case 3://else
                        break
                    default:
                        itemTypeString = "Bathroom"
                    }
                    break
                default://default which means backroom
                    switch itemType{
                    case 0://bathroom
                        itemTypeString = "Bathroom"
                        break
                    case 1://cleaning
                        itemTypeString = "Cleaning"
                        break
                    case 2://cups
                        itemTypeString = "Cups"
                        break
                    case 3://else
                        break
                    default:
                        itemTypeString = "Bathroom"
                    }
                }
                tableviewController.itemTypeString = itemTypeString
                let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "ItemEntity")
               
                // Execute the fetch request, and cast the results to an array of FruitEnity objects
                fetchResults = ((try? managedObjectContext.fetch(fetchRequest)) as? [ItemEntity])!
                for items in fetchResults {
                    let tempitem = items as ItemEntity
                    if tempitem.itemCat == itemTypeString{
                        fetchItemResults.append(tempitem)
                        
                    }
                }
                let sortedresults = fetchItemResults.sorted { $0.itemName! < $1.itemName! }
                
                tableviewController.fetchResults = sortedresults
                
                
                
                
            }
        }
        
        
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        switch categorytype{
        case 0:
            frontList = frontcat()
            break
        case 1:
            backList = backcat()
            break
        default:
            frontList = frontcat()
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
}
