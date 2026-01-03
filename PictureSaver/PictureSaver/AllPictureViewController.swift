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
        button.setTitle(AppStrings.clearPinButtonTuttle.rawValue, for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 32)
        button.backgroundColor = ElementsColors.confirmButtonColor.color
        return button
    }()
    private let allPictureScreenName: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 28)
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
        button.setTitle(AppStrings.previousPictureButtonTitle.rawValue, for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 24)
        button.contentHorizontalAlignment = .left
        button.titleLabel?.textAlignment = .left
        button.backgroundColor = ElementsColors.confirmButtonColor.color
        return button
    }()
    private let nextPictureButton: UIButton = {
        let button = UIButton()
        button.setTitle(AppStrings.nextPictureButtonTitle.rawValue, for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 24)
        button.contentHorizontalAlignment = .right
        button.titleLabel?.textAlignment = .right
        button.backgroundColor = ElementsColors.confirmButtonColor.color
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureNotifications()
    }
    
    private func configureUI() {
        imageNamesArray = saveLoadManager.loadImageName()
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
        }else
        {
            currentIndex = imageNamesArray.count - 1 // стартуем с последней
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
    }
    
    private func goBack(){
        let imageName = imageNamesArray[currentIndex]
        saveLoadManager.savePictureText(infoAboutPictureTextField.text ?? "", for: imageName)
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
        guard currentIndex < imageNamesArray.count - 1 else { return }
        currentIndex += 1
        showImage(at: currentIndex)
    }
    
    @objc private func previousPictureTapped() {
        guard currentIndex > 0 else { return }
        currentIndex -= 1
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
    }
}

extension AllPictureViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool{
        textField.endEditing(true)
        return true
    }
}

