//
//  ViewController.swift
//  PictureSaver
//
//  Created by Artsiom Stulba on 20.12.25.
//

import UIKit

class ViewController: UIViewController {
    private let oneButton: UIButton = {
        let button = UIButton()
        button.setTitle("go enter pin", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 24)
        return button
    }()
    private let twoButton: UIButton = {
        let button = UIButton()
        button.setTitle("go create pin", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 24)
        return button
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        
    }
    
    private func configureUI(){
        view.backgroundColor = .white
        view.addSubview(oneButton)
        oneButton.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        let goNextScreen = UIAction {_ in
            self.goToEnterPin()
        }
        oneButton.addAction(goNextScreen, for: .touchUpInside)
        view.addSubview(twoButton)
        twoButton.snp.makeConstraints { make in
            make.top.equalTo(oneButton.snp.bottom).offset(16)
        }
        let goScreen = UIAction {_ in
            self.goToCreatePin()
        }
        twoButton.addAction(goScreen, for: .touchUpInside)
    }
    
    private func goToEnterPin(){
        let controller = EnterPasswordViewController()
        navigationController?.pushViewController(controller, animated: true)
    }
    private func goToCreatePin(){
        let controller = CreatePasswordViewController()
        navigationController?.pushViewController(controller, animated: true)
    }


}

