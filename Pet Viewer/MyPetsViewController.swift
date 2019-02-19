//
//  MyPetsViewController.swift
//  Pet Viewer
//
//  Created by Smriti Arora on 13/02/19.
//  Copyright © 2019 Smriti Arora. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import Kingfisher

class PetModel: UITableViewCell {
    @IBOutlet weak var PetName: UILabel!
    @IBOutlet weak var PetDescription: UILabel!
    @IBOutlet weak var PetImage: UIImageView!
}

class PetViewController : UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchResultsUpdating, UISearchBarDelegate {
    
    
    
    //Update search reults
    func updateSearchResults(for searchController: UISearchController) {
        filteredTableData.removeAll(keepingCapacity: false)
        let searchPredicate = NSPredicate(format: "SELF CONTAINS[c] %@", searchController.searchBar.text!)
        let array = (tabledata as NSArray).filtered(using: searchPredicate)
        filteredTableData = array as! [String]
        self.CustomtableView.reloadData()
    }
    
    
    @IBOutlet weak var CustomtableView: UITableView!

     var tabledata = [String]()
    var myservice = ServiceWrapper()
    var filteredTableData = [String]()
    var resultSearchController = UISearchController()
    var PetLine = [Pets]()
    func APIrequest()
    {
        func alert(msg: String){
            
            let alert=UIAlertController(title: "Pet Tinder says:", message: msg,preferredStyle: .alert)
            
            let action=UIAlertAction(title: "Go Back", style: .default, handler: nil)
            alert.addAction(action)
            present(alert, animated: true, completion: nil)
            
        }
    
        myservice.isconnected()
            { (connect) in
                if(connect == true)
                    //Internet Available
                {
                self.myservice.get(url: "http://ec2-3-91-83-117.compute-1.amazonaws.com:3000/pets/likes") { (pets) in
                        self.PetLine = pets
                for pet in self.PetLine{
                    self.tabledata.append(pet.Name!)
                    }
                if self.PetLine.count > 0
                {
                        self.CustomtableView.delegate = self
                        self.CustomtableView.dataSource = self
                        self.CustomtableView.tableFooterView = UIView(frame: CGRect.zero)
                }
                else
                {
                    self.alert(msg: "Ohh! You have not Liked any pets")
                }
              }
            }
            else {
                alert(msg: "No Internet! Check your Connection.")
                return
            }
        }
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        APIrequest()
        
        self.resultSearchController = ({
            let controller = UISearchController(searchResultsController: nil)
            controller.searchResultsUpdater = self
            controller.dimsBackgroundDuringPresentation = false
            controller.searchBar.barStyle = UIBarStyle.black
            controller.searchBar.barTintColor = UIColor.white
            controller.searchBar.backgroundColor = UIColor.clear
            controller.searchBar.placeholder = "Enter Pet name";
            self.CustomtableView.tableHeaderView = controller.searchBar
            controller.searchBar.delegate = self
            return controller
        })()
        self.CustomtableView.reloadData()
        
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = nil
        searchBar.showsCancelButton = false
        
        // Remove focus from the search bar.
        searchBar.endEditing(true)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.resultSearchController.isActive {
            return self.filteredTableData.count
        }else{
            return self.tabledata.count
        }
    }
    
    
    
   func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 150
    }
    
 func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
      {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BaseCell", for: indexPath) as! PetModel
        if self.resultSearchController.isActive {
            cell.PetName.text = filteredTableData[indexPath.row]
            for search in PetLine{
             if filteredTableData[indexPath.row] == search.Name
             {
              cell.PetDescription.text = search.Description
              let imgurl = URL(string: search.Imgsrc!)
              cell.PetImage.kf.setImage(with: imgurl)
                break
             }
            }
        }
        else
        {
        cell.PetName.text = self.PetLine[indexPath.row].Name
        cell.PetDescription.text = self.PetLine[indexPath.row].Description
        let imgurl = URL(string: self.PetLine[indexPath.row].Imgsrc!)
        cell.PetImage.kf.setImage(with: imgurl)
        }
        return cell
    }
    
    
    
    // Alert Function
    func alert(msg: String){
        
        let alert = UIAlertController(title: "Pet Tinder says: ", message: msg, preferredStyle: .alert)
        let action = UIAlertAction(title: "Go Back and Like Pets", style: .default) { (action) -> Void in
            let viewControllerYouWantToPresent = self.storyboard?.instantiateViewController(withIdentifier: "ExplorePets")
            self.present(viewControllerYouWantToPresent!, animated: true, completion: nil)
        }
        alert.addAction(action)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
        
    }
    
 
}

