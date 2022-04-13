//
//  PageViewController.swift
//  Weather tracker
//
//  Created by Misha on 04.04.2022.
//

import UIKit
import RealmSwift

protocol ChangeWeatherDelegate {
    func updateLabels(with index: Int)
}

class PageViewController: UIViewController, UIPageViewControllerDelegate, UIPageViewControllerDataSource {

    var changingDelegate: ChangeWeatherDelegate?
    
    let viewModel: GeneralViewModel
    
    let locationViewModel: LocationViewModel
    
    let realm = try! Realm()
    
    var currentIndex: Int
    
    var pageControl = UIPageControl.appearance()
    
    var pageController: UIPageViewController!
    
    var controllers = [UIViewController]()
    
    var pendingIndex = 0
    
    init(viewModel: GeneralViewModel, locationViewModel: LocationViewModel, currentIndex: Int) {
        self.viewModel = viewModel
        self.locationViewModel = locationViewModel
        self.currentIndex = currentIndex
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: -Lifecycle
    
    //Тест Вариант 3
    
//    override func viewDidAppear(animated: Bool) {
//        super.viewDidAppear(animated)
//        let viewControllers: [UIViewControllers] = [UIViewController()]
//        if let pageViewController = parentViewController as? UIPageViewController {
//            pageViewController.setViewControllers(viewControllers, direction: .Forward, animated: true, completion: nil)
//        }
//    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pageController = UIPageViewController(transitionStyle: .scroll,
                                                      navigationOrientation: .horizontal,
                                                      options: nil)
        pageController.delegate = self
        pageController.dataSource = self
        
        
        
        addChild(pageController)
        view.addSubview(pageController.view)
        
//        NSLayoutConstraint.activate([
//            pageController.view.topAnchor.constraint(equalTo: view.topAnchor),
//            pageController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
//            pageController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
//            pageController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor)
//        ])
        
        let views = ["pageController": pageController.view] as [String: AnyObject]
                view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[pageController]|", options: [], metrics: nil, views: views))
                view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[pageController]|", options: [], metrics: nil, views: views))
        
        if realm.objects(Cities.self).first != nil {
            for (index, _) in realm.objects(Cities.self).enumerated() {
                let mainScreenViewController = MainScrenenViewController(viewModel: self.viewModel, locationViewModel: self.locationViewModel, currentIndex: currentIndex)
                mainScreenViewController.selectionDelegate = self
                mainScreenViewController.currentIndex += (index)
                self.controllers.append(mainScreenViewController)
            }
        } else {
            
                let mainScreenViewController = MainScrenenViewController(viewModel: self.viewModel, locationViewModel: self.locationViewModel, currentIndex: currentIndex)
                self.controllers.append(mainScreenViewController)
            
            
        }
        
        pageController.setViewControllers([controllers[0]], direction: .forward, animated: false)
        
        setupPageControl()
    
    }
    
    func firstCityDidLoaded() {
        let mainScreenViewController = MainScrenenViewController(viewModel: self.viewModel, locationViewModel: self.locationViewModel, currentIndex: currentIndex )
        self.controllers.append(mainScreenViewController)
    }
    
    func setupPageControl() {
        
        let realmCities = realm.objects(Cities.self)
        
        pageControl = UIPageControl(frame: CGRect(x: 0,y: 100,width: UIScreen.main.bounds.width,height: 50))
        pageControl.numberOfPages = realmCities.count
        pageControl.tintColor = UIColor.lightGray
        pageControl.pageIndicatorTintColor = UIColor.lightGray
        pageControl.currentPageIndicatorTintColor = UIColor.black
        pageControl.backgroundColor = UIColor.clear
        view.addSubview(pageControl)
       
    }
    //Предыдущая страница Before
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        //Если индекс = первому индексу в котором значение появляется в коллекци
            if let index = controllers.firstIndex(of: viewController) {
                if index > 0 {
                    
                    return controllers[index-1]
                } else {
                    return nil
                }
            }
        return nil
    }
    //Следующая страница After
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
            if let index = controllers.firstIndex(of: viewController) {
                if index < controllers.count - 1 {
                    
                    return controllers[index+1]
                } else {
                    return nil
                }
            }
            return nil
    }

    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        
        if !completed { return }
            DispatchQueue.main.async() {
                pageViewController.dataSource = nil
                pageViewController.dataSource = self
            }
        
        let pageViewController = pageViewController.viewControllers![0]
        self.pageControl.currentPage = controllers.firstIndex(of: pageViewController)!
    }
    
}

extension PageViewController: AddNewCityDelegate {

    func newCityDidSelected(name: Cities) {

            guard let lastCity = realm.objects(Cities.self).index(of: name) else { return }

            let mainScreenViewController = MainScrenenViewController(viewModel: self.viewModel, locationViewModel: self.locationViewModel, currentIndex: lastCity)

            self.controllers.append(mainScreenViewController)

    }
}
