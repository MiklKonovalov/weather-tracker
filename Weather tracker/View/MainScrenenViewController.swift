//
//  ViewController.swift
//  Weather tracker
//
//  Created by Misha on 11.11.2021.
//

import UIKit

class MainScrenenViewController: UIViewController {
    
    let viewModel: DayWeatherViewModel
    
    private var main: Double? {
        didSet {
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    
    private var minTemp: Double? {
        didSet {
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    
    //MARK: ~VIEWS
    
    //UILabel
    let cityLabel: UILabel = {
        let cityLabel = UILabel()
        cityLabel.font = UIFont(name: "Rubik-Medium", size: 18)
        cityLabel.text = "City"
        cityLabel.textColor = .black
        cityLabel.textAlignment = .center
        cityLabel.translatesAutoresizingMaskIntoConstraints = false
        return cityLabel
    }()
    
    //UIButton left
    var settingsButton: UIButton = {
        let settingsButton = UIButton()
        settingsButton.addTarget(self, action: #selector(settingsButtonTap), for: .touchUpInside)
        settingsButton.setImage(#imageLiteral(resourceName: "list"), for: .normal)
        settingsButton.translatesAutoresizingMaskIntoConstraints = false
        return settingsButton
    }()
    
    //UIButton right
    var locationButton: UIButton = {
        let settingsButton = UIButton()
        settingsButton.addTarget(self, action: #selector(locationButtonTap), for: .touchUpInside)
        settingsButton.setImage(#imageLiteral(resourceName: "location"), for: .normal)
        settingsButton.translatesAutoresizingMaskIntoConstraints = false
        return settingsButton
    }()
    
    //UIPage Controller
    lazy var pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.numberOfPages = 3
        pageControl.currentPageIndicatorTintColor = .black
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        pageControl.addTarget(self, action: #selector(pageControlTapHandler(sender:)), for: .touchUpInside)
        return pageControl
    }()
    
    //UIView slider and Scroll View
    var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(DayWeatherCell.self, forCellWithReuseIdentifier: "sliderCell")
        collectionView.layer.cornerRadius = 5
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = UIColor(red: 0.125, green: 0.306, blue: 0.78, alpha: 1)
        return collectionView
    }()
    
    //UILabel 24 hour
    let yourAttributes: [NSAttributedString.Key: Any] = [
        .underlineStyle: NSUnderlineStyle.single.rawValue
    ]
    
    var detauls24Button: UIButton = {
        let detauls24Button = UIButton()
        detauls24Button.addTarget(self, action: #selector(details24ButtonPressed), for: .touchUpInside)
        detauls24Button.setTitle("Подробнее на 24 часа", for: .normal)
        detauls24Button.titleLabel?.font = UIFont(name: "Rubik-Regular", size: 16)
        detauls24Button.setTitleColor(.black, for: .normal)
        
        detauls24Button.translatesAutoresizingMaskIntoConstraints = false
        return detauls24Button
    }()
    
    //CollectionView 1 day
    var todayCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let todayCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        todayCollectionView.register(TodayCollectionViewCell.self, forCellWithReuseIdentifier: "todayCell")
        //todayCollectionView.layer.cornerRadius = 22
        todayCollectionView.translatesAutoresizingMaskIntoConstraints = false
        todayCollectionView.backgroundColor = .white
        return todayCollectionView
    }()
    
    //UILabel everyday track
    let everydayLabel: UILabel = {
        let everydayLabel = UILabel()
        everydayLabel.font = UIFont(name: "Rubik-Medium", size: 18)
        everydayLabel.font = UIFont.boldSystemFont(ofSize: everydayLabel.font.pointSize)
        everydayLabel.text = "Ежедневный прогноз"
        everydayLabel.textColor = .black
        everydayLabel.textAlignment = .center
        everydayLabel.translatesAutoresizingMaskIntoConstraints = false
        return everydayLabel
    }()
    
    //UIButton 25 day
    var twentyFiveDayButton: UIButton = {
        let twentyFiveDayButton = UIButton()
        twentyFiveDayButton.addTarget(self, action: #selector(twentyFiveDayButtonPressed), for: .touchUpInside)
        //twentyFiveDayButton.setTitle("25 дней", for: .normal)
        twentyFiveDayButton.titleLabel?.font = UIFont(name: "Rubik-Regular", size: 16)
        twentyFiveDayButton.setTitleColor(.black, for: .normal)
        twentyFiveDayButton.translatesAutoresizingMaskIntoConstraints = false
        return twentyFiveDayButton
    }()
    
    //Bottom Collection view
    var bottomCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let bottomCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        bottomCollectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "bottomCell")
        bottomCollectionView.layer.cornerRadius = 5
        bottomCollectionView.translatesAutoresizingMaskIntoConstraints = false
        bottomCollectionView.backgroundColor = .white
        return bottomCollectionView
    }()
    
    //MARK: - Initialization
    
    init(viewModel: DayWeatherViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        view.addSubview(settingsButton)
        view.addSubview(locationButton)
        view.addSubview(cityLabel)
        view.addSubview(collectionView)
        view.addSubview(pageControl)
        view.addSubview(detauls24Button)
        view.addSubview(todayCollectionView)
        view.addSubview(bottomCollectionView)
        view.addSubview(everydayLabel)
        view.addSubview(twentyFiveDayButton)
        
        let attributeString = NSMutableAttributedString(string: "Подробнее на 24 часа", attributes: yourAttributes)
        let twentyFiveDayButtonAttributeString = NSMutableAttributedString(string: "25 часов", attributes: yourAttributes)
        detauls24Button.setAttributedTitle(attributeString, for: .normal)
        twentyFiveDayButton.setAttributedTitle(twentyFiveDayButtonAttributeString, for: .normal)
    
        collectionView.dataSource = self
        collectionView.delegate = self
        
        todayCollectionView.dataSource = self
        todayCollectionView.delegate = self
        
        bottomCollectionView.dataSource = self
        bottomCollectionView.delegate = self
        
        setupConstraints()

        viewModel.weatherDidChange = { result in
            //self.main?.append((result.main?.temp)!)
            self.main = result.main?.temp
            self.minTemp = result.main?.tempMax
            print("TEMPERATURE: \(result.main?.temp)")
        }
        
        /*viewModel.mainDidChange = { main in
            self.main = main
            
        }*/
        
        viewModel.viewDidLoad()
        
    }
    
    //MARK: ~FUNCTIONS
    
    func setupConstraints() {
        
        let constraints = [
        
            settingsButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 41),
            settingsButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            settingsButton.heightAnchor.constraint(equalToConstant: 22),
            
            locationButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 41),
            locationButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            locationButton.heightAnchor.constraint(equalToConstant: 22),
            
            cityLabel.widthAnchor.constraint(equalToConstant: 147),
            cityLabel.heightAnchor.constraint(equalToConstant: 22),
            cityLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 115),
            cityLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 41),
            
            collectionView.widthAnchor.constraint(equalToConstant: 344),
            collectionView.heightAnchor.constraint(equalToConstant: 212),
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 112),
            
            pageControl.topAnchor.constraint(equalTo: cityLabel.bottomAnchor, constant: 10),
            pageControl.widthAnchor.constraint(equalToConstant: 100),
            pageControl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            detauls24Button.heightAnchor.constraint(equalToConstant: 20),
            detauls24Button.trailingAnchor.constraint(equalTo: collectionView.trailingAnchor),
            detauls24Button.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 357),
            
            todayCollectionView.topAnchor.constraint(equalTo: detauls24Button.bottomAnchor, constant: 10),
            todayCollectionView.leadingAnchor.constraint(equalTo: collectionView.leadingAnchor),
            todayCollectionView.trailingAnchor.constraint(equalTo: collectionView.trailingAnchor),
            todayCollectionView.heightAnchor.constraint(equalToConstant: 83),
            
            everydayLabel.topAnchor.constraint(equalTo: todayCollectionView.bottomAnchor, constant: 10),
            everydayLabel.leadingAnchor.constraint(equalTo: todayCollectionView.leadingAnchor),
            everydayLabel.heightAnchor.constraint(equalToConstant: 30),
            
            twentyFiveDayButton.topAnchor.constraint(equalTo: todayCollectionView.bottomAnchor, constant: 10),
            twentyFiveDayButton.trailingAnchor.constraint(equalTo: todayCollectionView.trailingAnchor),
            twentyFiveDayButton.heightAnchor.constraint(equalToConstant: 30),
            
            bottomCollectionView.topAnchor.constraint(equalTo: everydayLabel.bottomAnchor, constant: 10),
            bottomCollectionView.leadingAnchor.constraint(equalTo: collectionView.leadingAnchor),
            bottomCollectionView.trailingAnchor.constraint(equalTo: collectionView.trailingAnchor),
            bottomCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            
        ]
        NSLayoutConstraint.activate(constraints)
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offSet = scrollView.contentOffset.x
        let width = scrollView.frame.width
        let horizontalCenter = width / 2
            
        pageControl.currentPage = Int(offSet + horizontalCenter) / Int(width)
    }
    
