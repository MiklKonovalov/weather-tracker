//
//  DayWeekWeatherScreenCell.swift
//  Weather tracker
//
//  Created by Misha on 21.01.2022.
//

import Foundation
import UIKit

class DateWeekWeatherScreenCell: UICollectionViewCell {
    
    var dateLabel: UILabel = {
        let dateLabel = UILabel()
        dateLabel.font = UIFont(name: "Rubik-Medium", size: 18)
        dateLabel.textColor = .black
        dateLabel.lineBreakMode = .byWordWrapping
        dateLabel.textAlignment = .center
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        return dateLabel
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(dateLabel)
        
        self.contentView.layer.cornerRadius = 5
        
        let constraints = [
            
            dateLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            dateLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            dateLabel.heightAnchor.constraint(equalToConstant: contentView.frame.height),
            dateLabel.widthAnchor.constraint(equalToConstant:contentView.frame.width),
        
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
