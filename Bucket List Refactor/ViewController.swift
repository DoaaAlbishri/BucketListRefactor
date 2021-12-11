//
//  ViewController.swift
//  Bucket List Refactor
//
//  Created by admin on 11/12/2021.
//

import UIKit

class BucketListViewController: UITableViewController, TableViewControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    var items = ["Sky diving", "Live in Hawaii"]
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // dequeue the cell from our storyboard
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListCell", for: indexPath)
        // All UITableViewCell objects have a build in textLabel so set it to the model that is corresponding to the row in array
        cell.textLabel?.text = items[indexPath.row]
        // return cell so that Table View knows what to draw in each row
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if sender is UIBarButtonItem{
        let nav = segue.destination as! UINavigationController
        let CRUDItemController = nav.topViewController as! CRUDTableViewController
        CRUDItemController.delegate = self
        }else if sender is IndexPath{
            let nav = segue.destination as! UINavigationController
            let CRUDItemController = nav.topViewController as! CRUDTableViewController
            CRUDItemController.delegate = self
            let indexPath = sender as! NSIndexPath
            let item = items[indexPath.row]
            CRUDItemController.item = item
            CRUDItemController.indexPath = indexPath
        }
    }
 // use this when i didn't have accessory button
    /*
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "editSegue", sender: indexPath)
    }
     */
    // edit item
    override func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        performSegue(withIdentifier: "Segue", sender: indexPath)
    }
    // delete item
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        items.remove(at: indexPath.row)
        tableView.reloadData()
    }
    
    func cancelItem(_ controller: CRUDTableViewController){
        dismiss(animated: true, completion: nil)
    }
    func saveItem(by controller: CRUDTableViewController, with text:String , at indexPath:NSIndexPath?){
        if let ip = indexPath {
            items[ip.row] = text
        }else{
        items.append(text)
        }
        tableView.reloadData()
        dismiss(animated: true, completion: nil)
    }

}

