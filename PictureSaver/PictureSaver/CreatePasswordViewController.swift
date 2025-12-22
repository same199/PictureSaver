//
//  CreatePasswordViewController.swift
//  PictureSaver
//
//  Created by Artsiom Stulba on 20.12.25.
//


import UIKit
import SnapKit

class CreatePasswordViewController: UIViewController {
    let saveLoadManager = SaveLoadManager()
    //MARK: add elements numberpad
    private let numberContainer = UIView()
    private let firstLineOfNumbers = UIView()
    private let secondLineOfNumbers = UIView()
    private let thirdLineOfNumbers = UIView()
    private let fourLineOfNumbers = UIView()
    private let fiveLineOfNumbers = UIView()
    private let oneButton: UIButton = {
        let button = UIButton()
        button.setTitle(Numbers.one.rawValue, for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 24)
        button.layer.cornerRadius = ButtonsParams.buttonSize.rawValue / 2
        button.backgroundColor = .systemGray6
        return button
    }()
    private let twoButton: UIButton = {
        let button = UIButton()
        button.setTitle(Numbers.two.rawValue, for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 24)
        button.layer.cornerRadius = ButtonsParams.buttonSize.rawValue / 2
        button.backgroundColor = .systemGray6
        return button
    }()
    private let threeButton: UIButton = {
        let button = UIButton()
        button.setTitle(Numbers.three.rawValue, for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 24)
        button.layer.cornerRadius = ButtonsParams.buttonSize.rawValue / 2
        button.backgroundColor = .systemGray6
        return button
    }()
    private let fourButton: UIButton = {
        let button = UIButton()
        button.setTitle(Numbers.four.rawValue, for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 24)
        button.layer.cornerRadius = ButtonsParams.buttonSize.rawValue / 2
        button.backgroundColor = .systemGray6
        return button
    }()
    private let fiveButton: UIButton = {
        let button = UIButton()
        button.setTitle(Numbers.five.rawValue, for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 24)
        button.layer.cornerRadius = ButtonsParams.buttonSize.rawValue / 2
        button.backgroundColor = .systemGray6
        return button
    }()
    private let sixButton: UIButton = {
        let button = UIButton()
        button.setTitle(Numbers.six.rawValue, for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 24)
        button.layer.cornerRadius = ButtonsParams.buttonSize.rawValue / 2
        button.backgroundColor = .systemGray6
        return button
    }()
    private let sevenButton: UIButton = {
        let button = UIButton()
        button.setTitle(Numbers.seven.rawValue, for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 24)
        button.layer.cornerRadius = ButtonsParams.buttonSize.rawValue / 2
        button.backgroundColor = .systemGray6
        return button
    }()
    private let eightButton: UIButton = {
        let button = UIButton()
        button.setTitle(Numbers.eight.rawValue, for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 24)
        button.layer.cornerRadius = ButtonsParams.buttonSize.rawValue / 2
        button.backgroundColor = .systemGray6
        return button
    }()
    private let nineButton: UIButton = {
        let button = UIButton()
        button.setTitle(Numbers.nine.rawValue, for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 24)
        button.layer.cornerRadius = ButtonsParams.buttonSize.rawValue / 2
        button.backgroundColor = .systemGray6
        return button
    }()
    private let zeroButton: UIButton = {
        let button = UIButton()
        button.setTitle(Numbers.zero.rawValue, for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 24)
        button.layer.cornerRadius = ButtonsParams.buttonSize.rawValue / 2
        button.backgroundColor = .systemGray6
        return button
    }()
    private let clearButton: UIButton = {
        let button = UIButton()
        button.setTitle(AppStrings.clearPinButtonTuttle.rawValue, for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 24)
        button.layer.cornerRadius = ButtonsParams.buttonSize.rawValue / 2
        button.backgroundColor = .systemGray6
        return button
    }()
    private let confirmPin: UIButton = {
        let button = UIButton()
        button.setTitle(AppStrings.confirmPin.rawValue, for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 24)
        button.layer.cornerRadius = ButtonsParams.buttonSize.rawValue / 2
        button.backgroundColor = .clear
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.borderWidth = 1
        return button
    }()
    
