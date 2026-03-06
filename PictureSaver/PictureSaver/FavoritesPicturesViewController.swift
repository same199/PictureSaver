//
//  FavoritesPicturesViewController.swift
//  PictureSaver
//
//  Created by Artsiom Stulba on 4.01.26.
//

import UIKit
import SnapKit


class FavoritesPicturesViewController: UIViewController {
    private let buttonsContainer = UIView()
    private let saveLoadManager = SaveLoadManager()
    private var favoritesNamesArray: [String] = []
    private var currentIndex: Int = 0
    private let containerView = UIView()
    private let backButton: UIButton = {
        let button = UIButton()
        button.setTitle(AppStrings.clearPinButtonTuttle.rawValue, for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: FontSize.backButtonTextSize.size)
        button.backgroundColor = ElementsColors.confirmButtonColor.color
        return button
    }()
    private let favoritesScreenName: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: FontSize.screenNameTextSize.size)
        label.textColor = ElementsColors.pinTextColor.color
        label.text = AppStrings.favoritePictures.rawValue
        return label
    }()
    private let pictureView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.isUserInteractionEnabled = true
        imageView.layer.cornerRadius = ButtonsParams.allPicturesButtonCornerRadius.rawValue
        imageView.backgroundColor = ElementsColors.addPictureButtonColor.color
        return imageView
    }()
    private let infoAboutPictureTextField : UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.textAlignment = .left
        textField.textColor = .black
        textField.placeholder = AppStrings.pictureInformationPlaceholder.rawValue
        return textField
    }()
    private let previousPictureButton: UIButton = {
        let button = UIButton()
        button.setTitle(AppStrings.previousPictureButtonTitle.rawValue, for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: FontSize.prevAndNextButtonTextSize.size)
        button.contentHorizontalAlignment = .left
        button.titleLabel?.textAlignment = .left
        button.backgroundColor = ElementsColors.confirmButtonColor.color
        return button
    }()
    private let nextPictureButton: UIButton = {
        let button = UIButton()
        button.setTitle(AppStrings.nextPictureButtonTitle.rawValue, for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: FontSize.prevAndNextButtonTextSize.size)
        button.contentHorizontalAlignment = .right
        button.titleLabel?.textAlignment = .right
        button.backgroundColor = ElementsColors.confirmButtonColor.color
        return button
    }()
    private let favoriteButton: UIButton = {
        let button = UIButton()
        button.setTitle(AppStrings.addedToFavorite.rawValue, for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: FontSize.favoriteButtonTextSize.size)
        button.backgroundColor = ElementsColors.confirmButtonColor.color
        return button
    }()


    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        
    }
    
    private func configureUI() {
        favoritesNamesArray = saveLoadManager.loadFavoritesImageNames()
        view.addSubview(containerView)
        containerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        containerView.backgroundColor = ElementsColors.backgroundColor.color
        
        containerView.addSubview(backButton)
        backButton.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(ButtonsParams.allPicturesButtonHorizontalSpacing.rawValue)
            make.top.equalToSuperview().offset(ButtonsParams.allPicturesButtonVerticalSpacing.rawValue)
            make.width.height.equalTo(ButtonsParams.backButtonSize.rawValue)
        }
        backButton.addTarget(self, action: #selector(backButtonTapped(_:)), for: .touchUpInside)
        
        containerView.addSubview(favoritesScreenName)
        favoritesScreenName.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalTo(backButton)
        }
        containerView.addSubview(pictureView)
        pictureView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.height.equalTo(ImageViewParams.widthAndHeightAfterAddPicture.rawValue)
        }
        if favoritesNamesArray.isEmpty {
            pictureView.image = UIImage(named: "emptyLibrary")
            favoriteButton.isHidden = true
            previousPictureButton.isHidden = true
            nextPictureButton.isHidden = true
        } else {
            favoriteButton.isHidden = false
            previousPictureButton.isHidden = false
            nextPictureButton.isHidden = false
            currentIndex = favoritesNamesArray.count - 1
            showImage(at: currentIndex)
        }

        containerView.addSubview(buttonsContainer)
        buttonsContainer.snp.makeConstraints { make in
            make.top.equalTo(pictureView.snp.bottom).offset(Offsets.bottomOffset.rawValue)
            make.left.equalToSuperview().offset(Offsets.textFieldLeftAndRightOffset.rawValue)
            make.right.equalToSuperview().inset(Offsets.textFieldLeftAndRightOffset.rawValue)
            make.centerX.equalTo(pictureView)
            make.height.equalTo(PrevAndNextButtonsParams.previousAndNextButtonHeight.rawValue)
        }
        buttonsContainer.addSubview(previousPictureButton)
        previousPictureButton.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.width.equalTo(PrevAndNextButtonsParams.previousAndNextButtonWidth.rawValue)
            make.height.equalTo(PrevAndNextButtonsParams.previousAndNextButtonHeight.rawValue)
        }
        previousPictureButton.addTarget(self, action: #selector(previousPictureTapped),for: .touchUpInside)
        buttonsContainer.addSubview(nextPictureButton)
        nextPictureButton.snp.makeConstraints { make in
            make.right.equalToSuperview()
            make.width.equalTo(PrevAndNextButtonsParams.previousAndNextButtonWidth.rawValue)
            make.height.equalTo(PrevAndNextButtonsParams.previousAndNextButtonHeight.rawValue)
        }
        nextPictureButton.addTarget(self, action: #selector(nextPictureTapped),for: .touchUpInside)
        
        buttonsContainer.addSubview(favoriteButton)
        favoriteButton.snp.makeConstraints { make in
            make.centerX.equalTo(pictureView)
            make.width.height.equalTo(FavoriteButtonsParams.widthAndHeight.rawValue)
        }
        favoriteButton.addTarget(self, action: #selector(addOrDeletoFromFavorite), for: .touchUpInside)
    }
    
    private func goBack(){
            navigationController?.popViewController(animated: true)
        }
    @objc private func backButtonTapped(_ sender: UIButton) {
        goBack()
    }
    @objc private func nextPictureTapped() {
        guard currentIndex < favoritesNamesArray.count - 1 else { return }
        currentIndex += 1
        showImage(at: currentIndex)
    }
    
    @objc private func previousPictureTapped() {
        guard currentIndex > 0 else { return }
        currentIndex -= 1
        showImage(at: currentIndex)
    }
    
    private func showImage(at index: Int) {
        guard index >= 0, index < favoritesNamesArray.count else { return }
        let imageName = favoritesNamesArray[index]
        if let image = saveLoadManager.loadImage(filename: imageName) {
            pictureView.image = image
            infoAboutPictureTextField.text =
                    saveLoadManager.loadPictureText(for: imageName)
        }
    }
    
    private func updateFavoriteButtonState() {
        guard favoritesNamesArray.indices.contains(currentIndex) else { return }

        let imageName = favoritesNamesArray[currentIndex]
        let favorites = saveLoadManager.loadFavoritesImageNames()
        let isFavorite = favorites.contains(imageName)

        let title = isFavorite
            ? AppStrings.addedToFavorite.rawValue
            : AppStrings.notAddedToFavorite.rawValue

        favoriteButton.setTitle(title, for: .normal)
    }
    
    @objc private func addOrDeletoFromFavorite() {
        guard favoritesNamesArray.indices.contains(currentIndex) else { return }

        let imageName = favoritesNamesArray[currentIndex]

        // удаляем из UserDefaults
        saveLoadManager.removeFavoritesImageName(imageName)

        // удаляем из локального массива
        favoritesNamesArray.remove(at: currentIndex)

        // корректируем индекс
        if currentIndex >= favoritesNamesArray.count {
            currentIndex = max(favoritesNamesArray.count - 1, 0)
        }

        // обновляем экран
        if favoritesNamesArray.isEmpty {
            pictureView.image = UIImage(named: "emptyLibrary")
            favoriteButton.isHidden = true
            previousPictureButton.isHidden = true
            nextPictureButton.isHidden = true
        } else {
            showImage(at: currentIndex)
        }
    }
    
}


