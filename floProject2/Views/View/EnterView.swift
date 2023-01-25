//
//  EnterView.swift
//  floProject2
//
//  Created by Мария  on 13.01.23.
//

import UIKit

class EnterView: UIView {

    let nameTextField =  GFTextField(placeholder: "Введите логин", textContentType: .givenName , secure: false)
    let passwordTextField =  GFTextField(placeholder: "Пароль", textContentType : .oneTimeCode, secure: true)
    private let buttonShowPassword = UIButton()
    let buttonAction =  GFButton(title: "Вход", textColor: .white)
    weak var delegate : StartPageViewControllerDelegate?
    let padding :CGFloat =  10
    var iconClick = true
    var isLoginEntered : Bool { return !nameTextField.text!.isEmpty}
    var isPasswordEntered : Bool { return !passwordTextField.text!.isEmpty}
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureButton()
        configure()
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
        nameTextField.delegate =  self
        passwordTextField.delegate =  self
       
        buttonAction.backgroundColor = Color.blue
        buttonAction.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        
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
    @objc func buttonTapped(){
        guard isLoginEntered && isPasswordEntered else {
                      delegate?.textFieldIsEmpty()
                      return
                  }
        let loginText = nameTextField.text
        let passwordText = passwordTextField.text
        let user : User = User(login: loginText ?? "", password: passwordText ?? "" )
        if LocalStorageManager.getUser().contains(where: { $0.login == user.login && $0.password == user.password}) {
            delegate?.enterButtonTapped()
       } else {
           delegate?.uncorrectLogin()
       }
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
extension EnterView : UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard isLoginEntered && isPasswordEntered else {
            delegate?.textFieldIsEmpty()
            return false
        }
        return true
    }
}
   

