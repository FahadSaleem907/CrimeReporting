//
//  AdminDashboardCollectionViewCell.swift
//  CrimeReporting
//
//  Created by Fahad Saleem on 7/24/19.
//  Copyright © 2019 FahadSaleem. All rights reserved.
//

import UIKit

class AdminDashboardCollectionViewCell: UICollectionViewCell
{
    /// MARK: - Constants
    /// MARK: - Variables
    /// MARK: - Actions
    /// MARK: - Functions
   
    
    // MARK: - Outlets
    
    @IBOutlet weak var mainCellView: UIView!
    @IBOutlet weak var reportCount: UILabel!
    @IBOutlet weak var reportText: UILabel!
    @IBOutlet weak var backgroundImg: UIImageView!
    
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
        
        backgroundImg.contentMode = .scaleToFill
    }
}
