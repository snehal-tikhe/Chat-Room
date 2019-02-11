//
//  AvatarPickerViewController.swift
//  Chat Room
//
//  Created by Snehal Tikhe on 2/10/19.
//  Copyright © 2019 Snehal Tikhe. All rights reserved.
//

import UIKit

class AvatarPickerViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    

    //outlets
    @IBOutlet weak var avatarTypeSegment: UISegmentedControl!
    @IBOutlet weak var avatarPickerCollectionView: UICollectionView!
    
    //variables
    var avatarType = AvatarType.dark
    
    override func viewDidLoad() {
        
        avatarPickerCollectionView.delegate = self
        avatarPickerCollectionView.dataSource = self
        super.viewDidLoad()
    }
    
    @IBAction func backButtonTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func avatarTypeSegmentTapped(_ sender: Any) {
        
        if avatarTypeSegment.selectedSegmentIndex == 0
        {
            avatarType = AvatarType.dark
        }
        else
        {
            avatarType = AvatarType.light
        }
        
        avatarPickerCollectionView.reloadData()
    }
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 28;
    }
    
   
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let cell = collectionView .dequeueReusableCell(withReuseIdentifier: "avatarCell", for: indexPath) as? AvatarPickerCell{
            
            cell.configureCell(index: indexPath.item, type: avatarType)
            
            return cell
        }
        return AvatarPickerCell();
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            if avatarType == .dark {
                UserDataService.instance.setAvatarName(avatarName: "dark\(indexPath.item)")
            } else {
                UserDataService.instance.setAvatarName(avatarName: "light\(indexPath.item)")
        }
        
        self.dismiss(animated: true, completion: nil)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        var numofColumns : CGFloat = 3
        if UIScreen.main.bounds.width > 320
        {
            numofColumns = 4
        }
        
        let spaceBetweenCells : CGFloat = 10
        let padding : CGFloat = 40
        let cellDimention = ((collectionView.bounds.width - padding) - (numofColumns - 1) * spaceBetweenCells) / numofColumns
        
        return CGSize(width: cellDimention, height: cellDimention)
    
    }
    
    
}