    //MARK: add elements pincode
    private let pinLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        label.textColor = .white
        label.text = AppStrings.defaultPinTextState.rawValue
        return label
    }()
    private let confirmPinLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        label.textColor = .white
        label.text = AppStrings.defaultPinTextState.rawValue
        return label
    }()
    private let pinLabelText: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 24)
        label.textColor = .white
        label.text = AppStrings.createNewPin.rawValue
        return label
    }()
    private let pinLabelConfirmText: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 24)
        label.textColor = .white
        label.text = AppStrings.confirmNewPin.rawValue
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    //MARK: configure UI
    private func configureUI(){
        view.backgroundColor = .black
        
        view.addSubview(numberContainer)
        
        numberContainer.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(Offsets.bottomOffset.rawValue)
        }
        view.addSubview(confirmPinLabel)
        confirmPinLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(numberContainer.snp.top).offset(-(Offsets.topOffset.rawValue))
        }
        confirmPinLabel.isHidden = true
        view.addSubview(pinLabelConfirmText)
        pinLabelConfirmText.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.left.right.equalToSuperview()
            make.bottom.equalTo(confirmPinLabel.snp.top).offset(-(Offsets.offsetBetweenTextAndPin.rawValue))
        }
        pinLabelConfirmText.isHidden = true
        view.addSubview(pinLabel)
        pinLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(pinLabelConfirmText.snp.top).offset(-(Offsets.offsetBetweenNewAndConfirmPin.rawValue))
        }
        view.addSubview(pinLabelText)
        pinLabelText.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.left.right.equalToSuperview()
            make.bottom.equalTo(pinLabel.snp.top).offset(-(Offsets.offsetBetweenTextAndPin.rawValue))
        }
        
        // ----------- First line -----------
        numberContainer.addSubview(firstLineOfNumbers)
        firstLineOfNumbers.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(4)
            make.centerX.equalToSuperview()
            make.height.equalTo(ButtonsParams.buttonSize.rawValue)
            make.left.right.equalToSuperview()
        }
        firstLineOfNumbers.addSubview(oneButton)
        firstLineOfNumbers.addSubview(twoButton)
        firstLineOfNumbers.addSubview(threeButton)
        
        twoButton.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.size.equalTo(ButtonsParams.buttonSize.rawValue)
        }
        twoButton.addTarget(self, action: #selector(numberButtonTapped(_:)), for: .touchUpInside)
        
        oneButton.snp.makeConstraints { make in
            make.centerY.equalTo(twoButton)
            make.right.equalTo(twoButton.snp.left)
                .offset(-ButtonsParams.horizontalSpacing.rawValue)
            make.size.equalTo(twoButton)
        }
        oneButton.addTarget(self, action: #selector(numberButtonTapped(_:)), for: .touchUpInside)
        threeButton.snp.makeConstraints { make in
            make.centerY.equalTo(twoButton)
            make.left.equalTo(twoButton.snp.right)
                .offset(ButtonsParams.horizontalSpacing.rawValue)
            make.size.equalTo(twoButton)
        }
        threeButton.addTarget(self, action: #selector(numberButtonTapped(_:)), for: .touchUpInside)
        
        // ----------- Second line -----------
        numberContainer.addSubview(secondLineOfNumbers)
        secondLineOfNumbers.snp.makeConstraints { make in
            make.top.equalTo(firstLineOfNumbers.snp.bottom)
                .offset(ButtonsParams.verticalSpacing.rawValue)
            make.centerX.equalToSuperview()
            make.height.equalTo(ButtonsParams.buttonSize.rawValue)
            make.left.right.equalToSuperview()
        }
        secondLineOfNumbers.addSubview(fourButton)
        secondLineOfNumbers.addSubview(fiveButton)
        secondLineOfNumbers.addSubview(sixButton)
        
        fiveButton.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.size.equalTo(ButtonsParams.buttonSize.rawValue)
        }
        fiveButton.addTarget(self, action: #selector(numberButtonTapped(_:)), for: .touchUpInside)
        fourButton.snp.makeConstraints { make in
            make.centerY.equalTo(fiveButton)
            make.right.equalTo(fiveButton.snp.left)
                .offset(-ButtonsParams.horizontalSpacing.rawValue)
            make.size.equalTo(fiveButton)
        }
        fourButton.addTarget(self, action: #selector(numberButtonTapped(_:)), for: .touchUpInside)
        sixButton.snp.makeConstraints { make in
            make.centerY.equalTo(fiveButton)
            make.left.equalTo(fiveButton.snp.right)
                .offset(ButtonsParams.horizontalSpacing.rawValue)
            make.size.equalTo(fiveButton)
        }
        sixButton.addTarget(self, action: #selector(numberButtonTapped(_:)), for: .touchUpInside)
        
        // ----------- Third line -----------
        numberContainer.addSubview(thirdLineOfNumbers)
        thirdLineOfNumbers.snp.makeConstraints { make in
            make.top.equalTo(secondLineOfNumbers.snp.bottom)
                .offset(ButtonsParams.verticalSpacing.rawValue)
            make.centerX.equalToSuperview()
            make.height.equalTo(ButtonsParams.buttonSize.rawValue)
            make.left.right.equalToSuperview()
        }
        thirdLineOfNumbers.addSubview(sevenButton)
        thirdLineOfNumbers.addSubview(eightButton)
        thirdLineOfNumbers.addSubview(nineButton)
        
        eightButton.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.size.equalTo(ButtonsParams.buttonSize.rawValue)
        }
        eightButton.addTarget(self, action: #selector(numberButtonTapped(_:)), for: .touchUpInside)
        sevenButton.snp.makeConstraints { make in
            make.centerY.equalTo(eightButton)
            make.right.equalTo(eightButton.snp.left)
                .offset(-ButtonsParams.horizontalSpacing.rawValue)
            make.size.equalTo(eightButton)
        }
        sevenButton.addTarget(self, action: #selector(numberButtonTapped(_:)), for: .touchUpInside)
        nineButton.snp.makeConstraints { make in
            make.centerY.equalTo(eightButton)
            make.left.equalTo(eightButton.snp.right)
                .offset(ButtonsParams.horizontalSpacing.rawValue)
            make.size.equalTo(eightButton)
        }
        nineButton.addTarget(self, action: #selector(numberButtonTapped(_:)), for: .touchUpInside)
        
        // ----------- Fourth line -----------
        numberContainer.addSubview(fourLineOfNumbers)
        fourLineOfNumbers.snp.makeConstraints { make in
            make.top.equalTo(thirdLineOfNumbers.snp.bottom)
                .offset(ButtonsParams.verticalSpacing.rawValue)
            make.centerX.equalToSuperview()
            make.height.equalTo(ButtonsParams.buttonSize.rawValue)
            make.bottom.equalToSuperview()
            make.left.right.equalToSuperview()
        }
        fourLineOfNumbers.addSubview(zeroButton)
        zeroButton.snp.makeConstraints { make in
                make.center.equalToSuperview()
                make.size.equalTo(ButtonsParams.buttonSize.rawValue)
        }
        zeroButton.addTarget(self, action: #selector(numberButtonTapped(_:)), for: .touchUpInside)
        fourLineOfNumbers.addSubview(clearButton)
        clearButton.snp.makeConstraints { make in
            make.size.equalTo(ButtonsParams.buttonSize.rawValue)
            make.centerY.equalTo(zeroButton)
            make.centerX.equalTo(sevenButton)
        }
        clearButton.addTarget(self, action: #selector(clearButtonTapped(_:)), for: .touchUpInside)
        fourLineOfNumbers.addSubview(confirmPin)
        confirmPin.snp.makeConstraints { make in
            make.size.equalTo(ButtonsParams.buttonSize.rawValue)
            make.centerY.equalTo(zeroButton)
            make.centerX.equalTo(nineButton)
        }
        confirmPin.addTarget(self, action: #selector(okButtonTapped(_:)), for: .touchUpInside)
    
        
    }
    
    @objc private func numberButtonTapped(_ sender: UIButton) {
        guard let number = sender.currentTitle else { return }
        guard enteredPin.count < maxPinLength else { return }
        
        enteredPin.append(number)
        updatePinLabels()
        
        if enteredPin.count == maxPinLength {
            pinLabelConfirmText.isHidden = false
            createAndConfirmPin()
        }
    }
    @objc private func clearButtonTapped(_ sender: UIButton) {
        
        step = .create
        firstPin = ""
        enteredPin = ""
        hiddenConfirmPin()
        defaultPinState()
        //defaultPinState()
        //updatePinLabels()
    }
    
    @objc private func okButtonTapped(_ sender: UIButton) {
        savePin()
        let controller = MainScreenViewController()
        navigationController?.pushViewController(controller, animated: true)
    }
    
    private var step: PinCreationStep = .create
    private var firstPin = ""
    private var enteredPin = ""
    private let maxPinLength = PinLength.four.rawValue
    private func updatePinLabels() {
        switch step {
            case .create:
                pinLabel.text = maskedText(for: enteredPin.count)

            case .confirm:
                pinLabel.text = maskedText(for: firstPin.count)
                confirmPinLabel.isHidden = false
                confirmPinLabel.text = maskedText(for: enteredPin.count)
            }
    }
    
    private func pinIsCorrect(){
        pinLabelText.textColor = .green
        pinLabelText.text = AppStrings.pinCorrect.rawValue
    }
    
    private func pinIsIncorrect(){
        pinLabelText.textColor = .red
        pinLabelText.text = AppStrings.pinNotCorrect.rawValue
    }
    
    private func defaultPinState(){
        pinLabel.text = AppStrings.defaultPinTextState.rawValue
        pinLabelText.text = AppStrings.createNewPin.rawValue
        pinLabelText.textColor = .white
    }
    
    private func createAndConfirmPin() {
        switch step {
        case .create:
            firstPin = enteredPin
            enteredPin = ""
            step = .confirm
        case .confirm:
            if enteredPin == firstPin {
                hiddenConfirmPin()
                pinIsCorrect()
            } else {
                pinIsIncorrect()
                hiddenConfirmPin()
            }
        }
    }
    
    private func maskedText(for count: Int) -> String {
        return String(repeating: "●", count: count)
    }
    
    private func savePin() {
        saveLoadManager.save(firstPin)
    }
    
    private func hiddenConfirmPin() {
        confirmPinLabel.isHidden = true
        pinLabelConfirmText.isHidden = true
    }
    
    }
