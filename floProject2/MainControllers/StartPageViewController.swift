//
//  RegistrationViewController.swift
//  floProject2
//
//  Created by Мария  on 13.01.23.
//

import UIKit
protocol StartPageViewControllerDelegate : AnyObject {
    func enterButtonTapped()
    func textFieldIsEmpty()
    func showRegistrationVC()
    func uncorrectLogin()
}

class StartPageViewController: UIViewController {
    let buttonEnterToApp =  Button(title: "Вход", textColor: .gray)
    let buttonGoToRegistration =  Button(title: "Регистрация", textColor: .gray)
    let containerForRegistration =  RegistrationView(frame: .zero)
    let containerForEnter =  EnterView(frame: .zero)
    let padding : CGFloat =  10
    var isRegistrationButton : Bool =  true
    let stackOfButtons = UIStackView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureButtons()
        configure(subView: containerForRegistration)
        containerForRegistration.delegate =  self
        buttonEnterToApp.addTarget(self, action: #selector(buttonEnterTapped), for: .touchUpInside)
        buttonGoToRegistration.addTarget(self, action: #selector(buttonRegistrationTapped), for: .touchUpInside)
        
    }
    func configureButtons(){
        stackOfButtons.addArrangedSubview(buttonGoToRegistration)
        stackOfButtons.addArrangedSubview(buttonEnterToApp)
        stackOfButtons.axis = .horizontal
        stackOfButtons.distribution = .fillEqually
        stackOfButtons.spacing =  padding
        view.addSubview(stackOfButtons)
        stackOfButtons.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            stackOfButtons.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: padding),
            stackOfButtons.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            stackOfButtons.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            stackOfButtons.heightAnchor.constraint(equalToConstant: 40)
        ])
        if isRegistrationButton {
            buttonGoToRegistration.changeTitleColorToBlue()
            buttonEnterToApp.changeTitleColorToGray()
        }
    }
    func configure(subView : UIView){
        view.backgroundColor =  UIColor(patternImage: UIImage(named: "firstBackground")!)
        self.view.addSubview(subView)
        NSLayoutConstraint.activate([
            subView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            subView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            subView.topAnchor.constraint(equalTo: stackOfButtons.bottomAnchor,constant: 150),
            subView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor)
        ])
    }
    @objc func buttonEnterTapped(){
        isRegistrationButton =  false
        buttonGoToRegistration.changeTitleColorToGray()
        buttonEnterToApp.changeTitleColorToBlue()
        configure(subView:containerForEnter)
        containerForEnter.delegate =  self
        containerForRegistration.removeFromSuperview()
    }
    @objc func buttonRegistrationTapped(){
        isRegistrationButton =  true
        buttonGoToRegistration.changeTitleColorToBlue()
        buttonEnterToApp.changeTitleColorToGray()
        configure(subView: containerForRegistration)
        containerForEnter.removeFromSuperview()
    }
}
extension StartPageViewController : StartPageViewControllerDelegate {
    func uncorrectLogin() {
        presentAlert(title: "Неверный логин/пароль", message: "Вы ввели неверный логин или пароль.Проверьте введенные Вами данные.", buttonTitle: "Ок")
    }
    
    func showRegistrationVC() {
        let vc =  RegistrationViewController()
        let navVC =  UINavigationController(rootViewController: vc)
        navVC.modalPresentationStyle = .fullScreen
        self.navigationController?.present(navVC, animated: true)
    }
    
    func textFieldIsEmpty() {
        presentAlert(title: "Что-то пошло не так!", message: "Проверьте логин и пароль.", buttonTitle: "Ок")
    }
    func enterButtonTapped() {
        (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(animated: true)
    }
}



