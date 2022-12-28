//
//  SongsViewController.swift
//  SingerAndSongAppCoreData
//
//  Created by Mahmut Senbek on 28.12.2022.
//

import UIKit
import CoreData

class SongsViewController: UITableViewController {
var songsArray = [Songs]()
    override func viewDidLoad() {
        super.viewDidLoad()

       loadFunc()
    }
    
//MARK: - AddButton IBAction
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        
        
        let alert = UIAlertController(title: "Add New Song", message: "", preferredStyle: UIAlertController.Style.alert)
        let action = UIAlertAction(title: "Add", style: UIAlertAction.Style.default) { (action) in
            
            
         
            
            if textField.text == "" {
                
                let alert = UIAlertController(title: "Error", message: "Please Fill The Blans", preferredStyle: UIAlertController.Style.actionSheet)
                let action = UIAlertAction(title: "OK", style: UIAlertAction.Style.default)
                alert.addAction(action)
                self.present(alert, animated: true)
         
            }else {
                
                let appDelegate = UIApplication.shared.delegate as! AppDelegate
                let context = appDelegate.persistentContainer.viewContext
                let newSong = Songs(context: context)
                newSong.songName = textField.text
                self.songsArray.append(newSong)
                self.tableView.reloadData()
                self.saveSong()
              
            }
     
        }
        
        alert.addTextField { (alertTextField) in
            
            alertTextField.placeholder = "Add new song"
             textField = alertTextField
       
        }
        alert.addAction(action)
        self.present(alert, animated: true)
   
    }
    
    
    
    func saveSong() {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        do{
            try context.save()
            print("saved")
        }catch {
            print("error saving \(error)")
        }
        
        
    }
    
    func loadFunc() {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let request : NSFetchRequest<Songs> = Songs.fetchRequest()
        
        do {
            songsArray = try context.fetch(request)
        }catch {
            print("load error \(error)")
        }
        
        
    }
   

}


//MARK: - Table View Methods

extension SongsViewController  {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return songsArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "songCell", for: indexPath)
        let newSong = songsArray[indexPath.row]
        cell.textLabel?.text = newSong.songName
        return cell
    }
    
    
}