    //MARK: ~SELECTORS
    
    //UIAlertController
    @objc func locationButtonTap() {
        print("123")
    }
    
    //ShowSettingsController
    @objc func settingsButtonTap() {
        print("123")
    }
    
    //Selector for UIPage Controller
    @objc func pageControlTapHandler(sender: UIPageControl) {
        print("123")
    }
    
    @objc func details24ButtonPressed() {
        print("123")
    }
    
    @objc func twentyFiveDayButtonPressed() {
        print("123")
    }
    
}

//MARK: COLLECTION

extension MainScrenenViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.collectionView {
            return 1
        } else if collectionView == self.todayCollectionView {
            return 3
        } else {
            return 7
        }
    
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.collectionView {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "sliderCell", for: indexPath) as! DayWeatherCell
             
            if let myd: String? = String(main ?? 1.1) {
                cell.mainTemperatureLabel.text = myd
            }
            
            if let minTemp: String? = String(minTemp ?? 1.1) {
                cell.minTemperatureLabel.text = minTemp
            }
            
            return cell
            
        } else if collectionView == self.todayCollectionView {
        let cellTwo = collectionView.dequeueReusableCell(withReuseIdentifier: "todayCell", for: indexPath) as! TodayCollectionViewCell
        
            cellTwo.backgroundColor = .red
        
        return cellTwo
        } else {
        let cellThree = collectionView.dequeueReusableCell(withReuseIdentifier: "bottomCell", for: indexPath)
            
        cellThree.backgroundColor = .red
          
        return cellThree
        }
    }
    
}

extension MainScrenenViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == self.collectionView {
            print("User tapped on item \(indexPath.row)")
        } else if collectionView == self.todayCollectionView {
        print("User tapped on item \(indexPath.row)")
        } else {
        print("User tapped on item \(indexPath.row) in bottom collection")
        }
    }
}

extension MainScrenenViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == self.collectionView {
            return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
        } else if collectionView == self.todayCollectionView {
            return CGSize(width: collectionView.frame.width / 3, height: collectionView.frame.height)
        } else {
            return CGSize(width: collectionView.frame.width, height: 56)
        }
    }
}


