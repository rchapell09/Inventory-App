//
//  FolderTableViewController.swift
//  classproject
//
//  Created by rchapell on 10/31/18.
//  Copyright © 2018 rchapell. All rights reserved.
//

import UIKit

class FolderTableViewController: UITableViewController {

    @IBOutlet var folderTable: UITableView!
    
    var folderList:folders =  folders()
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        // number of rows based on the coredata storage
        return folderList.folders.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "folderCell", for: indexPath) as! FolderTableViewCell
        cell.layer.borderWidth = 1.0
        cell.folderName.text = folderList.folders[indexPath.row].folderName
     
        return cell
    }

    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool
    {
        return false
    }
    
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle { return UITableViewCellEditingStyle.none }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let selectedIndex: IndexPath = self.folderTable.indexPath(for: sender as! UITableViewCell)!
        
      
        
        if segue.identifier == "tocategory"{
            if let tableviewController: CategoryTableViewController = segue.destination as? CategoryTableViewController{
                tableviewController.categorytype = selectedIndex.row
            }
        }
        
        
        
    }
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //if item entity is empty then
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
   



}
