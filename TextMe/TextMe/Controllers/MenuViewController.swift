//
//  MenuViewController.swift
//  TextMe
//
//  Created by ofir sharabi on 21/04/2019.
//  Copyright © 2019 Gal Gordon. All rights reserved.
//

import UIKit
import Firebase

class MenuViewController: UIViewController, UITableViewDelegate , UITableViewDataSource {

    @IBOutlet weak var menuBtn: UIButton!
    
    
     @IBOutlet var ContactTableView: UITableView!
    
    
    let settingsLauncher = settingsHelper()
    
     var usersArray = [User]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        menuBtn.setImage(UIImage(named: "icons8-menu_2"), for: .normal)
        
      //  self.clearsSelectionOnViewWillAppear = false
        
        self.navigationItem.rightBarButtonItem = self.editButtonItem
        ContactTableView.register(userCell.self, forCellReuseIdentifier: "cell")
        fetchUser()
        
        
    }
    
    @IBAction func onMenuCllicked(_ sender: UIButton) {
        openSettings()
    }
    
    func openSettings(){
        settingsLauncher.handleBackgroundBlur()
    }
    
    func fetchUser(){
        Database.database().reference().child("Users").observe(.childAdded) { (DataSnapshot) in
            if let dict = DataSnapshot.value as? [String:AnyObject]{
                var user = User()
                user.displayName = dict["displayName"] as! String
                user.Email = dict["email"] as! String
                user.id = dict["id"] as! String
                self.usersArray.append(user)
                self.ContactTableView.reloadData()
            }
            print(DataSnapshot)
        }
    }
    // MARK: - Table view data source
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return usersArray.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = ContactTableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let user = usersArray[indexPath.row]
        cell.detailTextLabel?.text = user.Email
        cell.textLabel?.text = user.displayName
        return cell
    }
    
    
    
    
    class userCell : UITableViewCell {
        override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
            super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        }
        
        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
    }
//:TODO - Add these func
  /*  func loadLabel(){
        let uid = Auth.auth().currentUser?.uid
        Database.database().reference().child("Users").child(uid ?? "").observe(.value, with:{
            (snap) in
            if let dict = snap.value as? [String:AnyObject]{
                self.UserNickname.text = dict["displayName"] as? String
                
            }})
        print("success")
    }*/

    /*@IBAction func pickProfilePic(_ sender: Any) {
        let pick = UIImagePickerController()
        pick.delegate = self
        present(pick, animated: true, completion: nil)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else { return }
        profilePicture.image = image
        self.dismiss(animated: true, completion: nil)
    }*/
    
    
    
     
}
