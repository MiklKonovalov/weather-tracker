//
//  WeekCityWeatherViewController.swift
//  Weather tracker
//
//  Created by Misha on 15.01.2022.
//

import Foundation
import UIKit
import Kingfisher

class WeekCityWeatherViewController: UIViewController {
    
    //MARK: -Properties
    let viewModel: GeneralViewModel
    
    var currentIndex: Int
    
    var selectedIndex = Int()
    
    private var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = .white
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    //Arrow Button
    var arrowButton: UIButton = {
        let arrowButton = UIButton()
        arrowButton.addTarget(self, action: #selector(arrowButtonTap), for: .touchUpInside)
        arrowButton.setImage(#imageLiteral(resourceName: "leftarrow"), for: .normal)
        arrowButton.translatesAutoresizingMaskIntoConstraints = false
        return arrowButton
    }()
    
    //Title of controller
    var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.font = UIFont(name: "Rubik-Regular", size: 16)
        titleLabel.textColor = UIColor(red: 0.604, green: 0.587, blue: 0.587, alpha: 1)
        titleLabel.text = "Прогноз на 24 часа"
        titleLabel.lineBreakMode = .byWordWrapping
        titleLabel.textAlignment = .left
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        return titleLabel
    }()
    
    //CityLabel
    var cityLabel: UILabel = {
        let cityLabel = UILabel()
        cityLabel.font = UIFont(name: "Rubik-Medium", size: 18)
        cityLabel.textColor = .black
        cityLabel.lineBreakMode = .byWordWrapping
        cityLabel.textAlignment = .left
        cityLabel.translatesAutoresizingMaskIntoConstraints = false
        return cityLabel
    }()
    
    var dayButton: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(arrowButtonTap), for: .touchUpInside)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .white
        button.layer.cornerRadius = 10
        button.layer.borderWidth = 3
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    var dateCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(DateWeekWeatherScreenCell.self, forCellWithReuseIdentifier: "dateCell")
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = UIColor.white
        collectionView.layer.cornerRadius = 5
        return collectionView
    }()
    
    var topView: UIView = {
        let greyView = UIView()
        greyView.backgroundColor = UIColor(red: 0.914, green: 0.933, blue: 0.98, alpha: 1)
        greyView.layer.cornerRadius = 10
        greyView.translatesAutoresizingMaskIntoConstraints = false
        return greyView
    }()
    
    var bottomView: UIView = {
        let greyView = UIView()
        greyView.backgroundColor = UIColor(red: 0.914, green: 0.933, blue: 0.98, alpha: 1)
        greyView.layer.cornerRadius = 10
        greyView.translatesAutoresizingMaskIntoConstraints = false
        return greyView
    }()
    
    var sunAndMoonView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white.withAlphaComponent(0)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var tempLabel: UILabel = {
        let tempLabel = UILabel()
        tempLabel.font = UIFont(name: "Rubik-Medium", size: 30)
        tempLabel.textColor = .black
        tempLabel.lineBreakMode = .byWordWrapping
        tempLabel.textAlignment = .left
        tempLabel.font = UIFont.boldSystemFont(ofSize: 30)
        tempLabel.translatesAutoresizingMaskIntoConstraints = false
        return tempLabel
    }()
    
    var imageView: UIImageView = {
        let image = UIImageView()
        image.isUserInteractionEnabled = true
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    var dayLabel: UILabel = {
        let dayLabel = UILabel()
        dayLabel.font = UIFont(name: "Rubik-Medium", size: 30)
        dayLabel.textColor = .black
        dayLabel.lineBreakMode = .byWordWrapping
        dayLabel.textAlignment = .left
        dayLabel.text = "День"
        dayLabel.font = UIFont.systemFont(ofSize: 25)
        dayLabel.translatesAutoresizingMaskIntoConstraints = false
        return dayLabel
    }()
    
    var weatherDescriptionLabel: UILabel = {
        let weatherDescriptionLabel = UILabel()
        weatherDescriptionLabel.font = UIFont(name: "Rubik-Medium", size: 30)
        weatherDescriptionLabel.textColor = .black
        weatherDescriptionLabel.lineBreakMode = .byWordWrapping
        weatherDescriptionLabel.textAlignment = .center
        weatherDescriptionLabel.font = UIFont.boldSystemFont(ofSize: 25)
        weatherDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        return weatherDescriptionLabel
    }()
    
    var feelsImageView: UIImageView = {
        let image = UIImageView()
        image.isUserInteractionEnabled = true
        image.image = #imageLiteral(resourceName: "ощущается")
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    var windImageView: UIImageView = {
        let image = UIImageView()
        image.isUserInteractionEnabled = true
        image.image = #imageLiteral(resourceName: "wind")
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    var ufIndexImageView: UIImageView = {
        let image = UIImageView()
        image.isUserInteractionEnabled = true
        image.image = #imageLiteral(resourceName: "солнце")
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    var rainImageView: UIImageView = {
        let image = UIImageView()
        image.isUserInteractionEnabled = true
        image.image = #imageLiteral(resourceName: "rain")
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    var cloudsImageView: UIImageView = {
        let image = UIImageView()
        image.isUserInteractionEnabled = true
        image.image = #imageLiteral(resourceName: "cloud")
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    var feelsLikeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Rubik-Regular", size: 14)
        label.textColor = .black
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .left
        label.text = "По ощущениям"
        label.font = UIFont.systemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var windLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Rubik-Regular", size: 14)
        label.textColor = .black
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .left
        label.text = "Ветер"
        label.font = UIFont.systemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var ufIndexLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Rubik-Regular", size: 14)
        label.textColor = .black
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .left
        label.text = "УФ-индекс"
        label.font = UIFont.systemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var rainLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Rubik-Regular", size: 14)
        label.textColor = .black
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .left
        label.text = "Дождь"
        label.font = UIFont.systemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var cloudsLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Rubik-Regular", size: 14)
        label.textColor = .black
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .left
        label.text = "Облачность"
        label.font = UIFont.systemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var feelsLikeValueLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Rubik-Regular", size: 18)
        label.textColor = .black
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var windValueLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Rubik-Regular", size: 18)
        label.textColor = .black
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var ufIndexValueLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Rubik-Regular", size: 18)
        label.textColor = .black
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var rainValueLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Rubik-Regular", size: 18)
        label.textColor = .black
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var cloudsValueLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Rubik-Regular", size: 18)
        label.textColor = .black
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var tempLabelBottom: UILabel = {
        let tempLabel = UILabel()
        tempLabel.font = UIFont(name: "Rubik-Medium", size: 30)
        tempLabel.textColor = .black
        tempLabel.lineBreakMode = .byWordWrapping
        tempLabel.textAlignment = .left
        tempLabel.font = UIFont.boldSystemFont(ofSize: 30)
        tempLabel.translatesAutoresizingMaskIntoConstraints = false
        return tempLabel
    }()
    
    var imageViewBottom: UIImageView = {
        let image = UIImageView()
        image.isUserInteractionEnabled = true
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    var dayLabelBottom: UILabel = {
        let dayLabel = UILabel()
        dayLabel.font = UIFont(name: "Rubik-Medium", size: 30)
        dayLabel.textColor = .black
        dayLabel.lineBreakMode = .byWordWrapping
        dayLabel.textAlignment = .left
        dayLabel.text = "Ночь"
        dayLabel.font = UIFont.systemFont(ofSize: 25)
        dayLabel.translatesAutoresizingMaskIntoConstraints = false
        return dayLabel
    }()
    
    var weatherDescriptionLabelBottom: UILabel = {
        let weatherDescriptionLabel = UILabel()
        weatherDescriptionLabel.font = UIFont(name: "Rubik-Medium", size: 30)
        weatherDescriptionLabel.textColor = .black
        weatherDescriptionLabel.lineBreakMode = .byWordWrapping
        weatherDescriptionLabel.textAlignment = .center
        weatherDescriptionLabel.font = UIFont.boldSystemFont(ofSize: 25)
        weatherDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        return weatherDescriptionLabel
    }()
    
    var feelsImageViewBottom: UIImageView = {
        let image = UIImageView()
        image.isUserInteractionEnabled = true
        image.image = #imageLiteral(resourceName: "ощущается")
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    var windImageViewBottom: UIImageView = {
        let image = UIImageView()
        image.isUserInteractionEnabled = true
        image.image = #imageLiteral(resourceName: "wind")
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    var ufIndexImageViewBottom: UIImageView = {
        let image = UIImageView()
        image.isUserInteractionEnabled = true
        image.image = #imageLiteral(resourceName: "солнце")
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    var rainImageViewBottom: UIImageView = {
        let image = UIImageView()
        image.isUserInteractionEnabled = true
        image.image = #imageLiteral(resourceName: "rain")
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    var cloudsImageViewBottom: UIImageView = {
        let image = UIImageView()
        image.isUserInteractionEnabled = true
        image.image = #imageLiteral(resourceName: "cloud")
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    var feelsLikeLabelBottom: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Rubik-Regular", size: 14)
        label.textColor = .black
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .left
        label.text = "По ощущениям"
        label.font = UIFont.systemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var windLabelBottom: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Rubik-Regular", size: 14)
        label.textColor = .black
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .left
        label.text = "Ветер"
        label.font = UIFont.systemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var ufIndexLabelBottom: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Rubik-Regular", size: 14)
        label.textColor = .black
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .left
        label.text = "УФ-индекс"
        label.font = UIFont.systemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var rainLabelBottom: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Rubik-Regular", size: 14)
        label.textColor = .black
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .left
        label.text = "Дождь"
        label.font = UIFont.systemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var cloudsLabelBottom: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Rubik-Regular", size: 14)
        label.textColor = .black
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .left
        label.text = "Облачность"
        label.font = UIFont.systemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var feelsLikeValueLabelBottom: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Rubik-Regular", size: 18)
        label.textColor = .black
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var windValueLabelBottom: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Rubik-Regular", size: 18)
        label.textColor = .black
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var ufIndexValueLabelBottom: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Rubik-Regular", size: 18)
        label.textColor = .black
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var rainValueLabelBottom: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Rubik-Regular", size: 18)
        label.textColor = .black
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var cloudsValueLabelBottom: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Rubik-Regular", size: 18)
        label.textColor = .black
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var sunAndMoonLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Rubik-Regular", size: 18)
        label.textColor = .black
        label.text = "Солнце и Луна"
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var moonPhaseLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Rubik-Regular", size: 14)
        label.textColor = .black
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var sunImageView: UIImageView = {
        let image = UIImageView()
        image.isUserInteractionEnabled = true
        image.image = #imageLiteral(resourceName: "солнце")
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    var moonImageView: UIImageView = {
        let image = UIImageView()
        image.isUserInteractionEnabled = true
        image.image = UIImage(named: "moon")
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    var sunLabelValue: UIImageView = {
        let image = UIImageView()
        image.isUserInteractionEnabled = true
        image.image = #imageLiteral(resourceName: "солнце")
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    var sunRiseLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Rubik-Regular", size: 14)
        label.textColor = .gray
        label.text = "Восход"
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var sunSetLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Rubik-Regular", size: 14)
        label.textColor = .gray
        label.text = "Закат"
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var moonRiseLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Rubik-Regular", size: 14)
        label.textColor = .gray
        label.text = "Восход"
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var moonSetLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Rubik-Regular", size: 14)
        label.textColor = .gray
        label.text = "Закат"
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var sunRiseValueLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Rubik-Regular", size: 14)
        label.textColor = .black
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var sunSetValueLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Rubik-Regular", size: 14)
        label.textColor = .black
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var moonRiseValueLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Rubik-Regular", size: 14)
        label.textColor = .black
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var moonSetValueLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Rubik-Regular", size: 14)
        label.textColor = .black
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var sunSetAndSunRiseLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Rubik-Regular", size: 16)
        label.textColor = .black
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var moonSetAndSunRiseLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Rubik-Regular", size: 16)
        label.textColor = .black
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let lineOneView = LineOneView()
    
    let lineBottomView = LineBottomView()
    
    let dottedLineView = DottedLineView()
     
    //MARK: -Initializations
    init(viewModel: GeneralViewModel, currentIndex: Int) {
        self.viewModel = viewModel
        self.currentIndex = currentIndex
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: -Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        view.addSubview(scrollView)
        scrollView.addSubview(containerView)
        containerView.addSubview(topView)
        containerView.addSubview(bottomView)
        containerView.addSubview(sunAndMoonView)
        containerView.addSubview(arrowButton)
        containerView.addSubview(titleLabel)
        containerView.addSubview(cityLabel)
        containerView.addSubview(dateCollectionView)
        containerView.addSubview(tempLabel)
        containerView.addSubview(imageView)
        containerView.addSubview(weatherDescriptionLabel)
        containerView.addSubview(dayLabel)
        containerView.addSubview(feelsImageView)
        containerView.addSubview(windImageView)
        containerView.addSubview(ufIndexImageView)
        containerView.addSubview(rainImageView)
        containerView.addSubview(cloudsImageView)
        containerView.addSubview(feelsLikeLabel)
        containerView.addSubview(windLabel)
        containerView.addSubview(ufIndexLabel)
        containerView.addSubview(rainLabel)
        containerView.addSubview(cloudsLabel)
        containerView.addSubview(feelsLikeValueLabel)
        containerView.addSubview(windValueLabel)
        containerView.addSubview(ufIndexValueLabel)
        containerView.addSubview(rainValueLabel)
        containerView.addSubview(cloudsValueLabel)
        containerView.addSubview(tempLabelBottom)
        containerView.addSubview(imageViewBottom)
        containerView.addSubview(weatherDescriptionLabelBottom)
        containerView.addSubview(dayLabelBottom)
        containerView.addSubview(feelsImageViewBottom)
        containerView.addSubview(windImageViewBottom)
        containerView.addSubview(ufIndexImageViewBottom)
        containerView.addSubview(rainImageViewBottom)
        containerView.addSubview(cloudsImageViewBottom)
        containerView.addSubview(feelsLikeLabelBottom)
        containerView.addSubview(windLabelBottom)
        containerView.addSubview(ufIndexLabelBottom)
        containerView.addSubview(rainLabelBottom)
        containerView.addSubview(cloudsLabelBottom)
        containerView.addSubview(feelsLikeValueLabelBottom)
        containerView.addSubview(windValueLabelBottom)
        containerView.addSubview(ufIndexValueLabelBottom)
        containerView.addSubview(rainValueLabelBottom)
        containerView.addSubview(cloudsValueLabelBottom)
        containerView.addSubview(lineOneView)
        containerView.addSubview(lineBottomView)
        containerView.addSubview(dottedLineView)
        sunAndMoonView.addSubview(sunAndMoonLabel)
        sunAndMoonView.addSubview(moonPhaseLabel)
        sunAndMoonView.addSubview(sunImageView)
        sunAndMoonView.addSubview(moonImageView)
        sunAndMoonView.addSubview(sunRiseLabel)
        sunAndMoonView.addSubview(sunSetLabel)
        sunAndMoonView.addSubview(moonRiseLabel)
        sunAndMoonView.addSubview(moonSetLabel)
        sunAndMoonView.addSubview(sunRiseValueLabel)
        sunAndMoonView.addSubview(sunSetValueLabel)
        sunAndMoonView.addSubview(sunSetAndSunRiseLabel)
        sunAndMoonView.addSubview(moonSetAndSunRiseLabel)
        sunAndMoonView.addSubview(moonSetValueLabel)
        sunAndMoonView.addSubview(moonRiseValueLabel)
        
        dateCollectionView.dataSource = self
        dateCollectionView.delegate = self
        
        setupConstraints()
        cityLabelTextSetup()
        setupNavBar()
        
        lineOneView.backgroundColor = UIColor.white.withAlphaComponent(0)
        lineOneView.translatesAutoresizingMaskIntoConstraints = false
        
        lineBottomView.backgroundColor = UIColor.white.withAlphaComponent(0)
        lineBottomView.translatesAutoresizingMaskIntoConstraints = false
        
        dottedLineView.backgroundColor = UIColor.white.withAlphaComponent(0)
        dottedLineView.translatesAutoresizingMaskIntoConstraints = false
        
    //MARK: -TopView
        
        //MARK: -Temp
        if let maxTemp = viewModel.weather[currentIndex].week.daily[0].temp.max {
            tempLabel.text = String(format: "%.0f", maxTemp) + " " + "°"
        }

        //MARK: -Icon
        if currentIndex > viewModel.weather.startIndex || currentIndex < viewModel.weather.endIndex {
            if let icon = viewModel.weather[currentIndex].week.daily[selectedIndex].weather[0].icon {
                let urlStr = "http://openweathermap.org/img/w/" + (icon) + ".png"
                    let url = URL(string: urlStr)
                    imageView.kf.setImage(with: url) { result in
                        self.imageView.setNeedsLayout()
                    }
                }
        } else {
            if currentIndex > viewModel.weather.startIndex || currentIndex < viewModel.weather.endIndex {
                if let icon = viewModel.weather.first?.week.daily[selectedIndex].weather[0].icon {
                    let urlStr = "http://openweathermap.org/img/w/" + (icon) + ".png"
                        let url = URL(string: urlStr)
                        imageView.kf.setImage(with: url) { result in
                            self.imageView.setNeedsLayout()
                        }
                    }
            }
        }

        //MARK: -Description
        if let description = viewModel.weather[currentIndex].now.weather?[selectedIndex].description {
            weatherDescriptionLabel.text = description
        }
        
        //MARK: -Day feels like
        let dayFeelsLike = viewModel.weather[currentIndex].week.daily[selectedIndex].feelsLike.day
            feelsLikeValueLabel.text = String(format: "%.0f", dayFeelsLike) + " " + "°"
        
        //MARK: -Wind
        let wind = viewModel.weather[currentIndex].week.daily[selectedIndex].windSpeed
            windValueLabel.text = String(format: "%.0f", wind) + " " + "м/с"
        
        let ufIndex = viewModel.weather[currentIndex].week.daily[selectedIndex].uvi
            ufIndexValueLabel.text = String(format: "%.0f", ufIndex)
        
        //MARK: -Rain
        let rain = viewModel.weather[currentIndex].week.daily[selectedIndex].rain
        rainValueLabel.text = String(format: "%.0f", rain ?? 0) + " " + "%"
        
        //MARK: -Clouds
        let cloud = viewModel.weather[currentIndex].week.daily[selectedIndex].clouds
        cloudsValueLabel.text = String(format: "%.0f", cloud) + " " + "%"
        
        //MARK: -BottomView
            
            //MARK: -Temp
        if let maxTemp = viewModel.weather[currentIndex].week.daily[0].temp.night {
                tempLabelBottom.text = String(format: "%.0f", maxTemp) + " " + "°"
            }

            //MARK: -Icon
            if currentIndex > viewModel.weather.startIndex || currentIndex < viewModel.weather.endIndex {
                if let icon = viewModel.weather[currentIndex].week.daily[selectedIndex].weather[0].icon {
                    let urlStr = "http://openweathermap.org/img/w/" + (icon) + ".png"
                        let url = URL(string: urlStr)
                        imageViewBottom.kf.setImage(with: url) { result in
                            self.imageView.setNeedsLayout()
                        }
                    }
            } else {
                if currentIndex > viewModel.weather.startIndex || currentIndex < viewModel.weather.endIndex {
                    if let icon = viewModel.weather.first?.week.daily[selectedIndex].weather[0].icon {
                        let urlStr = "http://openweathermap.org/img/w/" + (icon) + ".png"
                            let url = URL(string: urlStr)
                            imageViewBottom.kf.setImage(with: url) { result in
                                self.imageView.setNeedsLayout()
                            }
                        }
                }
            }

            //MARK: -Description
            if let description = viewModel.weather[currentIndex].now.weather?[selectedIndex].description {
                weatherDescriptionLabelBottom.text = description
            }
            
            //MARK: -Day feels like
            let dayFeelsLikeBottom = viewModel.weather[currentIndex].week.daily[selectedIndex].feelsLike.night
                feelsLikeValueLabelBottom.text = String(format: "%.0f", dayFeelsLikeBottom) + " " + "°"
            
            //MARK: -Wind
            let windBottom = viewModel.weather[currentIndex].week.daily[selectedIndex].windSpeed
                windValueLabelBottom.text = String(format: "%.0f", windBottom) + " " + "м/с"
            
            let ufIndexBottom = viewModel.weather[currentIndex].week.daily[selectedIndex].uvi
                ufIndexValueLabelBottom.text = String(format: "%.0f", ufIndexBottom)
            
            //MARK: -Rain
            let rainBottom = viewModel.weather[currentIndex].week.daily[selectedIndex].rain
            rainValueLabelBottom.text = String(format: "%.0f", rainBottom ?? 0) + " " + "%"
            
            //MARK: -Clouds
            let cloudBottom = viewModel.weather[currentIndex].week.daily[selectedIndex].clouds
            cloudsValueLabelBottom.text = String(format: "%.0f", cloudBottom) + " " + "%"
        
        //MARK: -Moon phase
        
        let moonPhase = viewModel.weather[currentIndex].week.daily[selectedIndex].moonPhase
        
        moonPhaseLabel.text = getMoonPhaseStatus(moonPhase: moonPhase)
        
        //MARK: -Sunrise
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        dateFormatter.locale = Locale(identifier: "ru_RU")
        
        let sunRise = viewModel.weather[currentIndex].week.daily[selectedIndex].sunrise
        
        let dateDateSunRise = Date(miliseconds: Int64(sunRise))
        
        let dateFormatter2 = DateFormatter()
        dateFormatter2.dateFormat = "HH:mm"
        dateFormatter2.locale = Locale(identifier: "ru_RU")
    
        let dateSunRiseString = dateFormatter2.string(from: dateDateSunRise)
        
        sunRiseValueLabel.text = "\(dateSunRiseString)"
        
        //MARK: -Sunset
        
        let sunSet = viewModel.weather[currentIndex].week.daily[selectedIndex].sunset
        print(sunSet)

        let dateDateSunSet = Date(miliseconds: Int64(sunSet))
        
        let dateFormatter3 = DateFormatter()
        dateFormatter3.dateFormat = "HH:mm"
        dateFormatter3.locale = Locale(identifier: "ru_RU")
        
        let dateSunSetString = dateFormatter2.string(from: dateDateSunSet)
            
        sunSetValueLabel.text = "\(dateSunSetString)"
        
        //MARK: -Difference between sunrise and sunset
        
        let splitsSunRise = dateSunRiseString.split(separator: ":").map(String.init)
        let hourSunRise = ((splitsSunRise[0]) as NSString).intValue
        let minutesSunRise = ((splitsSunRise[1]) as NSString).intValue
        
        let splitsSunSet = dateSunSetString.split(separator: ":").map(String.init)
        let hourSunSet = ((splitsSunSet[0]) as NSString).intValue
        let minutesSunSet = ((splitsSunSet[1]) as NSString).intValue
        
        let hourDifference = hourSunSet - hourSunRise
        let minutesDifference = minutesSunSet - minutesSunRise
        
        sunSetAndSunRiseLabel.text = "\(hourDifference) ч" + " " + "\(minutesDifference) мин"
        
        //MARK: -Moonrise
        
        let moonRise = viewModel.weather[currentIndex].week.daily[selectedIndex].moonset
        
        let dateDateMoonRise = Date(miliseconds: Int64(moonRise))
    
        let dateMoonRiseString = dateFormatter2.string(from: dateDateMoonRise)
        
        moonRiseValueLabel.text = "\(dateMoonRiseString)"
        
        //MARK: -Moonset
        
        let moonSet = viewModel.weather[currentIndex].week.daily[selectedIndex].moonrise

        let dateDateMoonSet = Date(miliseconds: Int64(moonSet))
        
        let dateMoonSetString = dateFormatter2.string(from: dateDateMoonSet)
            
        moonSetValueLabel.text = "\(dateMoonSetString)"
        
        //MARK: -Difference between sunrise and sunset
        
        let splitsMoonRise = dateMoonRiseString.split(separator: ":").map(String.init)
        let hourMoonRise = ((splitsMoonRise[0]) as NSString).intValue
        let minutesMoonRise = ((splitsMoonRise[1]) as NSString).intValue
        
        let splitsMoonSet = dateMoonSetString.split(separator: ":").map(String.init)
        let hourMoonSet = ((splitsMoonSet[0]) as NSString).intValue
        let minutesMoonSet = ((splitsMoonSet[1]) as NSString).intValue
        
        let hourMoonDifference = hourMoonRise - hourMoonSet
        let minutesMoonDifference = minutesMoonRise - minutesMoonSet
        
        moonSetAndSunRiseLabel.text = "\(hourMoonDifference) ч" + " " + "\(minutesMoonDifference) мин"
    }
    
    //MARK: -Selectors
    @objc func arrowButtonTap() {
        navigationController?.dismiss(animated: true, completion: nil)
    }
    
    //MARK: -Functions
    
    func setupNavBar() {
        
        self.navigationController!.navigationBar.isHidden = true
    }

    func setupConstraints() {
        
        
        
        let constraints = [
            
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            containerView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            containerView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            containerView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            arrowButton.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 41),
            arrowButton.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 10),
            arrowButton.widthAnchor.constraint(equalToConstant: 20),
            arrowButton.heightAnchor.constraint(equalToConstant: 18),
        
            titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 41),
            titleLabel.leadingAnchor.constraint(equalTo: arrowButton.trailingAnchor, constant: 10),
            titleLabel.heightAnchor.constraint(equalToConstant: 20),
            titleLabel.widthAnchor.constraint(equalToConstant: 200),
        
            cityLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            cityLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor, constant: 0),
            cityLabel.heightAnchor.constraint(equalToConstant: 20),
            cityLabel.widthAnchor.constraint(equalToConstant: 200),
            
            dateCollectionView.topAnchor.constraint(equalTo: cityLabel.bottomAnchor, constant: 20),
            dateCollectionView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            dateCollectionView.widthAnchor.constraint(equalTo: containerView.widthAnchor, multiplier: 0.95),
            dateCollectionView.heightAnchor.constraint(equalToConstant: 50),
            
            topView.topAnchor.constraint(equalTo: dateCollectionView.bottomAnchor, constant: 20),
            topView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            topView.widthAnchor.constraint(equalTo: containerView.widthAnchor, multiplier: 0.9),
            topView.heightAnchor.constraint(equalToConstant: 400),
            
            bottomView.topAnchor.constraint(equalTo: topView.bottomAnchor, constant: 2),
            bottomView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            bottomView.widthAnchor.constraint(equalTo: containerView.widthAnchor, multiplier: 0.9),
            bottomView.heightAnchor.constraint(equalToConstant: 400),
            
            tempLabel.topAnchor.constraint(equalTo: topView.topAnchor, constant: 20),
            tempLabel.centerXAnchor.constraint(equalTo: topView.centerXAnchor, constant: 20),
            tempLabel.widthAnchor.constraint(equalToConstant: 60),
            tempLabel.heightAnchor.constraint(equalToConstant: 50),
            
            imageView.topAnchor.constraint(equalTo: tempLabel.topAnchor),
            imageView.trailingAnchor.constraint(equalTo: tempLabel.leadingAnchor, constant: -10),
            imageView.widthAnchor.constraint(equalToConstant: 50),
            imageView.heightAnchor.constraint(equalToConstant: 50),
            
            dayLabel.topAnchor.constraint(equalTo: topView.topAnchor, constant: 20),
            dayLabel.leadingAnchor.constraint(equalTo: topView.leadingAnchor, constant: 20),
            dayLabel.widthAnchor.constraint(equalToConstant: 70),
            dayLabel.heightAnchor.constraint(equalToConstant: 30),
            
            weatherDescriptionLabel.topAnchor.constraint(equalTo: tempLabel.bottomAnchor, constant: 15),
            weatherDescriptionLabel.centerXAnchor.constraint(equalTo: topView.centerXAnchor),
            weatherDescriptionLabel.widthAnchor.constraint(equalToConstant: 300),
            weatherDescriptionLabel.heightAnchor.constraint(equalToConstant: 30),
            
            feelsImageView.topAnchor.constraint(equalTo: weatherDescriptionLabel.bottomAnchor, constant: 15),
            feelsImageView.trailingAnchor.constraint(equalTo: feelsLikeLabel.leadingAnchor, constant: -30),
            feelsImageView.widthAnchor.constraint(equalToConstant: 30),
            feelsImageView.heightAnchor.constraint(equalToConstant: 30),
            
            windImageView.topAnchor.constraint(equalTo: feelsImageView.bottomAnchor, constant: 15),
            windImageView.trailingAnchor.constraint(equalTo: windLabel.leadingAnchor, constant: -30),
            windImageView.widthAnchor.constraint(equalToConstant: 30),
            windImageView.heightAnchor.constraint(equalToConstant: 30),
            
            ufIndexImageView.topAnchor.constraint(equalTo: windImageView.bottomAnchor, constant: 15),
            ufIndexImageView.trailingAnchor.constraint(equalTo: ufIndexLabel.leadingAnchor, constant: -30),
            ufIndexImageView.widthAnchor.constraint(equalToConstant: 30),
            ufIndexImageView.heightAnchor.constraint(equalToConstant: 30),
            
            rainImageView.topAnchor.constraint(equalTo: ufIndexImageView.bottomAnchor, constant: 15),
            rainImageView.trailingAnchor.constraint(equalTo: rainLabel.leadingAnchor, constant: -30),
            rainImageView.widthAnchor.constraint(equalToConstant: 30),
            rainImageView.heightAnchor.constraint(equalToConstant: 30),
            
            cloudsImageView.topAnchor.constraint(equalTo: rainImageView.bottomAnchor, constant: 15),
            cloudsImageView.trailingAnchor.constraint(equalTo: cloudsLabel.leadingAnchor, constant: -30),
            cloudsImageView.widthAnchor.constraint(equalToConstant: 30),
            cloudsImageView.heightAnchor.constraint(equalToConstant: 30),
            
            feelsLikeLabel.topAnchor.constraint(equalTo: feelsImageView.topAnchor),
            feelsLikeLabel.centerXAnchor.constraint(equalTo: topView.centerXAnchor),
            feelsLikeLabel.widthAnchor.constraint(equalToConstant: 150),
            feelsLikeLabel.heightAnchor.constraint(equalToConstant: 30),
            
            windLabel.topAnchor.constraint(equalTo: windImageView.topAnchor),
            windLabel.centerXAnchor.constraint(equalTo: topView.centerXAnchor),
            windLabel.widthAnchor.constraint(equalToConstant: 150),
            windLabel.heightAnchor.constraint(equalToConstant: 30),
            
            ufIndexLabel.topAnchor.constraint(equalTo: ufIndexImageView.topAnchor),
            ufIndexLabel.centerXAnchor.constraint(equalTo: topView.centerXAnchor),
            ufIndexLabel.widthAnchor.constraint(equalToConstant: 150),
            ufIndexLabel.heightAnchor.constraint(equalToConstant: 30),
            
            rainLabel.topAnchor.constraint(equalTo: rainImageView.topAnchor),
            rainLabel.centerXAnchor.constraint(equalTo: topView.centerXAnchor),
            rainLabel.widthAnchor.constraint(equalToConstant: 150),
            rainLabel.heightAnchor.constraint(equalToConstant: 30),
            
            cloudsLabel.topAnchor.constraint(equalTo: cloudsImageView.topAnchor),
            cloudsLabel.centerXAnchor.constraint(equalTo: topView.centerXAnchor),
            cloudsLabel.widthAnchor.constraint(equalToConstant: 150),
            cloudsLabel.heightAnchor.constraint(equalToConstant: 30),
            
            feelsLikeValueLabel.topAnchor.constraint(equalTo: feelsLikeLabel.topAnchor),
            feelsLikeValueLabel.leadingAnchor.constraint(equalTo: feelsLikeLabel.trailingAnchor, constant: 30),
            feelsLikeValueLabel.trailingAnchor.constraint(equalTo: topView.trailingAnchor),
            feelsLikeValueLabel.heightAnchor.constraint(equalToConstant: 30),
            
            windValueLabel.topAnchor.constraint(equalTo: windLabel.topAnchor),
            windValueLabel.leadingAnchor.constraint(equalTo: windLabel.trailingAnchor, constant: 30),
            windValueLabel.trailingAnchor.constraint(equalTo: topView.trailingAnchor),
            windValueLabel.heightAnchor.constraint(equalToConstant: 30),
            
            ufIndexValueLabel.topAnchor.constraint(equalTo: ufIndexLabel.topAnchor),
            ufIndexValueLabel.leadingAnchor.constraint(equalTo: ufIndexLabel.trailingAnchor, constant: 30),
            ufIndexValueLabel.trailingAnchor.constraint(equalTo: topView.trailingAnchor),
            ufIndexValueLabel.heightAnchor.constraint(equalToConstant: 30),
            
            rainValueLabel.topAnchor.constraint(equalTo: rainLabel.topAnchor),
            rainValueLabel.leadingAnchor.constraint(equalTo: rainLabel.trailingAnchor, constant: 30),
            rainValueLabel.trailingAnchor.constraint(equalTo: topView.trailingAnchor),
            rainValueLabel.heightAnchor.constraint(equalToConstant: 30),
            
            cloudsValueLabel.topAnchor.constraint(equalTo: cloudsLabel.topAnchor),
            cloudsValueLabel.leadingAnchor.constraint(equalTo: cloudsLabel.trailingAnchor, constant: 30),
            cloudsValueLabel.trailingAnchor.constraint(equalTo: topView.trailingAnchor),
            cloudsValueLabel.heightAnchor.constraint(equalToConstant: 30),
            
            tempLabelBottom.topAnchor.constraint(equalTo: bottomView.topAnchor, constant: 20),
            tempLabelBottom.centerXAnchor.constraint(equalTo: bottomView.centerXAnchor, constant: 20),
            tempLabelBottom.widthAnchor.constraint(equalToConstant: 60),
            tempLabelBottom.heightAnchor.constraint(equalToConstant: 50),
            
            imageViewBottom.topAnchor.constraint(equalTo: tempLabelBottom.topAnchor),
            imageViewBottom.trailingAnchor.constraint(equalTo: tempLabelBottom.leadingAnchor, constant: -10),
            imageViewBottom.widthAnchor.constraint(equalToConstant: 50),
            imageViewBottom.heightAnchor.constraint(equalToConstant: 50),
            
            dayLabelBottom.topAnchor.constraint(equalTo: bottomView.topAnchor, constant: 20),
            dayLabelBottom.leadingAnchor.constraint(equalTo: bottomView.leadingAnchor, constant: 20),
            dayLabelBottom.widthAnchor.constraint(equalToConstant: 70),
            dayLabelBottom.heightAnchor.constraint(equalToConstant: 30),
            
            weatherDescriptionLabelBottom.topAnchor.constraint(equalTo: tempLabelBottom.bottomAnchor, constant: 15),
            weatherDescriptionLabelBottom.centerXAnchor.constraint(equalTo: bottomView.centerXAnchor),
            weatherDescriptionLabelBottom.widthAnchor.constraint(equalToConstant: 300),
            weatherDescriptionLabelBottom.heightAnchor.constraint(equalToConstant: 30),
            
            feelsImageViewBottom.topAnchor.constraint(equalTo: weatherDescriptionLabelBottom.bottomAnchor, constant: 15),
            feelsImageViewBottom.trailingAnchor.constraint(equalTo: feelsLikeLabelBottom.leadingAnchor, constant: -30),
            feelsImageViewBottom.widthAnchor.constraint(equalToConstant: 30),
            feelsImageViewBottom.heightAnchor.constraint(equalToConstant: 30),
            
            windImageViewBottom.topAnchor.constraint(equalTo: feelsImageViewBottom.bottomAnchor, constant: 15),
            windImageViewBottom.trailingAnchor.constraint(equalTo: windLabelBottom.leadingAnchor, constant: -30),
            windImageViewBottom.widthAnchor.constraint(equalToConstant: 30),
            windImageViewBottom.heightAnchor.constraint(equalToConstant: 30),
            
            ufIndexImageViewBottom.topAnchor.constraint(equalTo: windImageViewBottom.bottomAnchor, constant: 15),
            ufIndexImageViewBottom.trailingAnchor.constraint(equalTo: ufIndexLabelBottom.leadingAnchor, constant: -30),
            ufIndexImageViewBottom.widthAnchor.constraint(equalToConstant: 30),
            ufIndexImageViewBottom.heightAnchor.constraint(equalToConstant: 30),
            
            rainImageViewBottom.topAnchor.constraint(equalTo: ufIndexImageViewBottom.bottomAnchor, constant: 15),
            rainImageViewBottom.trailingAnchor.constraint(equalTo: rainLabelBottom.leadingAnchor, constant: -30),
            rainImageViewBottom.widthAnchor.constraint(equalToConstant: 30),
            rainImageViewBottom.heightAnchor.constraint(equalToConstant: 30),
            
            cloudsImageViewBottom.topAnchor.constraint(equalTo: rainImageViewBottom.bottomAnchor, constant: 15),
            cloudsImageViewBottom.trailingAnchor.constraint(equalTo: cloudsLabelBottom.leadingAnchor, constant: -30),
            cloudsImageViewBottom.widthAnchor.constraint(equalToConstant: 30),
            cloudsImageViewBottom.heightAnchor.constraint(equalToConstant: 30),
            
            feelsLikeLabelBottom.topAnchor.constraint(equalTo: feelsImageViewBottom.topAnchor),
            feelsLikeLabelBottom.centerXAnchor.constraint(equalTo: bottomView.centerXAnchor),
            feelsLikeLabelBottom.widthAnchor.constraint(equalToConstant: 150),
            feelsLikeLabelBottom.heightAnchor.constraint(equalToConstant: 30),
            
            windLabelBottom.topAnchor.constraint(equalTo: windImageViewBottom.topAnchor),
            windLabelBottom.centerXAnchor.constraint(equalTo: bottomView.centerXAnchor),
            windLabelBottom.widthAnchor.constraint(equalToConstant: 150),
            windLabelBottom.heightAnchor.constraint(equalToConstant: 30),
            
            ufIndexLabelBottom.topAnchor.constraint(equalTo: ufIndexImageViewBottom.topAnchor),
            ufIndexLabelBottom.centerXAnchor.constraint(equalTo: bottomView.centerXAnchor),
            ufIndexLabelBottom.widthAnchor.constraint(equalToConstant: 150),
            ufIndexLabelBottom.heightAnchor.constraint(equalToConstant: 30),
            
            rainLabelBottom.topAnchor.constraint(equalTo: rainImageViewBottom.topAnchor),
            rainLabelBottom.centerXAnchor.constraint(equalTo: bottomView.centerXAnchor),
            rainLabelBottom.widthAnchor.constraint(equalToConstant: 150),
            rainLabelBottom.heightAnchor.constraint(equalToConstant: 30),
            
            cloudsLabelBottom.topAnchor.constraint(equalTo: cloudsImageViewBottom.topAnchor),
            cloudsLabelBottom.centerXAnchor.constraint(equalTo: bottomView.centerXAnchor),
            cloudsLabelBottom.widthAnchor.constraint(equalToConstant: 150),
            cloudsLabelBottom.heightAnchor.constraint(equalToConstant: 30),
            
            feelsLikeValueLabelBottom.topAnchor.constraint(equalTo: feelsLikeLabelBottom.topAnchor),
            feelsLikeValueLabelBottom.leadingAnchor.constraint(equalTo: feelsLikeLabelBottom.trailingAnchor, constant: 30),
            feelsLikeValueLabelBottom.trailingAnchor.constraint(equalTo: bottomView.trailingAnchor),
            feelsLikeValueLabelBottom.heightAnchor.constraint(equalToConstant: 30),
            
            windValueLabelBottom.topAnchor.constraint(equalTo: windLabelBottom.topAnchor),
            windValueLabelBottom.leadingAnchor.constraint(equalTo: windLabelBottom.trailingAnchor, constant: 30),
            windValueLabelBottom.trailingAnchor.constraint(equalTo: bottomView.trailingAnchor),
            windValueLabelBottom.heightAnchor.constraint(equalToConstant: 30),
            
            ufIndexValueLabelBottom.topAnchor.constraint(equalTo: ufIndexLabelBottom.topAnchor),
            ufIndexValueLabelBottom.leadingAnchor.constraint(equalTo: ufIndexLabelBottom.trailingAnchor, constant: 30),
            ufIndexValueLabelBottom.trailingAnchor.constraint(equalTo: bottomView.trailingAnchor),
            ufIndexValueLabelBottom.heightAnchor.constraint(equalToConstant: 30),
            
            rainValueLabelBottom.topAnchor.constraint(equalTo: rainLabelBottom.topAnchor),
            rainValueLabelBottom.leadingAnchor.constraint(equalTo: rainLabelBottom.trailingAnchor, constant: 30),
            rainValueLabelBottom.trailingAnchor.constraint(equalTo: bottomView.trailingAnchor),
            rainValueLabelBottom.heightAnchor.constraint(equalToConstant: 30),
            
            cloudsValueLabelBottom.topAnchor.constraint(equalTo: cloudsLabelBottom.topAnchor),
            cloudsValueLabelBottom.leadingAnchor.constraint(equalTo: cloudsLabelBottom.trailingAnchor, constant: 30),
            cloudsValueLabelBottom.trailingAnchor.constraint(equalTo: bottomView.trailingAnchor),
            cloudsValueLabelBottom.heightAnchor.constraint(equalToConstant: 30),
            
            sunAndMoonView.topAnchor.constraint(equalTo: bottomView.bottomAnchor, constant: 20),
            sunAndMoonView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            sunAndMoonView.widthAnchor.constraint(equalTo: bottomView.widthAnchor),
            sunAndMoonView.heightAnchor.constraint(equalToConstant: 300),
            sunAndMoonView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            
            sunAndMoonLabel.topAnchor.constraint(equalTo: sunAndMoonView.topAnchor),
            sunAndMoonLabel.leadingAnchor.constraint(equalTo: sunAndMoonView.leadingAnchor),
            sunAndMoonLabel.heightAnchor.constraint(equalToConstant: 30),
            
            moonPhaseLabel.topAnchor.constraint(equalTo: sunAndMoonView.topAnchor),
            moonPhaseLabel.trailingAnchor.constraint(equalTo: sunAndMoonView.trailingAnchor),
            moonPhaseLabel.heightAnchor.constraint(equalToConstant: 30),
            
            sunImageView.topAnchor.constraint(equalTo: sunAndMoonLabel.bottomAnchor, constant: 20),
            sunImageView.leadingAnchor.constraint(equalTo: sunAndMoonView.leadingAnchor),
            sunImageView.heightAnchor.constraint(equalToConstant: 30),
            sunImageView.widthAnchor.constraint(equalToConstant: 30),
            
            sunSetAndSunRiseLabel.topAnchor.constraint(equalTo: sunImageView.topAnchor),
            sunSetAndSunRiseLabel.leadingAnchor.constraint(equalTo: sunImageView.trailingAnchor, constant: 20),
            sunSetAndSunRiseLabel.heightAnchor.constraint(equalToConstant: 30),
            
            moonSetAndSunRiseLabel.topAnchor.constraint(equalTo: sunSetAndSunRiseLabel.topAnchor),
            moonSetAndSunRiseLabel.leadingAnchor.constraint(equalTo: moonImageView.trailingAnchor, constant: 20),
            moonSetAndSunRiseLabel.heightAnchor.constraint(equalToConstant: 30),
            
            moonImageView.topAnchor.constraint(equalTo: sunImageView.topAnchor),
            moonImageView.leadingAnchor.constraint(equalTo: sunAndMoonView.centerXAnchor, constant: 10),
            moonImageView.heightAnchor.constraint(equalToConstant: 30),
            moonImageView.widthAnchor.constraint(equalToConstant: 30),
            
            moonRiseLabel.topAnchor.constraint(equalTo: moonImageView.bottomAnchor, constant: 20),
            moonRiseLabel.leadingAnchor.constraint(equalTo: moonImageView.leadingAnchor),
            moonRiseLabel.heightAnchor.constraint(equalToConstant: 30),
            
            moonSetLabel.topAnchor.constraint(equalTo: moonRiseLabel.bottomAnchor, constant: 20),
            moonSetLabel.leadingAnchor.constraint(equalTo: moonRiseLabel.leadingAnchor),
            moonSetLabel.heightAnchor.constraint(equalToConstant: 30),
            
            moonRiseValueLabel.topAnchor.constraint(equalTo: moonRiseLabel.topAnchor),
            moonRiseValueLabel.leadingAnchor.constraint(equalTo: moonRiseLabel.trailingAnchor, constant: 20),
            moonRiseValueLabel.heightAnchor.constraint(equalToConstant: 30),
            
            moonSetValueLabel.topAnchor.constraint(equalTo: moonSetLabel.topAnchor),
            moonSetValueLabel.leadingAnchor.constraint(equalTo: moonSetLabel.trailingAnchor, constant: 20),
            moonSetValueLabel.heightAnchor.constraint(equalToConstant: 30),
            
            sunRiseLabel.topAnchor.constraint(equalTo: sunImageView.bottomAnchor, constant: 20),
            sunRiseLabel.leadingAnchor.constraint(equalTo: sunImageView.leadingAnchor),
            sunRiseLabel.heightAnchor.constraint(equalToConstant: 30),
            
            sunSetLabel.topAnchor.constraint(equalTo: sunRiseLabel.bottomAnchor, constant: 20),
            sunSetLabel.leadingAnchor.constraint(equalTo: sunRiseLabel.leadingAnchor),
            sunSetLabel.heightAnchor.constraint(equalToConstant: 30),
            
            sunRiseValueLabel.topAnchor.constraint(equalTo: sunRiseLabel.topAnchor),
            sunRiseValueLabel.leadingAnchor.constraint(equalTo: sunRiseLabel.trailingAnchor, constant: 10),
            sunRiseValueLabel.heightAnchor.constraint(equalToConstant: 30),
            
            sunSetValueLabel.topAnchor.constraint(equalTo: sunSetLabel.topAnchor),
            sunSetValueLabel.leadingAnchor.constraint(equalTo: sunSetLabel.trailingAnchor, constant: 10),
            sunSetValueLabel.heightAnchor.constraint(equalToConstant: 30),
            
            lineOneView.topAnchor.constraint(equalTo: topView.topAnchor),
            lineOneView.leadingAnchor.constraint(equalTo: topView.leadingAnchor),
            lineOneView.trailingAnchor.constraint(equalTo: topView.trailingAnchor),
            lineOneView.bottomAnchor.constraint(equalTo: topView.bottomAnchor),
            lineOneView.heightAnchor.constraint(equalToConstant: 400),
            lineOneView.widthAnchor.constraint(equalTo: topView.widthAnchor),
            
            lineBottomView.topAnchor.constraint(equalTo: bottomView.topAnchor),
            lineBottomView.leadingAnchor.constraint(equalTo: bottomView.leadingAnchor),
            lineBottomView.trailingAnchor.constraint(equalTo: bottomView.trailingAnchor),
            lineBottomView.bottomAnchor.constraint(equalTo: bottomView.bottomAnchor),
            lineBottomView.heightAnchor.constraint(equalToConstant: 400),
            lineBottomView.widthAnchor.constraint(equalTo: bottomView.widthAnchor),
            
            dottedLineView.topAnchor.constraint(equalTo: sunAndMoonView.topAnchor),
            dottedLineView.centerXAnchor.constraint(equalTo: bottomView.centerXAnchor),
            dottedLineView.heightAnchor.constraint(equalToConstant: 300),
            dottedLineView.widthAnchor.constraint(equalTo: bottomView.widthAnchor)
                           
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    func cityLabelTextSetup() {
        cityLabel.text = viewModel.weather[currentIndex].now.name
    }
    
    func addButtonsToStackView() {
        
        let numbersOfButtons = 7
        for i in 1...numbersOfButtons {
            
            if let dateInt = viewModel.weather.first?.week.daily[i].dt {
                let timeInterval = TimeInterval(dateInt)
                let myNSDate = Date(timeIntervalSince1970: timeInterval)

                let dateFormatter2 = DateFormatter()
                dateFormatter2.dateFormat = "dd/MM"
                dateFormatter2.locale = Locale(identifier: "ru_RU")
                let dateString = dateFormatter2.string(from: myNSDate)

                dayButton.setTitle(dateString, for: .normal)
            }
        }
    }
    
    func getMoonPhaseStatus(moonPhase: Double) -> String {
        
        if moonPhase > 0.25 && moonPhase < 0.5 {
            return "Полумесяц"
        } else if moonPhase > 0.5 && moonPhase < 0.75 {
            return "Растущая луна"
        } else if moonPhase > 0.75 && moonPhase < 1 {
            return "Полнолуние"
        } else {
            return "Новая луна"
        }
    }
    
}

extension WeekCityWeatherViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return 7
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "dateCell", for: indexPath) as! DateWeekWeatherScreenCell
        
        cell.layer.cornerRadius = 5
        
        if selectedIndex == indexPath.item {
            
            cell.backgroundColor = UIColor.blue
            cell.dateLabel.textColor = UIColor.white
            
        } else {
            cell.backgroundColor = UIColor.white
            cell.dateLabel.textColor = UIColor.black
        }
        
        if let dateInt = viewModel.weather.first?.week.daily[indexPath.item].dt {
            let timeInterval = TimeInterval(dateInt)
            let myNSDate = Date(timeIntervalSince1970: timeInterval)
                
            let dateFormatter2 = DateFormatter()
            dateFormatter2.dateFormat = "dd/MM E"
            dateFormatter2.locale = Locale(identifier: "ru_RU")
            let dateString = dateFormatter2.string(from: myNSDate)
            
            cell.dateLabel.text = dateString
        
        } 
        return cell
    }
}


extension WeekCityWeatherViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            return CGSize(width: collectionView.frame.width / 5, height: collectionView.frame.height)
    }
}

//MARK: -DidSelectItem
extension WeekCityWeatherViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        selectedIndex = indexPath.item
        
    //MARK: -TopView
        
        //MARK: -Temp
        if let maxTemp = viewModel.weather[currentIndex].week.daily[selectedIndex].temp.max {
            tempLabel.text = String(format: "%.0f", maxTemp) + " " + "°"
        }
        
        //MARK: -Icon
        if currentIndex > viewModel.weather.startIndex || currentIndex < viewModel.weather.endIndex {
            if let icon = viewModel.weather[currentIndex].week.daily[selectedIndex].weather[0].icon {
                let urlStr = "http://openweathermap.org/img/w/" + (icon) + ".png"
                    let url = URL(string: urlStr)
                    imageView.kf.setImage(with: url) { result in
                        self.imageView.setNeedsLayout()
                    }
                }
        } else {
            if currentIndex > viewModel.weather.startIndex || currentIndex < viewModel.weather.endIndex {
                if let icon = viewModel.weather.first?.week.daily[selectedIndex].weather[0].icon {
                    let urlStr = "http://openweathermap.org/img/w/" + (icon) + ".png"
                        let url = URL(string: urlStr)
                        imageView.kf.setImage(with: url) { result in
                            self.imageView.setNeedsLayout()
                        }
                    }
            }
        }
        
        //MARK: -Description
        if let description = viewModel.weather[currentIndex].week.daily[selectedIndex].weather[0].description {
            weatherDescriptionLabel.text = description
        }
        
        //MARK: -Day feels like
        let dayFeelsLike = viewModel.weather[currentIndex].week.daily[selectedIndex].feelsLike.day
            feelsLikeValueLabel.text = String(format: "%.0f", dayFeelsLike) + " " + "°"
        
        //MARK: -Wind
        let wind = viewModel.weather[currentIndex].week.daily[selectedIndex].windSpeed
            windValueLabel.text = String(format: "%.0f", wind) + " " + "м/с"
        
        //MARK: -UF Index
        let ufIndex = viewModel.weather[currentIndex].week.daily[selectedIndex].uvi
            ufIndexValueLabel.text = String(format: "%.0f", ufIndex)
        
        //MARK: -Rain
        let rainTop = viewModel.weather[currentIndex].week.daily[selectedIndex].rain
        rainValueLabelBottom.text = String(format: "%.0f", rainTop ?? 0) + " " + "%"
        
        //MARK: -Clouds
        let cloud = viewModel.weather[currentIndex].week.daily[selectedIndex].clouds
        cloudsValueLabel.text = String(format: "%.0f", cloud) + " " + "%"
        
    //MARK: -BottomView
        
        //MARK: -Temp
        if let maxTemp = viewModel.weather[currentIndex].week.daily[selectedIndex].temp.night {
            tempLabelBottom.text = String(format: "%.0f", maxTemp) + " " + "°"
        }
        
        //MARK: -Icon
        if currentIndex > viewModel.weather.startIndex || currentIndex < viewModel.weather.endIndex {
            if let icon = viewModel.weather[currentIndex].week.daily[selectedIndex].weather[0].icon {
                let urlStr = "http://openweathermap.org/img/w/" + (icon) + ".png"
                    let url = URL(string: urlStr)
                    imageViewBottom.kf.setImage(with: url) { result in
                        self.imageView.setNeedsLayout()
                    }
                }
        } else {
            if currentIndex > viewModel.weather.startIndex || currentIndex < viewModel.weather.endIndex {
                if let icon = viewModel.weather.first?.week.daily[selectedIndex].weather[0].icon {
                    let urlStr = "http://openweathermap.org/img/w/" + (icon) + ".png"
                        let url = URL(string: urlStr)
                        imageViewBottom.kf.setImage(with: url) { result in
                            self.imageView.setNeedsLayout()
                        }
                    }
            }
        }
        
        //MARK: -Description
        if let description = viewModel.weather[currentIndex].week.daily[selectedIndex].weather[0].description {
            weatherDescriptionLabelBottom.text = description
        }
        
        //MARK: -Day feels like
        let dayFeelsLikeBottom = viewModel.weather[currentIndex].week.daily[selectedIndex].feelsLike.night
            feelsLikeValueLabelBottom.text = String(format: "%.0f", dayFeelsLikeBottom) + " " + "°"
        
        //MARK: -Wind
        let windBottom = viewModel.weather[currentIndex].week.daily[selectedIndex].windSpeed
            windValueLabelBottom.text = String(format: "%.0f", windBottom) + " " + "м/с"
        
        //MARK: -UF Index
        let ufIndexBottom = viewModel.weather[currentIndex].week.daily[selectedIndex].uvi
            ufIndexValueLabelBottom.text = String(format: "%.0f", ufIndexBottom)

        
        //MARK: -Rain
        let rainBottom = viewModel.weather[currentIndex].week.daily[selectedIndex].rain
        rainValueLabelBottom.text = String(format: "%.0f", rainBottom ?? 0) + " " + "%"
        
        //MARK: -Clouds
        let cloudBottom = viewModel.weather[currentIndex].week.daily[selectedIndex].clouds
        cloudsValueLabelBottom.text = String(format: "%.0f", cloudBottom) + " " + "%"
        
        self.dateCollectionView.reloadData()
        
        //MARK: -Moon phase
        
        let moonPhase = viewModel.weather[currentIndex].week.daily[selectedIndex].moonPhase
        
        moonPhaseLabel.text = getMoonPhaseStatus(moonPhase: moonPhase)
        
        //MARK: -Sunrise
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        dateFormatter.locale = Locale(identifier: "ru_RU")
        
        let sunRise = viewModel.weather[currentIndex].week.daily[selectedIndex].sunrise
        
        let dateDateSunRise = Date(miliseconds: Int64(sunRise))
        
        let dateFormatter2 = DateFormatter()
        dateFormatter2.dateFormat = "HH:mm"
        dateFormatter2.locale = Locale(identifier: "ru_RU")
    
        let dateSunRiseString = dateFormatter2.string(from: dateDateSunRise)
        
        sunRiseValueLabel.text = "\(dateSunRiseString)"
        
        //MARK: -Sunset
        
        let sunSet = viewModel.weather[currentIndex].week.daily[selectedIndex].sunset
        print(sunSet)

        let dateDateSunSet = Date(miliseconds: Int64(sunSet))
        
        let dateFormatter3 = DateFormatter()
        dateFormatter3.dateFormat = "HH:mm"
        dateFormatter3.locale = Locale(identifier: "ru_RU")
        
        let dateSunSetString = dateFormatter2.string(from: dateDateSunSet)
            
        sunSetValueLabel.text = "\(dateSunSetString)"
        
        //MARK: -Moonrise
        
        let moonRise = viewModel.weather[currentIndex].week.daily[selectedIndex].moonset
        
        let dateDateMoonRise = Date(miliseconds: Int64(moonRise))
    
        let dateMoonRiseString = dateFormatter2.string(from: dateDateMoonRise)
        
        moonRiseValueLabel.text = "\(dateMoonRiseString)"
        
        //MARK: -Moonset
        
        let moonSet = viewModel.weather[currentIndex].week.daily[selectedIndex].moonrise

        let dateDateMoonSet = Date(miliseconds: Int64(moonSet))
        
        let dateMoonSetString = dateFormatter2.string(from: dateDateMoonSet)
            
        moonSetValueLabel.text = "\(dateMoonSetString)"
        
        //MARK: -Difference between sunrise and sunset
        
        let splitsMoonRise = dateMoonRiseString.split(separator: ":").map(String.init)
        let hourMoonRise = ((splitsMoonRise[0]) as NSString).intValue
        let minutesMoonRise = ((splitsMoonRise[1]) as NSString).intValue
        
        let splitsMoonSet = dateMoonSetString.split(separator: ":").map(String.init)
        let hourMoonSet = ((splitsMoonSet[0]) as NSString).intValue
        let minutesMoonSet = ((splitsMoonSet[1]) as NSString).intValue
        
        let hourMoonDifference = hourMoonSet - hourMoonRise
        let minutesMoonDifference = minutesMoonSet - minutesMoonRise
        
        moonSetAndSunRiseLabel.text = "\(hourMoonDifference) ч" + "\(minutesMoonDifference) мин"
    }
}
    
//MARK: -Линии во дневном и ночном вью

class LineOneView: UIView {
    
    override func draw(_ rect: CGRect) {

        let aPath = UIBezierPath()
        aPath.move(to: CGPoint(x: 0, y: 170))
        aPath.addLine(to: CGPoint(x: frame.width, y: 170))
        aPath.close()
        UIColor.blue.set()
        aPath.lineWidth = 1
        aPath.stroke()
        
        let bPath = UIBezierPath()
        bPath.move(to: CGPoint(x: 0, y: 215))
        bPath.addLine(to: CGPoint(x: frame.width, y: 215))
        bPath.close()
        UIColor.blue.set()
        bPath.lineWidth = 1
        bPath.stroke()
        
        let cPath = UIBezierPath()
        cPath.move(to: CGPoint(x: 0, y: 260))
        cPath.addLine(to: CGPoint(x: frame.width, y: 260))
        cPath.close()
        UIColor.blue.set()
        cPath.lineWidth = 1
        cPath.stroke()
        
        let dPath = UIBezierPath()
        dPath.move(to: CGPoint(x: 0, y: 305))
        dPath.addLine(to: CGPoint(x: frame.width, y: 305))
        dPath.close()
        UIColor.blue.set()
        dPath.lineWidth = 1
        dPath.stroke()
        
        let ePath = UIBezierPath()
        ePath.move(to: CGPoint(x: 0, y: 350))
        ePath.addLine(to: CGPoint(x: frame.width, y: 350))
        ePath.close()
        UIColor.blue.set()
        ePath.lineWidth = 1
        ePath.stroke()
        
    }
}

class LineBottomView: UIView {
    
    override func draw(_ rect: CGRect) {

        let aPath = UIBezierPath()
        aPath.move(to: CGPoint(x: 0, y: 170))
        aPath.addLine(to: CGPoint(x: frame.width, y: 170))
        aPath.close()
        UIColor.blue.set()
        aPath.lineWidth = 1
        aPath.stroke()
        
        let bPath = UIBezierPath()
        bPath.move(to: CGPoint(x: 0, y: 215))
        bPath.addLine(to: CGPoint(x: frame.width, y: 215))
        bPath.close()
        UIColor.blue.set()
        bPath.lineWidth = 1
        bPath.stroke()
        
        let cPath = UIBezierPath()
        cPath.move(to: CGPoint(x: 0, y: 260))
        cPath.addLine(to: CGPoint(x: frame.width, y: 260))
        cPath.close()
        UIColor.blue.set()
        cPath.lineWidth = 1
        cPath.stroke()
        
        let dPath = UIBezierPath()
        dPath.move(to: CGPoint(x: 0, y: 305))
        dPath.addLine(to: CGPoint(x: frame.width, y: 305))
        dPath.close()
        UIColor.blue.set()
        dPath.lineWidth = 1
        dPath.stroke()
        
        let ePath = UIBezierPath()
        ePath.move(to: CGPoint(x: 0, y: 350))
        ePath.addLine(to: CGPoint(x: frame.width, y: 350))
        ePath.close()
        UIColor.blue.set()
        ePath.lineWidth = 1
        ePath.stroke()
        
    }
}

//MARK: -Пунктирные линии

class DottedLineView : UIView {
    
    override func draw(_ rect: CGRect) {
        //Вертикальная линия
        let verticalLinePath = UIBezierPath()
        verticalLinePath.move(to: CGPoint(x: frame.width / 2, y: 50))
        verticalLinePath.addLine(to: CGPoint(x: frame.width / 2, y: 180))
        verticalLinePath.close()
        UIColor(red: 103/255, green: 146/255, blue: 195/255, alpha: 1).set()
        verticalLinePath.lineWidth = 1
        verticalLinePath.stroke()
        
        //Пунктирные линии
        let  сPath = UIBezierPath()
        let  pс0 = CGPoint(x: 0, y: 100)
        сPath.move(to: pс0)
        let  pс1 = CGPoint(x: frame.width, y: 100)
        сPath.addLine(to: pс1)
        let  dashesС: [ CGFloat ] = [ 10.0, 10.0 ]
        сPath.setLineDash(dashesС, count: dashesС.count, phase: 0.0)
        сPath.lineWidth = 1.0
        сPath.lineCapStyle = .butt
        UIColor(red: 103/255, green: 146/255, blue: 195/255, alpha: 1).set()
        сPath.stroke()
        
        let  dPath = UIBezierPath()
        let  pd0 = CGPoint(x: 0, y: 140)
        dPath.move(to: pd0)
        let  pd1 = CGPoint(x: frame.width, y: 140)
        dPath.addLine(to: pd1)
        let  dashesD: [ CGFloat ] = [ 10.0, 10.0 ]
        dPath.setLineDash(dashesD, count: dashesD.count, phase: 0.0)
        dPath.lineWidth = 1.0
        dPath.lineCapStyle = .butt
        UIColor(red: 103/255, green: 146/255, blue: 195/255, alpha: 1).set()
        dPath.stroke()
    }
}

extension Date {
    var milisecondsSince1970: Int64 {
        Int64((self.timeIntervalSince1970 * 1000.0).rounded())
    }
    
    init(miliseconds: Int64) {
        self = Date(timeIntervalSince1970: TimeInterval(miliseconds))
    }
}
