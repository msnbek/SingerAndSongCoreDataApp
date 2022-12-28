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

       
    }
    

    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {

        
        let alert = UIAlertController(title: "Add New Singer", message: "Add Singer", preferredStyle: UIAlertController.Style.alert)
        let action = UIAlertAction(title: "Add", style: UIAlertAction.Style.default) { (action) in
            
            
            let textField = UITextField()
            
            if textField.text == "" {
                
                
                
                
                
            }
            
            
        }
        alert.addAction(action)
        self.present(alert, animated: true)
        
        
        
        
        
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

