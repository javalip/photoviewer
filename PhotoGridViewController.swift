//
//  PhotoGridViewController.swift
//  MyPhotoViewer
//
//  Created by Preeti  on 3/21/16.
//  Copyright © 2016 Preeti . All rights reserved.
//
import UIKit

class PhotoGridViewController: UICollectionViewController {
    
    var resultsArray: NSArray = []
//    @IBOutlet weak var collectionView: UICollectionView!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        
        
        Media.getMedia(){responseObj, error in
            if let error = error
            {
                print("Data could not be loaded: \(error)")
            }
            self.resultsArray = (responseObj!["data"] as? NSArray)!
            self.collectionView.reloadData()
        }
    }
    
    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int
    {
        return 1
    }

    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return 10
    }
}
