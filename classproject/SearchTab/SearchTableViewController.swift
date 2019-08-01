//
//  SearchTableViewController.swift
//  classproject
//
//  Created by rchapell on 11/12/18.
//  Copyright © 2018 rchapell. All rights reserved.
//

import UIKit
import CoreData
class SearchTableViewController: UITableViewController, UISearchBarDelegate {
    

    @IBOutlet var searchItemTable: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    let managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    //this is the array to store Fruit entities from the coredata
    var   fetchResults =   [ItemEntity]()
    var searchitem = [ItemEntity]()
    var searching = false
    
    func fetchRecord() -> Int {
   
        var   tempresults =   [ItemEntity]()
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "ItemEntity")

        tempresults = ((try? managedObjectContext.fetch(fetchRequest)) as? [ItemEntity])!
        fetchResults = tempresults.sorted { $0.itemName! < $1.itemName! }

        return fetchResults.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if searching{
            return searchitem.count
        }
        else{
           return fetchRecord()
        }
       
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // add each row from coredata fetch results
        let cell = tableView.dequeueReusableCell(withIdentifier: "searchitemCell", for: indexPath) as! SearchItemTableViewCell
        cell.layer.borderWidth = 1.0
        if searching{
            cell.itemnamelabel.text = searchitem[indexPath.row].itemName
            cell.quantlabel.text =  String(searchitem[indexPath.row].itemQuantity)
            cell.picview.image = UIImage(data: searchitem[indexPath.row].itemPic! as Data)
        }
        else{
            cell.itemnamelabel.text = fetchResults[indexPath.row].itemName
            cell.quantlabel.text =  String(fetchResults[indexPath.row].itemQuantity)
            cell.picview.image = UIImage(data: fetchResults[indexPath.row].itemPic! as Data)
        }
   
        
        
        return cell
    }
    
    // delete table entry
    // this method makes each row not editable
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool
    {
        return false
    }
    // return the table view style as nondeletable
    
    func tableView(tableView: UITableView, editingStyleForRowAtIndexPath indexPath: IndexPath) -> UITableViewCellEditingStyle { return UITableViewCellEditingStyle.none }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchitem = fetchResults.filter({$0.itemName!.contains(searchText) ||
                                            $0.itemCat!.contains(searchText)})
        searching = true
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
      
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searching = false
        searchBar.text = ""
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let selectedIndex: IndexPath = self.searchItemTable.indexPath(for: sender as! UITableViewCell)!
        var item:ItemEntity!
        if searching{
             item = searchitem[selectedIndex.row]
        }
        else{
             item = fetchResults[selectedIndex.row]
        }
     
        
        if(segue.identifier == "tosearchitemdetail"){
            if let detailViewController: SearchItemDetailViewController = segue.destination as? SearchItemDetailViewController {
                
                detailViewController.name = item.itemName!
                detailViewController.quant = Int(item.itemQuantity)
                detailViewController.selectedImage = UIImage(data: item.itemPic! as Data)
                detailViewController.selectedIndex = selectedIndex.row
            }
        }
    }
    
    
    @IBAction func fromdetail(segue: UIStoryboardSegue)
    {
        if let itemdetailview = segue.source as? SearchItemDetailViewController {
            let indexitem = itemdetailview.selectedIndex!
            if searching{
                let item = searchitem[indexitem]
                item.itemQuantity = Int16(itemdetailview.quant!)
                let pic = itemdetailview.selectedImage
                item.itemPic = UIImagePNGRepresentation(pic!)! as NSData
            
                searchitem[indexitem] = item
            }
            else{
                let item = fetchResults[indexitem]
                item.itemQuantity = Int16(itemdetailview.quant!)
                let pic = itemdetailview.selectedImage
                item.itemPic = UIImagePNGRepresentation(pic!)! as NSData
                
                fetchResults[indexitem] = item
            }
            
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
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }

    

    

}
