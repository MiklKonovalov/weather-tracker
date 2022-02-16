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
        sunAndMoonView.addSubview(sunAndMoonLabel)
        sunAndMoonView.addSubview(moonPhaseLabel)
        sunAndMoonView.addSubview(sunImageView)
        sunAndMoonView.addSubview(sunRiseLabel)
        sunAndMoonView.addSubview(sunSetLabel)
        sunAndMoonView.addSubview(sunRiseValueLabel)
        sunAndMoonView.addSubview(sunSetValueLabel)
        
        dateCollectionView.dataSource = self
        dateCollectionView.delegate = self
        
        setupConstraints()
        cityLabelTextSetup()
        setupNavBar()
        
        let lineOneView = LineOneView(frame: CGRect(x: 0, y: 0, width: 300, height: 400))
        topView.addSubview(lineOneView)
        lineOneView.backgroundColor = UIColor.white.withAlphaComponent(0)
        lineOneView.translatesAutoresizingMaskIntoConstraints = false
        
        let dottedLineView = DottedLineView(frame: CGRect(x: 0, y: 0, width: 300, height: 400))
        sunAndMoonView.addSubview(dottedLineView)
        dottedLineView.backgroundColor = UIColor.white.withAlphaComponent(0)
        
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
        if let dayFeelsLike: String? = String(format: "%.0f", viewModel.weather[currentIndex].week.daily[selectedIndex].feelsLike.day) + " " + "°" {
            feelsLikeValueLabel.text = dayFeelsLike
        }
        
        //MARK: -Wind
        if let wind: String? = String(format: "%.0f", viewModel.weather[currentIndex].week.daily[selectedIndex].windSpeed) + " " + "м/с" {
            windValueLabel.text = wind
        }
        
        let ufIndex = viewModel.weather[currentIndex].week.daily[selectedIndex].uvi
            ufIndexValueLabel.text = "\(ufIndex)"
        
        //MARK: -Rain
        let rain = viewModel.weather[currentIndex].week.daily[selectedIndex].rain
        rainValueLabel.text = "\(rain ?? 0) %"
        
        //MARK: -Clouds
        let cloud = viewModel.weather[currentIndex].week.daily[selectedIndex].clouds
        cloudsValueLabel.text = "\(cloud) %"
        
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
        if let dayFeelsLike: String? = String(format: "%.0f", viewModel.weather[currentIndex].week.daily[selectedIndex].feelsLike.night) + " " + "°" {
                feelsLikeValueLabelBottom.text = dayFeelsLike
            }
            
            //MARK: -Wind
            if let wind: String? = String(format: "%.0f", viewModel.weather[currentIndex].week.daily[selectedIndex].windSpeed) + " " + "м/с" {
                windValueLabelBottom.text = wind
            }
            
            let ufIndexBottom = viewModel.weather[currentIndex].week.daily[selectedIndex].uvi
                ufIndexValueLabelBottom.text = "\(ufIndexBottom)"
            
            //MARK: -Rain
            let rainBottom = viewModel.weather[currentIndex].week.daily[selectedIndex].rain
            rainValueLabel.text = "\(rainBottom ?? 0) %"
            
            //MARK: -Clouds
            let cloudBottom = viewModel.weather[currentIndex].week.daily[selectedIndex].clouds
            cloudsValueLabel.text = "\(cloudBottom) %"
        
        //MARK: -Moon phase
        
        let moonPhase = viewModel.weather[currentIndex].week.daily[selectedIndex].moonPhase
        
        moonPhaseLabel.text = getMoonPhaseStatus(moonPhase: moonPhase)
        
        //MARK: -Sunrise
        
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
//        dateFormatter.locale = Locale(identifier: "ru_RU")
//        
//        let sunRise = viewModel.weather[currentIndex].week.daily[selectedIndex].sunrise
//        let dateDate = dateFormatter.string(from: sunRise)
//
//        let dateFormatter2 = DateFormatter()
//        dateFormatter2.dateFormat = "HH:mm"
//        dateFormatter2.locale = Locale(identifier: "ru_RU")
//    
//        let dateString = dateFormatter2.string(from: dateDate ?? Date())
//        cellTwo.timeLabel.text = dateString
//        
//        
//        sunRiseValueLabel.text = "\(sunRise)"
        
        //MARK: -Sunset
        
        let sunSet = viewModel.weather[currentIndex].week.daily[selectedIndex].sunset
        sunSetValueLabel.text = "\(sunSet)"
        
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
            feelsImageView.leadingAnchor.constraint(equalTo: topView.leadingAnchor, constant: 10),
            feelsImageView.widthAnchor.constraint(equalToConstant: 30),
            feelsImageView.heightAnchor.constraint(equalToConstant: 30),
            
            windImageView.topAnchor.constraint(equalTo: feelsImageView.bottomAnchor, constant: 15),
            windImageView.leadingAnchor.constraint(equalTo: topView.leadingAnchor, constant: 10),
            windImageView.widthAnchor.constraint(equalToConstant: 30),
            windImageView.heightAnchor.constraint(equalToConstant: 30),
            
            ufIndexImageView.topAnchor.constraint(equalTo: windImageView.bottomAnchor, constant: 15),
            ufIndexImageView.leadingAnchor.constraint(equalTo: topView.leadingAnchor, constant: 10),
            ufIndexImageView.widthAnchor.constraint(equalToConstant: 30),
            ufIndexImageView.heightAnchor.constraint(equalToConstant: 30),
            
            rainImageView.topAnchor.constraint(equalTo: ufIndexImageView.bottomAnchor, constant: 15),
            rainImageView.leadingAnchor.constraint(equalTo: topView.leadingAnchor, constant: 10),
            rainImageView.widthAnchor.constraint(equalToConstant: 30),
            rainImageView.heightAnchor.constraint(equalToConstant: 30),
            
            cloudsImageView.topAnchor.constraint(equalTo: rainImageView.bottomAnchor, constant: 15),
            cloudsImageView.leadingAnchor.constraint(equalTo: topView.leadingAnchor, constant: 10),
            cloudsImageView.widthAnchor.constraint(equalToConstant: 30),
            cloudsImageView.heightAnchor.constraint(equalToConstant: 30),
            
            feelsLikeLabel.topAnchor.constraint(equalTo: feelsImageView.topAnchor),
            feelsLikeLabel.leadingAnchor.constraint(equalTo: feelsImageView.trailingAnchor, constant: 30),
            feelsLikeLabel.widthAnchor.constraint(equalToConstant: 150),
            feelsLikeLabel.heightAnchor.constraint(equalToConstant: 30),
            
            windLabel.topAnchor.constraint(equalTo: windImageView.topAnchor),
            windLabel.leadingAnchor.constraint(equalTo: windImageView.trailingAnchor, constant: 30),
            windLabel.widthAnchor.constraint(equalToConstant: 150),
            windLabel.heightAnchor.constraint(equalToConstant: 30),
            
            ufIndexLabel.topAnchor.constraint(equalTo: ufIndexImageView.topAnchor),
            ufIndexLabel.leadingAnchor.constraint(equalTo: ufIndexImageView.trailingAnchor, constant: 30),
            ufIndexLabel.widthAnchor.constraint(equalToConstant: 150),
            ufIndexLabel.heightAnchor.constraint(equalToConstant: 30),
            
            rainLabel.topAnchor.constraint(equalTo: rainImageView.topAnchor),
            rainLabel.leadingAnchor.constraint(equalTo: rainImageView.trailingAnchor, constant: 30),
            rainLabel.widthAnchor.constraint(equalToConstant: 150),
            rainLabel.heightAnchor.constraint(equalToConstant: 30),
            
            cloudsLabel.topAnchor.constraint(equalTo: cloudsImageView.topAnchor),
            cloudsLabel.leadingAnchor.constraint(equalTo: cloudsImageView.trailingAnchor, constant: 30),
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
            feelsImageViewBottom.leadingAnchor.constraint(equalTo: bottomView.leadingAnchor, constant: 10),
            feelsImageViewBottom.widthAnchor.constraint(equalToConstant: 30),
            feelsImageViewBottom.heightAnchor.constraint(equalToConstant: 30),
            
            windImageViewBottom.topAnchor.constraint(equalTo: feelsImageViewBottom.bottomAnchor, constant: 15),
            windImageViewBottom.leadingAnchor.constraint(equalTo: bottomView.leadingAnchor, constant: 10),
            windImageViewBottom.widthAnchor.constraint(equalToConstant: 30),
            windImageViewBottom.heightAnchor.constraint(equalToConstant: 30),
            
            ufIndexImageViewBottom.topAnchor.constraint(equalTo: windImageViewBottom.bottomAnchor, constant: 15),
            ufIndexImageViewBottom.leadingAnchor.constraint(equalTo: bottomView.leadingAnchor, constant: 10),
            ufIndexImageViewBottom.widthAnchor.constraint(equalToConstant: 30),
            ufIndexImageViewBottom.heightAnchor.constraint(equalToConstant: 30),
            
            rainImageViewBottom.topAnchor.constraint(equalTo: ufIndexImageViewBottom.bottomAnchor, constant: 15),
            rainImageViewBottom.leadingAnchor.constraint(equalTo: bottomView.leadingAnchor, constant: 10),
            rainImageViewBottom.widthAnchor.constraint(equalToConstant: 30),
            rainImageViewBottom.heightAnchor.constraint(equalToConstant: 30),
            
            cloudsImageViewBottom.topAnchor.constraint(equalTo: rainImageViewBottom.bottomAnchor, constant: 15),
            cloudsImageViewBottom.leadingAnchor.constraint(equalTo: bottomView.leadingAnchor, constant: 10),
            cloudsImageViewBottom.widthAnchor.constraint(equalToConstant: 30),
            cloudsImageViewBottom.heightAnchor.constraint(equalToConstant: 30),
            
            feelsLikeLabelBottom.topAnchor.constraint(equalTo: feelsImageViewBottom.topAnchor),
            feelsLikeLabelBottom.leadingAnchor.constraint(equalTo: feelsImageViewBottom.trailingAnchor, constant: 30),
            feelsLikeLabelBottom.widthAnchor.constraint(equalToConstant: 150),
            feelsLikeLabelBottom.heightAnchor.constraint(equalToConstant: 30),
            
            windLabelBottom.topAnchor.constraint(equalTo: windImageViewBottom.topAnchor),
            windLabelBottom.leadingAnchor.constraint(equalTo: windImageViewBottom.trailingAnchor, constant: 30),
            windLabelBottom.widthAnchor.constraint(equalToConstant: 150),
            windLabelBottom.heightAnchor.constraint(equalToConstant: 30),
            
            ufIndexLabelBottom.topAnchor.constraint(equalTo: ufIndexImageViewBottom.topAnchor),
            ufIndexLabelBottom.leadingAnchor.constraint(equalTo: ufIndexImageViewBottom.trailingAnchor, constant: 30),
            ufIndexLabelBottom.widthAnchor.constraint(equalToConstant: 150),
            ufIndexLabelBottom.heightAnchor.constraint(equalToConstant: 30),
            
            rainLabelBottom.topAnchor.constraint(equalTo: rainImageViewBottom.topAnchor),
            rainLabelBottom.leadingAnchor.constraint(equalTo: rainImageViewBottom.trailingAnchor, constant: 30),
            rainLabelBottom.widthAnchor.constraint(equalToConstant: 150),
            rainLabelBottom.heightAnchor.constraint(equalToConstant: 30),
            
            cloudsLabelBottom.topAnchor.constraint(equalTo: cloudsImageViewBottom.topAnchor),
            cloudsLabelBottom.leadingAnchor.constraint(equalTo: cloudsImageViewBottom.trailingAnchor, constant: 30),
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
            sunAndMoonView.leadingAnchor.constraint(equalTo: bottomView.leadingAnchor),
            sunAndMoonView.trailingAnchor.constraint(equalTo: bottomView.trailingAnchor),
            sunAndMoonView.heightAnchor.constraint(equalToConstant: 400),
            sunAndMoonView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            
            sunAndMoonLabel.topAnchor.constraint(equalTo: sunAndMoonView.topAnchor),
            sunAndMoonLabel.leadingAnchor.constraint(equalTo: sunAndMoonView.leadingAnchor),
            sunAndMoonLabel.heightAnchor.constraint(equalToConstant: 30),
            
            moonPhaseLabel.topAnchor.constraint(equalTo: sunAndMoonView.topAnchor),
            moonPhaseLabel.trailingAnchor.constraint(equalTo: sunAndMoonView.trailingAnchor),
            moonPhaseLabel.heightAnchor.constraint(equalToConstant: 30),
            
            sunImageView.topAnchor.constraint(equalTo: sunAndMoonLabel.bottomAnchor, constant: 20),
            sunImageView.leadingAnchor.constraint(equalTo: sunAndMoonLabel.leadingAnchor, constant: 20),
            sunImageView.heightAnchor.constraint(equalToConstant: 30),
            sunImageView.widthAnchor.constraint(equalToConstant: 30),
            
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
                           
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    func cityLabelTextSetup() {
        cityLabel.text = viewModel.weather[currentIndex].now.name
    }
    
    func addButtonsToStackView() {
        
        let numbersOfButtons = 7
        for i in 1...numbersOfButtons {
            
            //dayButton.setTitle("\(i)", for: .normal)
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
        if let dayFeelsLike: String? = String(format: "%.0f", viewModel.weather[currentIndex].week.daily[selectedIndex].feelsLike.day) + " " + "°" {
            feelsLikeValueLabel.text = dayFeelsLike
        }
        
        //MARK: -Wind
        if let wind: String? = String(format: "%.0f", viewModel.weather[currentIndex].week.daily[selectedIndex].windSpeed) + " " + "м/с" {
            windValueLabel.text = wind
        }
        
        //MARK: -UF Index
        if let ufIndex: String? = String(format: "%.0f", viewModel.weather[currentIndex].week.daily[selectedIndex].uvi) {
            ufIndexValueLabel.text = ufIndex
        }
        
        //MARK: -Rain
//        if let rain: String? = String(format: "%.0f", viewModel.weather[currentIndex].week.daily[selectedIndex].rain) {
//            rainValueLabel.text = rain
//        }
        
        //MARK: -Clouds
        let cloud = viewModel.weather[currentIndex].week.daily[selectedIndex].clouds
        cloudsValueLabel.text = "\(cloud) %"
        
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
        if let dayFeelsLike: String? = String(format: "%.0f", viewModel.weather[currentIndex].week.daily[selectedIndex].feelsLike.night) + " " + "°" {
            feelsLikeValueLabelBottom.text = dayFeelsLike
        }
        
        //MARK: -Wind
        if let wind: String? = String(format: "%.0f", viewModel.weather[currentIndex].week.daily[selectedIndex].windSpeed) + " " + "м/с" {
            windValueLabelBottom.text = wind
        }
        
        //MARK: -UF Index
        if let ufIndex: String? = String(format: "%.0f", viewModel.weather[currentIndex].week.daily[selectedIndex].uvi) {
            ufIndexValueLabelBottom.text = ufIndex
        }
        
        //MARK: -Rain
        let rainBottom = viewModel.weather[currentIndex].week.daily[selectedIndex].rain
        rainValueLabelBottom.text = "\(rainBottom ?? 00) %"
        
        //MARK: -Clouds
        let cloudBottom = viewModel.weather[currentIndex].week.daily[selectedIndex].clouds
        cloudsValueLabelBottom.text = "\(cloudBottom) %"
        
        self.dateCollectionView.reloadData()
        
        //MARK: -Moon phase
        
        let moonPhase = viewModel.weather[currentIndex].week.daily[selectedIndex].moonPhase
        
        moonPhaseLabel.text = getMoonPhaseStatus(moonPhase: moonPhase)
        
    }
}
    
