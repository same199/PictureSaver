//
//  AddPictureViewController.swift
//  PictureSaver
//
//  Created by Artsiom Stulba on 20.12.25.
//


import UIKit
import SnapKit

class AddPictureViewController: UIViewController {
    
    private let saveLoadManager = SaveLoadManager()
    
    private let containerView = UIView()
    private var selectedImage: UIImage?
    private let backButton: UIButton = {
        let button = UIButton()
        button.setTitle(AppStrings.clearPinButtonTuttle.rawValue, for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 32)
        button.backgroundColor = ElementsColors.confirmButtonColor.color
        return button
    }()
    
    private let addPictureScreenName: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 28)
        label.textColor = ElementsColors.pinTextColor.color
        label.text = AppStrings.addPictureScreenTitle.rawValue
        return label
    }()
    private let pictureView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.isUserInteractionEnabled = true
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
    private let addPictireLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 48)
        label.textColor = ElementsColors.backgroundColor.color
        label.text = AppStrings.addPhotoButtonTitle.rawValue
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureNotifications()
        
    }
    private func configureUI() {
        view.addSubview(containerView)
        containerView.backgroundColor = ElementsColors.backgroundColor.color
        containerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        containerView.addSubview(backButton)
        backButton.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(ButtonsParams.allPicturesButtonHorizontalSpacing.rawValue)
            make.top.equalToSuperview().offset(ButtonsParams.allPicturesButtonVerticalSpacing.rawValue)
            make.width.height.equalTo(ButtonsParams.backButtonSize.rawValue)
        }
        backButton.addTarget(self, action: #selector(backButtonTapped(_:)), for: .touchUpInside)
        
        containerView.addSubview(addPictureScreenName)
        addPictureScreenName.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalTo(backButton)
        }
        containerView.addSubview(pictureView)
        pictureView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.height.equalTo(ImageViewParams.widthAndHeightBeforeAddPicture.rawValue)
        }
        pictureView.layer.cornerRadius = ImageViewParams.widthAndHeightBeforeAddPicture.rawValue / 2
        pictureView.addSubview(addPictireLabel)
        addPictireLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview()
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
        setupGestures()
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
    
    private func goBack() {
        if let image = selectedImage {
            if let savedFileName = saveLoadManager.saveImage(image: image) {
                saveLoadManager.saveImageName(savedFileName)
                saveLoadManager.savePictureText(infoAboutPictureTextField.text ?? "", for: savedFileName)
            }
        }
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func backButtonTapped(_ sender: UIButton) {
        goBack()
    }
    
    private func showPicker(_ sourceType: UIImagePickerController.SourceType) {
        let picturePicker = UIImagePickerController()
        picturePicker.delegate = self
        picturePicker.sourceType = sourceType
        present(picturePicker, animated: true)
    }
    
    private func showImagePicker(title: String){
        let alertController = UIAlertController(title: title, message: nil, preferredStyle: .actionSheet)
        let cameraAction = UIAlertAction(title: AppStrings.cameraAction.rawValue, style: .default){ [weak self] _ in
            self?.showPicker(.camera)}
        let galleryAction = UIAlertAction(title: AppStrings.galleryAction.rawValue, style: .default){ [weak self] _ in
            self?.showPicker(.photoLibrary)}
        let cancelAction = UIAlertAction(title: AppStrings.cancelAction.rawValue, style: .cancel)
        alertController.addAction(cameraAction)
        alertController.addAction(galleryAction)
        alertController.addAction(cancelAction)
        present(alertController, animated: true)
    }
    
    private func setupGestures() {
        let gesture = UITapGestureRecognizer(target: self, action: #selector(pictureViewTap))
        pictureView.addGestureRecognizer(gesture)
    }
    
    @objc private func pictureViewTap() {
        showImagePicker(title: AppStrings.addPictureAlertTitle.rawValue)
    }
    
    @objc private func closeKeyboardTap() {
        infoAboutPictureTextField.endEditing(true)
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
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
}

extension AddPictureViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]
    ) {
        guard let image = info[.originalImage] as? UIImage else {
            picker.dismiss(animated: true)
            return
        }
        selectedImage = image
        addPictireLabel.isHidden = true
        pictureView.snp.updateConstraints { make in
            make.width.height.equalTo(ImageViewParams.widthAndHeightAfterAddPicture.rawValue)
        }
        pictureView.layer.cornerRadius = ButtonsParams.allPicturesButtonCornerRadius.rawValue
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
        pictureView.image = image
        picker.dismiss(animated: true)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }
}

extension AddPictureViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool{
        textField.endEditing(true)
        return true
    }
}
