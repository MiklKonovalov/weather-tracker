//
//  TimeDayCollectionViewCell.swift
//  Weather tracker
//
//  Created by Misha on 17.01.2022.
//

import Foundation
import UIKit

class TimeDayWeatherScreenCell: UICollectionViewCell {
    
    var timeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Rubik-Regular", size: 12)
        label.textColor = UIColor.black
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(timeLabel)
        
        self.contentView.backgroundColor = UIColor(red: 0.914, green: 0.933, blue: 0.98, alpha: 1)
        
        let constraints = [
            
            timeLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            timeLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            timeLabel.heightAnchor.constraint(equalToConstant: 30),
            timeLabel.widthAnchor.constraint(equalToConstant:contentView.frame.width),
        
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