//MARK: -Линии

class LineOneView : UIView {
    
    override func draw(_ rect: CGRect) {

        let aPath = UIBezierPath()
        aPath.move(to: CGPoint(x: 0, y: 200))
        aPath.addLine(to: CGPoint(x: 300, y: 200))
        aPath.close()
        UIColor.blue.set()
        aPath.lineWidth = 1
        aPath.stroke()
        
        let bPath = UIBezierPath()
        bPath.move(to: CGPoint(x: 0, y: 250))
        bPath.addLine(to: CGPoint(x: 300, y: 250))
        bPath.close()
        UIColor.blue.set()
        bPath.lineWidth = 1
        bPath.stroke()
        
        let cPath = UIBezierPath()
        cPath.move(to: CGPoint(x: 0, y: 300))
        cPath.addLine(to: CGPoint(x: 300, y: 300))
        cPath.close()
        UIColor.blue.set()
        cPath.lineWidth = 1
        cPath.stroke()
        
        let dPath = UIBezierPath()
        dPath.move(to: CGPoint(x: 0, y: 350))
        dPath.addLine(to: CGPoint(x: 300, y: 350))
        dPath.close()
        UIColor.blue.set()
        dPath.lineWidth = 1
        dPath.stroke()
        
        let ePath = UIBezierPath()
        ePath.move(to: CGPoint(x: 0, y: 400))
        ePath.addLine(to: CGPoint(x: 300, y: 400))
        ePath.close()
        UIColor.blue.set()
        ePath.lineWidth = 1
        ePath.stroke()
        

    }
}

