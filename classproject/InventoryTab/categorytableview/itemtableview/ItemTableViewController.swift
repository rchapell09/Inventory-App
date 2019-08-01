//
//  ItemTableViewController.swift
//  classproject
//
//  Created by rchapell on 11/7/18.
//  Copyright © 2018 rchapell. All rights reserved.
//

import UIKit
import CoreData
class ItemTableViewController: UITableViewController{

    @IBOutlet var itemTable: UITableView!
    var categoryType:Int?
    var itemTypeString:String?
    var searching = false
    let itemstuff = itemfunctions()
    
    let managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    //this is the array to store Fruit entities from the coredata
    var   fetchResults =   [ItemEntity]()

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
            return fetchResults.count
        
        // number of rows based on the coredata storage
       
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // add each row from coredata fetch results
        let cell = tableView.dequeueReusableCell(withIdentifier: "itemCell", for: indexPath) as! ItemTableViewCell
        cell.layer.borderWidth = 1.0
        
            cell.itemNameLabel.text = fetchResults[indexPath.row].itemName
            cell.quantlabel.text =  String(fetchResults[indexPath.row].itemQuantity)
            cell.picview.image = UIImage(data: fetchResults[indexPath.row].itemPic! as Data)
        
    
        
        return cell
    }
    
    // delete table entry
    // this method makes each row editable
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool
    {
        return true
    }
    // return the table view style as deletable
    
    func tableView(tableView: UITableView, editingStyleForRowAtIndexPath indexPath: IndexPath) -> UITableViewCellEditingStyle { return UITableViewCellEditingStyle.delete }
    
    
    // implement delete function
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath)
    {
        
        if editingStyle == .delete
        {
            
            // delete the selected object from the managed
            // object context
            let tempitem = fetchResults[indexPath.row]
            itemstuff.deleteitem(item: tempitem)
            
            // remove it from the fetch results array
            fetchResults.remove(at:indexPath.row)
            
            
            // reload the table after deleting a row
            itemTable.reloadData()
        }
        
    }
    

    
    @IBAction func addItem(_ sender: Any) {
        // create a new entity object
        let alert = UIAlertController(title: "Add Item", message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        alert.addTextField(configurationHandler: { textField in
            textField.placeholder = "Enter Name of the Item Here"
        })
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
            
            
            if let name = alert.textFields?.first?.text {
                
                
                self.itemstuff.addnewitem(name:name, cat:self.itemTypeString!)
                
                
              //  self.fetchResults.append(newItem)
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                    
                }
                
                
            }
        }))
        self.present(alert, animated: true)
       
   
    
    }
    
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let selectedIndex: IndexPath = self.itemTable.indexPath(for: sender as! UITableViewCell)!
        
        let item = fetchResults[selectedIndex.row]
        
        if(segue.identifier == "toitemdetail"){
            if let detailViewController: itemDetailViewController = segue.destination as? itemDetailViewController {
                
                detailViewController.name = item.itemName!
                detailViewController.quant = Int(item.itemQuantity)
                detailViewController.selectedImage = UIImage(data: item.itemPic! as Data)
                detailViewController.selectedIndex = selectedIndex.row
            }
        }
    }

    
    @IBAction func fromdetail(segue: UIStoryboardSegue)
    {
        
        
        
        if let itemdetailview = segue.source as? itemDetailViewController {
            let indexitem = itemdetailview.selectedIndex!
            let item = fetchResults[indexitem]
            item.itemQuantity = Int16(itemdetailview.quant!)
            let pic = itemdetailview.selectedImage
            item.itemPic = UIImagePNGRepresentation(pic!)! as NSData
            
            fetchResults[indexitem] = item
            
            
        }
        do {
            try self.managedObjectContext.save()
        } catch _ {
            print("did not save")
        }
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
        
        
    }
    
    
   
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

