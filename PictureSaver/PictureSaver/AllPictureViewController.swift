//
//  AllPictureViewController.swift
//  PictureSaver
//
//  Created by Artsiom Stulba on 20.12.25.
//


import UIKit
import SnapKit

class AllPictureViewController: UIViewController {
    
    private let saveLoadManager = SaveLoadManager()
    private var imageNamesArray: [String] = []
    private var currentIndex: Int = 0
    private let containerView = UIView()
    private let buttonsContainer = UIView()
    private let backButton: UIButton = {
        let button = UIButton()
        let config = UIImage.SymbolConfiguration(
                pointSize: FontSize.prevAndNextButtonTextSize.size,
                weight: .medium)
        let image = UIImage(systemName: "chevron.backward", withConfiguration: config)
            button.setImage(image, for: .normal)
        button.tintColor = .white
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: FontSize.backButtonTextSize.size)
        button.backgroundColor = ElementsColors.confirmButtonColor.color
        return button
    }()
    private let allPictureScreenName: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: FontSize.screenNameTextSize.size)
        label.textColor = ElementsColors.pinTextColor.color
        label.text = AppStrings.libraryScreenTitle.rawValue
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
        let config = UIImage.SymbolConfiguration(
                pointSize: FontSize.prevAndNextButtonTextSize.size,
                weight: .semibold)
        let image = UIImage(systemName: "chevron.backward", withConfiguration: config)
            button.setImage(image, for: .normal)
        button.tintColor = .white
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: FontSize.prevAndNextButtonTextSize.size)
        button.contentHorizontalAlignment = .left
        button.titleLabel?.textAlignment = .left
        button.backgroundColor = ElementsColors.confirmButtonColor.color
        return button
    }()
    private let nextPictureButton: UIButton = {
        let button = UIButton()
        let config = UIImage.SymbolConfiguration(
                pointSize: FontSize.prevAndNextButtonTextSize.size,
                weight: .semibold)
        let image = UIImage(systemName: "chevron.right", withConfiguration: config)
            button.setImage(image, for: .normal)
        button.tintColor = .white
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: FontSize.prevAndNextButtonTextSize.size)
        button.contentHorizontalAlignment = .right
        button.titleLabel?.textAlignment = .right
        button.backgroundColor = ElementsColors.confirmButtonColor.color
        return button
    }()
    private let favoriteButton: UIButton = {
        let button = UIButton()
        let config = UIImage.SymbolConfiguration(
                pointSize: FontSize.prevAndNextButtonTextSize.size,
                weight: .semibold)
        let image = UIImage(systemName: "heart", withConfiguration: config)
            button.setImage(image, for: .normal)
        button.tintColor = .white
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: FontSize.favoriteButtonTextSize.size)
        button.backgroundColor = ElementsColors.confirmButtonColor.color
        return button
    }()
    
    private let deleteImageButton: UIButton = {
        let button = UIButton()
        let config = UIImage.SymbolConfiguration(
                pointSize: FontSize.prevAndNextButtonTextSize.size,
                weight: .semibold)
        let image = UIImage(systemName: "trash", withConfiguration: config)
            button.setImage(image, for: .normal)
        button.tintColor = .white
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: FontSize.favoriteButtonTextSize.size)
        button.backgroundColor = ElementsColors.confirmButtonColor.color
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureNotifications()
    }
    
    private func configureUI() {
        imageNamesArray = saveLoadManager.loadImageNames()
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
        containerView.addSubview(allPictureScreenName)
        allPictureScreenName.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalTo(backButton)
        }
        
        containerView.addSubview(pictureView)
        pictureView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.height.equalTo(ImageViewParams.widthAndHeightAfterAddPicture.rawValue)
        }
        if imageNamesArray.isEmpty{
            pictureView.image = UIImage(named: "emptyLibrary")
            infoAboutPictureTextField.isHidden = true
            favoriteButton.isHidden = true
            previousPictureButton.isHidden = true
            nextPictureButton.isHidden = true
            deleteImageButton.isHidden = true
        }else
        {
            currentIndex = imageNamesArray.count - 1
            showImage(at: currentIndex)
            
        }
        containerView.addSubview(infoAboutPictureTextField)
        infoAboutPictureTextField.snp.makeConstraints { make in
            make.top.equalTo(pictureView.snp.bottom).offset(Offsets.bottomOffset.rawValue)
            make.left.equalToSuperview().offset(Offsets.textFieldLeftAndRightOffset.rawValue)
            make.right.equalToSuperview().inset(Offsets.textFieldLeftAndRightOffset.rawValue)
            make.centerX.equalTo(pictureView)
            make.height.equalTo(TextFieldParams.height.rawValue)
        }
        infoAboutPictureTextField.delegate = self
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(closeKeyboardTap))
        containerView.addGestureRecognizer(tapRecognizer)

        containerView.addSubview(buttonsContainer)
        buttonsContainer.snp.makeConstraints { make in
            make.top.equalTo(infoAboutPictureTextField.snp.bottom).offset(Offsets.bottomOffset.rawValue)
            make.left.equalToSuperview().offset(Offsets.textFieldLeftAndRightOffset.rawValue)
            make.right.equalToSuperview().inset(Offsets.textFieldLeftAndRightOffset.rawValue)
            make.centerX.equalTo(pictureView)
            make.height.equalTo(PrevAndNextButtonsParams.previousAndNextButtonWidthAndHeight.rawValue)
        }

        previousPictureButton.addTarget(self, action: #selector(previousPictureTapped),for: .touchUpInside)
        favoriteButton.addTarget(self, action: #selector(addOrDeletoFromFavorite), for: .touchUpInside)
        nextPictureButton.addTarget(self, action: #selector(nextPictureTapped),for: .touchUpInside)
        deleteImageButton.addTarget(self, action: #selector(deleteImageTapped), for: .touchUpInside)
        
        let stack = UIStackView(arrangedSubviews: [
            previousPictureButton,
            favoriteButton,
            deleteImageButton,
            nextPictureButton
        ])

        stack.axis = .horizontal
        stack.spacing = 36
        stack.alignment = .center
        stack.distribution = .equalCentering

        buttonsContainer.addSubview(stack)

        stack.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }


    private func goBack() {
        if currentIndex >= 0 && currentIndex < imageNamesArray.count {
            let imageName = imageNamesArray[currentIndex]
            saveLoadManager.savePictureText(infoAboutPictureTextField.text ?? "",for: imageName)
        }

        navigationController?.popViewController(animated: true)
    }

    
    @objc private func backButtonTapped(_ sender: UIButton) {
        goBack()
    }
    
    private func configureNotifications(){
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShow(_:)),
            name: UIResponder.keyboardWillShowNotification,
            object: nil)
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillHide(_:)),
            name: UIResponder.keyboardWillHideNotification,
            object: nil)
    }
    
    @objc private func keyboardWillShow(_ notification: Notification) {
        guard let userInfo = notification.userInfo,
              let frame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect,
              let duration = userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? TimeInterval else { return }
        
        containerView.snp.updateConstraints { make in
            make.bottom.equalToSuperview().inset(frame.height)
        }
        UIView.animate(withDuration: duration) {
            self.view.layoutIfNeeded()
        }
    }
    @objc private func keyboardWillHide(_ notification: Notification) {
        guard let userInfo = notification.userInfo,
              let duration = userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double else { return }
        
        containerView.snp.updateConstraints { make in
            make.bottom.equalToSuperview()
        }
        UIView.animate(withDuration: duration) {
            self.view.layoutIfNeeded()
        }
    }
    @objc private func closeKeyboardTap() {
        infoAboutPictureTextField.endEditing(true)
    }
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc private func nextPictureTapped() {
        guard !imageNamesArray.isEmpty else { return }

        currentIndex = (currentIndex + 1) % imageNamesArray.count
        showImage(at: currentIndex)
    }
    
    @objc private func previousPictureTapped() {
        guard !imageNamesArray.isEmpty else { return }

        currentIndex = (currentIndex - 1 + imageNamesArray.count) % imageNamesArray.count
        showImage(at: currentIndex)
    }
    private func showImage(at index: Int) {
        guard index >= 0, index < imageNamesArray.count else { return }
        let imageName = imageNamesArray[index]
        if let image = saveLoadManager.loadImage(filename: imageName) {
            pictureView.image = image
            infoAboutPictureTextField.text =
                    saveLoadManager.loadPictureText(for: imageName)
        }
        updateFavoriteButtonState()
    }
    
    private func deleteImage(at index: Int) {
        guard index >= 0, index < imageNamesArray.count else { return }

        let imageName = imageNamesArray[index]

        // удаляем из storage
        saveLoadManager.deleteImage(named: imageName)

        // удаляем из локального массива
        imageNamesArray.remove(at: index)

        // корректируем индекс
        if currentIndex >= imageNamesArray.count {
            currentIndex = max(imageNamesArray.count - 1, 0)
        }

        // обновляем экран
        if imageNamesArray.isEmpty {
            pictureView.image = UIImage(named: "emptyLibrary")
            infoAboutPictureTextField.isHidden = true
            favoriteButton.isHidden = true
            previousPictureButton.isHidden = true
            nextPictureButton.isHidden = true
            deleteImageButton.isHidden = true
        } else {
            showImage(at: currentIndex)
        }
    }
    
    private func updateFavoriteButtonState() {
        guard imageNamesArray.indices.contains(currentIndex) else { return }

            let imageName = imageNamesArray[currentIndex]
            let favorites = saveLoadManager.loadFavoritesImageNames()
            let isFavorite = favorites.contains(imageName)

        let symbolName = isFavorite ? "heart.fill" : "heart"

            let config = UIImage.SymbolConfiguration(
                pointSize: FontSize.prevAndNextButtonTextSize.size,
                weight: .semibold
            )

            let image = UIImage(systemName: symbolName, withConfiguration: config)
            favoriteButton.setImage(image, for: .normal)
    }
    @objc private func addOrDeletoFromFavorite() {
        guard imageNamesArray.indices.contains(currentIndex) else { return }

            let imageName = imageNamesArray[currentIndex]
            let favorites = saveLoadManager.loadFavoritesImageNames()

            if favorites.contains(imageName) {
                saveLoadManager.removeFavoritesImageName(imageName)
            } else {
                saveLoadManager.saveFavoritiesImgeName(imageName)
            }
            updateFavoriteButtonState()
    }
    
    @objc private func deleteImageTapped() {
        deleteImage(at: currentIndex)
    }
}

extension AllPictureViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool{
        textField.endEditing(true)
        return true
    }
}