//MARK: -Пунктирные линии

class DottedLineView : UIView {
    
    override func draw(_ rect: CGRect) {
        //Пунктирная линия
        let  aPath = UIBezierPath()
        let  p0 = CGPoint(x: 10, y: 100)
        aPath.move(to: p0)
        let  p1 = CGPoint(x: 150, y: 100)
        aPath.addLine(to: p1)
        let  dashes: [ CGFloat ] = [ 10.0, 10.0 ]
        aPath.setLineDash(dashes, count: dashes.count, phase: 0.0)
        aPath.lineWidth = 1.0
        aPath.lineCapStyle = .butt
        UIColor(red: 103/255, green: 146/255, blue: 195/255, alpha: 1).set()
        aPath.stroke()
        
        let  bPath = UIBezierPath()
        let  pb0 = CGPoint(x: 10, y: 140)
        bPath.move(to: pb0)
        let  pb1 = CGPoint(x: 150, y: 140)
        bPath.addLine(to: pb1)
        let  dashesB: [ CGFloat ] = [ 10.0, 10.0 ]
        bPath.setLineDash(dashesB, count: dashesB.count, phase: 0.0)
        bPath.lineWidth = 1.0
        bPath.lineCapStyle = .butt
        UIColor(red: 103/255, green: 146/255, blue: 195/255, alpha: 1).set()
        bPath.stroke()
        
        let verticalLinePath = UIBezierPath()
        verticalLinePath.move(to: CGPoint(x: 180, y: 50))
        verticalLinePath.addLine(to: CGPoint(x: 180, y: 180))
        verticalLinePath.close()
        UIColor(red: 103/255, green: 146/255, blue: 195/255, alpha: 1).set()
        verticalLinePath.lineWidth = 1
        verticalLinePath.stroke()
        
        
    }
}
