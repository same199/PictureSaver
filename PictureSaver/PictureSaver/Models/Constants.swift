//
//  Constants.swift
//  PictureSaver
//
//  Created by Artsiom Stulba on 20.12.25.
//
import UIKit

public enum Numbers: String {
    case one = "1"
    case two = "2"
    case three = "3"
    case four = "4"
    case five = "5"
    case six = "6"
    case seven = "7"
    case eight = "8"
    case nine = "9"
    case zero = "0"
}

public enum AppStrings: String {
    case enterPinText = "Please, enter the PIN"
    case defaultPinTextState = "○ ○ ○ ○"
    case firstSymbolEnteringTextState = "● ○ ○ ○"
    case secondSymbolEnteringTextState = "● ● ○ ○"
    case thirdSymbolEnteringTextState = "● ● ● ○"
    case fourthSymbolEnteringTextState = "● ● ● ●"
    case createNewPin = "Please, create new PIN"
    case confirmNewPin = "Confirm new PIN"
    case pinCorrect = "PIN is correct"
    case pinNotCorrect = "PIN is incorrect"
    case clearPinButtonTuttle = "⭠"
    case confirmPin = "Ok"
    case addPhotoButtonTitle = "+"
    case libraryButtonTitle = "All pictures"
    case addPictureScreenTitle = "Add picture"
    case libraryScreenTitle = "Library"
    case cameraAction = "Take a photo"
    case galleryAction = "Open gallery"
    case cancelAction = "Cancel"
    case addPictureAlertTitle = "Please, choose an action"
    case pictureInformationPlaceholder = "Add additional info..."
    case previousPictureButtonTitle = "< Prev"
    case nextPictureButtonTitle = "Next >"
}

public enum ButtonsParams: CGFloat{
    case buttonSize = 72
    case addPictureButtonSizeWidthAndHeight = 84
    case allPicturesButtonWidth = 160
    case allPicturesButtonHeight = 32
    case allPicturesButtonCornerRadius = 8
    case verticalSpacing = 16
    case horizontalSpacing = 24
    case allPicturesButtonVerticalSpacing = 36
    case allPicturesButtonHorizontalSpacing = 20
    case backButtonSize = 64
}

public enum Offsets: CGFloat {
    case topOffset = 100
    case bottomOffset = 24
    case offsetBetweenTextAndPin = 12
    case offsetBetweenNewAndConfirmPin = 60
    case textFieldLeftAndRightOffset = 36
    
    
}

public enum PinCreationStep {
    case create
    case confirm
}

public enum PinLength: Int {
    case four = 4
}

public enum ElementsColors {
    case numbersButtonColor
    case addPictureButtonColor
    case clearButtonColor
    case confirmButtonColor
    case titleTextColor
    case incorrectPinTextColor
    case correctPinTextColor
    case pinTextColor
    case backgroundColor
    
    var color: UIColor{
        switch self {
        case .numbersButtonColor:
            return .systemGray6
        case .clearButtonColor:
            return .systemGray6
        case .confirmButtonColor:
            return .clear
        case .titleTextColor:
            return .white
        case .incorrectPinTextColor:
            return .systemRed
        case .correctPinTextColor:
            return .systemGreen
        case .pinTextColor:
            return .white
        case .backgroundColor:
            return .black
        case .addPictureButtonColor:
            return .systemGray6
        }
    }
}

public enum ImageViewParams: CGFloat{
    case widthAndHeightBeforeAddPicture = 84
    case widthAndHeightAfterAddPicture = 260
}

public enum TextFieldParams: CGFloat{
    case height = 48
}

public enum PrevAndNextButtonsParams: CGFloat{
    case previousAndNextButtonWidth = 120
    case previousAndNextButtonHeight = 36
}

