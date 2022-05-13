//
//  NoCityWeatherViewController.swift
//  Weather tracker
//
//  Created by Misha on 14.12.2021.
//

import UIKit
import RealmSwift

class NoCityWeatherViewController: UIViewController {
    
    //MARK: -Dependencies
    
    let viewModel: GeneralViewModel
    let locationViewModel: LocationViewModel
    
    let realm = try! Realm()
    
    var currentIndex = 0
    
    
    //MARK: -Properties
    
    var plusButton: UIButton = {
        let settingsButton = UIButton()
        settingsButton.addTarget(self, action: #selector(plusButtonTap), for: .touchUpInside)
        settingsButton.setImage(#imageLiteral(resourceName: "плюс"), for: .normal)
        settingsButton.translatesAutoresizingMaskIntoConstraints = false
        return settingsButton
    }()
    
    //MARK: -Initializations
    
    init(viewModel: GeneralViewModel, locationViewModel: LocationViewModel) {
        self.viewModel = viewModel
        self.locationViewModel = locationViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: -LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        self.navigationController!.navigationBar.isHidden = true
        
        view.addSubview(plusButton)
        
        setupConstraints()
    }
    
    //MARK: -Selectors
    
    @objc func plusButtonTap() {
        
        let alert = UIAlertController(title: "Добавление города", message: nil, preferredStyle: .alert)
        
        alert.addTextField { textField in
            textField.placeholder = "Введите город"
        }
        
        alert.addAction(UIAlertAction(title: "Добавить", style: .default) { action in
            //Получаю значение текстового поля и передаю его в переменную textField
            let textField = alert.textFields?.first
            
            if textField?.text != "" {

                //Передаю значение textField в функцию в качестве параметра
                guard let text = textField?.text else { return }
                
                self.viewModel.userDidSelectNewCity(name: text, id: self.currentIndex + 1)
                
                let city = Cities()
                city.city = text
                
                try! self.realm.write {
                    self.realm.add([city])
                }
                
                WelcomeCore.shared.setIsNotNewUser()
                
                let pageViewController = PageViewController(viewModel: self.viewModel, locationViewModel: self.locationViewModel, currentIndex: self.currentIndex)
                
                let navigationControllerForAgree = UINavigationController(rootViewController: pageViewController)
                navigationControllerForAgree.modalPresentationStyle = .fullScreen
                self.present(navigationControllerForAgree, animated: true, completion: nil)
                
            }
        })
        
        alert.addAction(UIAlertAction(title: "Отмена", style: .default, handler: nil))

        self.present(alert, animated: true, completion: nil)
    }
    
    //MARK: -Functions
    
    func setupConstraints() {
        
        let constraints = [
        
            self.plusButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.plusButton.centerYAnchor.constraint(equalTo: self.view.centerYAnchor)
            
        ]
        NSLayoutConstraint.activate(constraints)
    }
}
