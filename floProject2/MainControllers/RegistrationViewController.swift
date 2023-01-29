//
//  RegistrationViewController.swift
//  floProject2
//
//  Created by Мария  on 14.01.23.
//

import UIKit

class RegistrationViewController: UIViewController {
    
    let nameTextField =  TextField(placeholder: "Ваше имя", textContentType: .name, secure: false)
    let emailTextField =  TextField(placeholder: "E-mail", textContentType: .emailAddress, secure: false)
    var dateOfBirthPicker =  UIDatePicker()
    var dateOfPeriodPicker =  UIDatePicker()
    let loginLabel =  TitleLabel(fontSize: 24, weight: .heavy, textAlignment: .center)
    let dateOfBirthLabel =  TitleLabel(fontSize: 20, weight: .medium, textAlignment: .left)
    let dateOfPeriodLabel =  TitleLabel(fontSize: 20, weight: .medium, textAlignment: .left)
    let buttonCreateAnAccount = Button(title: "Зарегистироваться", textColor: .white)
    var isNameEntered : Bool { return !nameTextField.text!.isEmpty}
    var isEmailEntered : Bool { return !emailTextField.text!.isEmpty}
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBar()
        presentAlert(title: "Чего-то не хватает", message: "Для составление более точного проноза и успешной регистрации,пожалуйтста, заполните информацию о себе.", buttonTitle: "Ок")
        configureDataPicker()
        configure()
        configureButton()
        createDissmissKeyboardTapGesture()
    }
    
    func createDissmissKeyboardTapGesture(){
        let tap = UITapGestureRecognizer(target: self.view, action:#selector(UIView.endEditing))
        view.addGestureRecognizer(tap)
    }
    private func configureButton(){
        buttonCreateAnAccount.backgroundColor = Color.blue
        buttonCreateAnAccount.addTarget(self, action: #selector(createTapped), for: .touchUpInside)
    }
    func configureDataPicker(){
        view.addSubview(dateOfBirthPicker)
        view.addSubview(dateOfPeriodPicker)
        dateOfBirthPicker.preferredDatePickerStyle = .wheels
        dateOfBirthPicker.datePickerMode = .date
        dateOfPeriodPicker.datePickerMode = .date
        dateOfPeriodPicker.preferredDatePickerStyle = .automatic
        dateOfBirthLabel.text =  "Отметьте дату рождения"
        dateOfPeriodLabel.text = "Выберите дату начала последних месячных"
        dateOfPeriodPicker.translatesAutoresizingMaskIntoConstraints =  false
        dateOfBirthPicker.translatesAutoresizingMaskIntoConstraints =  false
        dateOfBirthPicker.maximumDate =  Date()
        dateOfPeriodPicker.maximumDate =  Date()
    }
    private func configure(){
        view.backgroundColor =  UIColor(patternImage: UIImage(named: "firstBackground")!)
        
        let padding : CGFloat =  20
        let paddingElements : CGFloat =  40
        let labelHeight : CGFloat =  40
        
        view.addSubview(nameTextField)
        view.addSubview(emailTextField)
        view.addSubview(loginLabel)
        view.addSubview(dateOfBirthLabel)
        view.addSubview(dateOfPeriodLabel)
        view.addSubview(buttonCreateAnAccount)
        
        nameTextField.delegate =  self
        emailTextField.delegate =  self
        
        loginLabel.text = "Привет,\(LocalStorageManager.getUser()[0].login)"
        
        let views = [nameTextField,emailTextField,loginLabel,dateOfPeriodLabel,dateOfBirthLabel,dateOfBirthPicker,dateOfPeriodPicker,buttonCreateAnAccount]
        for viewCustom in views {
            NSLayoutConstraint.activate([
                viewCustom.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
                viewCustom.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding)
            ])
        }
        NSLayoutConstraint.activate([
            loginLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: padding),
            loginLabel.heightAnchor.constraint(equalToConstant: 30),
            
            nameTextField.topAnchor.constraint(equalTo: loginLabel.bottomAnchor, constant: paddingElements),
            nameTextField.heightAnchor.constraint(equalToConstant: labelHeight),
            
            emailTextField.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: paddingElements),
            emailTextField.heightAnchor.constraint(equalToConstant: labelHeight),
            
            dateOfBirthLabel.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: paddingElements),
            dateOfBirthLabel.heightAnchor.constraint(equalToConstant: labelHeight),
            
            dateOfBirthPicker.topAnchor.constraint(equalTo: dateOfBirthLabel.bottomAnchor,constant: padding),
            dateOfBirthPicker.heightAnchor.constraint(equalToConstant: labelHeight*3),
            
            dateOfPeriodLabel.topAnchor.constraint(equalTo: dateOfBirthPicker.bottomAnchor, constant: paddingElements/2),
            dateOfPeriodLabel.heightAnchor.constraint(equalToConstant: labelHeight*2),
            
            dateOfPeriodPicker.topAnchor.constraint(equalTo: dateOfPeriodLabel.bottomAnchor,constant: padding/2),
            dateOfPeriodPicker.heightAnchor.constraint(equalToConstant: labelHeight),
            
            buttonCreateAnAccount.topAnchor.constraint(equalTo: dateOfPeriodPicker.bottomAnchor, constant: padding),
            buttonCreateAnAccount.heightAnchor.constraint(equalToConstant: labelHeight)
            
        ])
    }
    
    private func setNavigationBar(){
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "multiply"), style: .plain,target: self, action: #selector(dismissVC))
        self.title = "Регистрация пользователя"
    }
    @objc func createTapped(){
        guard isNameEntered && isEmailEntered else {
            presentAlert(title: "Что-то пошло не так!", message: "Проверьте введенное имя и e-mail.", buttonTitle: "Ок")
            return
        }
        var userInfo : UserInfo = UserInfo(login: LocalStorageManager.getUser()[0].login, password: LocalStorageManager.getUser()[0].password, name: nameTextField.text!, email: emailTextField.text!, dateOfBirth: dateOfBirthPicker.date, dateOfPeriod: dateOfPeriodPicker.date)
        userInfo.dateOfNextPeriod = getNewDate(from: userInfo.dateOfPeriod, with: DaysOfPeriod.cycleTime)
        LocalStorageManager.saveUserInfo(userInfo: userInfo)
        dismissVC()
    }
    @objc func dismissVC(){
        self.dismiss(animated: true) {
        }
    }
}
extension RegistrationViewController : UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard isNameEntered && isEmailEntered else {
            presentAlert(title: "Что-то пошло не так!", message: "Проверьте введенное имя и e-mail.", buttonTitle: "Ок")
            return false
        }
        return true
    }
}

