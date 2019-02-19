//
//  ExplorePets.swift
//  Pet Viewer
//
//  Created by Smriti Arora on 11/02/19.
//  Copyright © 2019 Smriti Arora. All rights reserved.
//

import UIKit
import Pods_Pet_Viewer
import Poi
import Alamofire
import AlamofireObjectMapper
import Kingfisher

class ExplorePets: UIViewController, PoiViewDataSource, PoiViewDelegate
{
    
    @IBOutlet weak var poiView: PoiView!
    
    var myservice = ServiceWrapper()
    var sampleCards = [Card]()
    var petList = [Pets]()
    
    let usertoken = UserDefaults.standard.string(forKey: "session")
    
    func alert(msg: String){
        
        let alert=UIAlertController(title: "Pet Tinder says:", message: msg,preferredStyle: .alert)
        
        let action=UIAlertAction(title: "Go Back", style: .default, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
        
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
          //Request function for API
       
        myservice.isconnected()
            { (connect) in
                if(connect == true)
                {
                //Internet Available
                self.myservice.get(url: "http://ec2-3-91-83-117.compute-1.amazonaws.com:3000/pets") { (pets) in
                    self.petList = pets
                    self.createViews()
                    self.poiView.dataSource = self
                    self.poiView.delegate = self
                }
            }
            else {
                self.alert(msg: "No Internet! Check Connectivity.")
                return
            }
    }
    }
    
    
// Logout Action
    @IBAction func logout(_ sender: Any)
    {
        func alert(msg: String){
            
            let alert = UIAlertController(title: "Pet Tinder says: ", message: msg, preferredStyle: .alert)
            let action = UIAlertAction(title: "Ok", style: .default) { (action) -> Void in
                let viewControllerYouWantToPresent = self.storyboard?.instantiateViewController(withIdentifier: "LoginPage")
                self.present(viewControllerYouWantToPresent!, animated: true, completion: nil)
            }
            alert.addAction(action)
            self.present(alert, animated: true, completion: nil)
            
        }
        myservice.logout{ (Code) in
            if(Code == 1)
            {
                UserDefaults.standard.set(nil, forKey: "session")
                alert(msg: "You have been logged out successfully!")
            }
        if (Code == 0){
        self.alert(msg: "Logout Error")
        }
        }
    }
    
    
  //Request function for API
    
    //Creation of cards of Card.swift type
    
    private func createViews() {
        for i in (0..<self.petList.count) {
            let card = UINib(nibName: "Card", bundle: nil).instantiate(withOwner: self, options: nil)[0] as! Card
            card.prepareUI(text: self.petList[i].Name!, img: petList[i].Imgsrc!)
            sampleCards.append(card)
        }
    }
        
        override func didReceiveMemoryWarning() {
            super.didReceiveMemoryWarning()
        }
    
    
    
    
    // MARK: PoiViewDataSource
    
    func numberOfCards(_ poi: PoiView) -> Int
      {
            return self.petList.count
      }
        
    func poi(_ poi: PoiView, viewForCardAt index: Int) -> UIView
     {
            return sampleCards[index]
     }
        
    
    func poi(_ poi: PoiView, viewForCardOverlayFor direction: SwipeDirection) -> UIImageView?
    {
            switch direction {
            case .right:
                return UIImageView(image: #imageLiteral(resourceName: "likenew-1"))
            case .left:
                return UIImageView(image: #imageLiteral(resourceName: "unlike"))
            }
        }
    
    
    
    // MARK: PoiViewDelegate
    
    func poi(_ poi: PoiView, didSwipeCardAt: Int, in direction: SwipeDirection)
      {
        
        //Update API call
            switch direction
            {
            case .left:
                    myservice.update(Status: false, petId: self.petList[didSwipeCardAt-1].ID!, url: "http://ec2-3-91-83-117.compute-1.amazonaws.com:3000/pets/likes/")
                    {print ("Pet Disliked")}
            case .right:
                    myservice.update(Status: true, petId: self.petList[didSwipeCardAt-1].ID!, url: "http://ec2-3-91-83-117.compute-1.amazonaws.com:3000/pets/likes/")
                         {print ("Pet Liked")}
           }
     }
    
        
    func poi(_ poi: PoiView, runOutOfCardAt: Int, in direction: SwipeDirection)
     {
       self.alert(msg: "SORRY, I RAN-OUT OF PETS!")
     }
        
    
    // MARK: IBActionButtons
    
    @IBAction func Like(_ sender: UIButton)
    {
        poiView.swipeCurrentCard(to: .right)
    }
    
    @IBAction func dislike(_ sender: UIButton)
    {
        poiView.swipeCurrentCard(to: .left)
    }
    
    @IBAction func undo(_ sender: UIButton)
    {
            poiView.undo()
    }

    
    //Main Class End
    }

