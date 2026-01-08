//
//  MainScreenViewController.swift
//  PictureSaver
//
//  Created by Artsiom Stulba on 20.12.25.
//

import UIKit
import SnapKit

class MainScreenViewController: UIViewController {
        
    private let goToAddPhotoButton: UIButton = {
        let button = UIButton()
        button.setTitle(AppStrings.addPhotoButtonTitle.rawValue, for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: FontSize.addPictureLabelTextSize.rawValue)
        button.layer.cornerRadius = ButtonsParams.addPictureButtonSizeWidthAndHeight.rawValue / 2
        button.backgroundColor = ElementsColors.addPictureButtonColor.color
        return button
    }()
    private let goToLibraryButton: UIButton = {
        let button = UIButton()
        button.setTitle(AppStrings.libraryButtonTitle.rawValue, for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: FontSize.mainScreenButtonsTextSize.rawValue)
        button.layer.cornerRadius = ButtonsParams.allPicturesButtonCornerRadius.rawValue
        button.backgroundColor = ElementsColors.addPictureButtonColor.color
        return button
    }()
    private let goToFavoritiesButton: UIButton = {
        let button = UIButton()
        button.setTitle(AppStrings.favoritePictures.rawValue, for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: FontSize.mainScreenButtonsTextSize.rawValue)
        button.layer.cornerRadius = ButtonsParams.allPicturesButtonCornerRadius.rawValue
        button.backgroundColor = ElementsColors.addPictureButtonColor.color
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        
    }
    
    private func configureUI() {
        view.backgroundColor = ElementsColors.backgroundColor.color
        
        view.addSubview(goToAddPhotoButton)
        goToAddPhotoButton.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.height.equalTo(ButtonsParams.addPictureButtonSizeWidthAndHeight.rawValue)
        }
        goToAddPhotoButton.addTarget(self, action: #selector(addPictureButtonTapped(_:)), for: .touchUpInside)
        
        view.addSubview(goToLibraryButton)
        goToLibraryButton.snp.makeConstraints { make in
            make.width.equalTo(ButtonsParams.allPicturesButtonWidth.rawValue)
            make.height.equalTo(ButtonsParams.allPicturesButtonHeight.rawValue)
            make.right.equalToSuperview().inset(ButtonsParams.allPicturesButtonHorizontalSpacing.rawValue)
            make.bottom.equalToSuperview().inset(ButtonsParams.allPicturesButtonVerticalSpacing.rawValue)
        }
        goToLibraryButton.addTarget(self, action: #selector(allPictureButtonTapped(_:)), for: .touchUpInside)
        
        view.addSubview(goToFavoritiesButton)
        goToFavoritiesButton.snp.makeConstraints { make in
            make.centerX.equalTo(goToLibraryButton)
            make.width.equalTo(ButtonsParams.allPicturesButtonWidth.rawValue)
            make.height.equalTo(ButtonsParams.allPicturesButtonHeight.rawValue)
            make.right.equalToSuperview().inset(ButtonsParams.allPicturesButtonHorizontalSpacing.rawValue)
            make.bottom.equalTo(goToLibraryButton.snp.top).offset(-(Offsets.bottomOffset.rawValue))
        }
        goToFavoritiesButton.addTarget(self, action: #selector(favoriteButtonTapped(_:)), for: .touchUpInside)
    }
    
    private func goToAddPictureScreen(){
        let controller = AddPictureViewController()
        navigationController?.pushViewController(controller, animated: true)
    }
    private func goToAllPictureScreen(){
        let controller = AllPictureViewController()
        navigationController?.pushViewController(controller, animated: true)
    }
    private func goToFavoritesScreen(){
        let controller = FavoritesPicturesViewController()
        navigationController?.pushViewController(controller, animated: true)
    }
    
    @objc private func addPictureButtonTapped(_ sender: UIButton) {
        goToAddPictureScreen()
    }
    
    @objc private func allPictureButtonTapped(_ sender: UIButton) {
        goToAllPictureScreen()
    }
    
    @objc private func favoriteButtonTapped(_ sender: UIButton) {
        goToFavoritesScreen()
    }
}
