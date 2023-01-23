//
//  RegistrationView.swift
//  floProject2
//
//  Created by Мария  on 13.01.23.
//

import UIKit

class RegistrationView: UIView, UITextFieldDelegate {

    let nameTextField =  GFTextField(placeholder: "Введите логин", textContentType: .name,secure: false )
    let passwordTextField =  GFTextField(placeholder: "Пароль",textContentType : .oneTimeCode, secure: true)
   private let buttonShowPassword = UIButton()
    let buttonAction =  GFButton(title: "Регистрация", textColor: .white)
    let labelOfText = UILabel()
    private let padding :CGFloat =  10
    var isLoginEntered : Bool { return !nameTextField.text!.isEmpty}
    var isPasswordEntered : Bool { return !passwordTextField.text!.isEmpty}
    weak var delegate : StartPageViewControllerDelegate?
    private var iconClick = true
   
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureButton()
        configure()
        configureLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func configureButton(){
        buttonShowPassword.setImage(UIImage(systemName: "eye.slash"), for: .normal)
        buttonShowPassword.addTarget(self, action: #selector(buttonShowPasswordTapped), for: .touchUpInside)
        passwordTextField.rightView = buttonShowPassword
        passwordTextField.rightViewMode = .always
    }
    private func configure(){
    
        translatesAutoresizingMaskIntoConstraints =  false
        addSubview(nameTextField)
        addSubview(passwordTextField)
        addSubview(buttonAction)
        buttonAction.backgroundColor = Color.blue
        passwordTextField.delegate =  self
        nameTextField.delegate =  self
        buttonAction.addTarget(self, action: #selector(buttonRegistrationTapped), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            nameTextField.topAnchor.constraint(equalTo: self.topAnchor, constant: padding),
            nameTextField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: padding),
            nameTextField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -padding),
            nameTextField.heightAnchor.constraint(equalToConstant: 40),
            
            passwordTextField.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: padding*2),
            passwordTextField.leadingAnchor.constraint(equalTo: nameTextField.leadingAnchor),
            passwordTextField.trailingAnchor.constraint(equalTo: nameTextField.trailingAnchor),
            passwordTextField.heightAnchor.constraint(equalToConstant: 40),
            
            buttonAction.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 50),
            buttonAction.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: padding),
            buttonAction.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -padding),
            buttonAction.heightAnchor.constraint(equalToConstant: 50)

        ])
    }
    func configureLabel(){
        labelOfText.translatesAutoresizingMaskIntoConstraints =  false
        labelOfText.text = "Пароль должен содержать не меньше 8 символов,включая прописную букву,заглавную букву и число."
        addSubview(labelOfText)
        labelOfText.numberOfLines =  2
        labelOfText.font = UIFont.systemFont(ofSize: 10)
        labelOfText.textColor = .secondaryLabel
        labelOfText.textAlignment = .left
        
        NSLayoutConstraint.activate([
            labelOfText.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor,constant: 5),
            labelOfText.leadingAnchor.constraint(equalTo: self.leadingAnchor,constant: padding),
            labelOfText.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -padding),
            labelOfText.heightAnchor.constraint(equalToConstant: 25)
            
        ])
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard isLoginEntered && isPasswordEntered else {
            delegate?.textFieldIsEmpty()
            return false
        }
        return true
    }
    
    @objc func buttonRegistrationTapped(){
        guard isLoginEntered && isPasswordEntered else {
                      delegate?.textFieldIsEmpty()
                      return
                  }
        let loginText = nameTextField.text
        let passwordText = passwordTextField.text
        let user : User = User(login: loginText ?? "", password: passwordText ?? "" )
        LocalStorageManager.saveUser( user: user)
        let users: [User] = LocalStorageManager.getUser()
        print(users)
        delegate?.showRegistrationVC()
    }
    @objc func buttonShowPasswordTapped(){
        if iconClick {
            passwordTextField.isSecureTextEntry = false
          } else {
              passwordTextField.isSecureTextEntry = true
          }
          iconClick = !iconClick
      }
}
