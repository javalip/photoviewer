//
//  ViewController.swift
//  MyPhotoViewer
//
//  Created by Preeti  on 2/25/16.
//  Copyright (c) 2016 Preeti . All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ViewController: UIViewController {
    
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var bio: UILabel!
    
    @IBOutlet weak var postCount: UILabel!
    @IBOutlet weak var followingCount: UILabel!
    @IBOutlet weak var followersCount: UILabel!
    
    @IBOutlet weak var toggleViews: UISegmentedControl!
    
    @IBOutlet weak var collectionViewVC: UIView!
    @IBOutlet weak var tableViewVC: UIView!
    @IBOutlet weak var username: UINavigationItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //Make sure only one container view is visible
        self.tableViewVC.hidden = true
        
        //Make the profile image circular
//        self.profileImageView.layer.cornerRadius = 45
//        self.profileImageView.layer.masksToBounds = true
        
        //Change the color of the Navigation View
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 59/256, green: 89/256, blue: 152/256, alpha: 1)
        // self.navigationController?.navigationBar.translucent = false
        self.navigationController!.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName : UIColor.whiteColor()]
        
        let access_token = "2976894754.fc8b61d.27d63d5903304477a4467b5a2ff99d81"
        
        //One way to request data using Alamofire
        let request = "https://api.instagram.com/v1/users/self/?access_token=\(access_token)"
        
        Alamofire.request(.GET,  request).responseJSON {
            Response in switch Response.result
            {
            case .Success(let value):
                let resultDict = value["data"] as! NSDictionary
                
                print("resultDict is :\(resultDict)")
                
                self.name.text = resultDict["full_name"] as? String
                self.bio.text = resultDict["bio"] as? String
                
                let username = resultDict["username"] as? String
//                Common.setUserName(username!)
                self.username.title = username!
                
                
                let counts = resultDict["counts"] as! NSDictionary
                
                self.postCount.text = String(counts["media"]!)
                self.followersCount.text = String(counts["followed_by"]!)
                self.followingCount.text = String(counts["follows"]!)
                
                
                let imageString = resultDict["profile_picture"] as? String
                let url = NSURL(string: imageString!)
                let data = NSData(contentsOfURL: url!)
                self.profileImageView.image = UIImage(data: data!)
                
                
            case .Failure(let error):
                print("Could not load data:\(error)")
            }
        }
    }
    
    @IBAction func toggleViewAction(sender: AnyObject) {
        
        if(self.toggleViews.selectedSegmentIndex == 0)
        {
            self.collectionViewVC.hidden = false
            self.tableViewVC.hidden = true
        }
        else if(self.toggleViews.selectedSegmentIndex == 1)
        {
            self.collectionViewVC.hidden = true
            self.tableViewVC.hidden = false
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

