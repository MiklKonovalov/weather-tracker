//
//  TodayCollectionViewCell.swift
//  Weather tracker
//
//  Created by Misha on 22.11.2021.
//

import UIKit

class TodayCollectionViewCell: UICollectionViewCell {
    
    /*var data: CustomData? {
        didSet {
            guard let data = data else { return }
            imageView.image = data.backgroundImage
        }
    }*/
    
    var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = #imageLiteral(resourceName: "Onboard")
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 22
        imageView.layer.borderWidth = 0.5
        imageView.clipsToBounds = true
        imageView.layer.borderColor = UIColor(red: 0.671, green: 0.737, blue: 0.918, alpha: 1).cgColor
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(imageView)
        
        //self.contentView.layer.cornerRadius = 10
        
        let constraints = [
            
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            imageView.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    /*override func layoutIfNeeded() {
        super.layoutIfNeeded()
        
        imageView.layer.cornerRadius = imageView.frame.size.width/2
    }*/
    
    required init?( coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
