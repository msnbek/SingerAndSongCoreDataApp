//
//  ViewController.swift
//  SingerAndSongAppCoreData
//
//  Created by Mahmut Senbek on 28.12.2022.
//

import UIKit
import CoreData

class SingerViewController: UITableViewController {
var singerArray = [Singer]()
    override func viewDidLoad() {
        super.viewDidLoad()
loadSinger()
        
        
        
    }

    @IBAction func addButtonClicked(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Singer", message: "", preferredStyle: UIAlertController.Style.alert)
        let action = UIAlertAction(title: "Add", style: UIAlertAction.Style.default) { (action) in
            
            if textField.text == "" {
                let alert = UIAlertController(title: "Error", message: "Please Fill The Blanks.", preferredStyle: UIAlertController.Style.actionSheet)
                let action = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default)
                alert.addAction(action)
                self.present(alert, animated: true)
        
            }else {
                let appDelegate = UIApplication.shared.delegate as! AppDelegate
                let context = appDelegate.persistentContainer.viewContext
                let newSinger = Singer(context: context)
                newSinger.name = textField.text
                
                self.singerArray.append(newSinger)
                self.tableView.reloadData()
                self.saveSinger()
    
                
            }
            
      
                
            }
        alert.addTextField { (alertTextField) in
            
            alertTextField.placeholder = "Add New Singer"
            textField = alertTextField
        
            
        }
        alert.addAction(action)
        self.present(alert, animated: true)
        
    }
    
    func saveSinger() {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        do {
            try context.save()
            print("saved")
        }catch {
            print("saved error \(error)")
        }
        self.tableView.reloadData()
        
    }
    
    func loadSinger() {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let request : NSFetchRequest<Singer> = Singer.fetchRequest()
        
        do {
            singerArray = try context.fetch(request)
        }catch {
            print("load eror \(error)")
        }
        
        
    }
    
}

extension SingerViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return singerArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "singerCell", for: indexPath)
        let newSinger = singerArray[indexPath.row]
        cell.textLabel?.text = newSinger.name
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "toSongVC", sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! SongsViewController
        
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.selectedSinger = singerArray[indexPath.row]
        }
        
      
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context = appDelegate.persistentContainer.viewContext
            
            context.delete(singerArray[indexPath.row])
            singerArray.remove(at: indexPath.row)
            saveSinger()
        }
    }
}

