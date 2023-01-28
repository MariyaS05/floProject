//
//  SceneDelegate.swift
//  floProject2
//
//  Created by Мария  on 4.09.22.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window?.windowScene =  windowScene
        window?.makeKeyAndVisible()
        window?.rootViewController = createRegistrationVC()
        window?.backgroundColor = .white
        UINavigationBar.appearance().tintColor = .black
        
    }
    func createRegistrationVC()->UINavigationController{
        let registrationVC =  StartPageViewController()
        registrationVC.title = "Aккаунт"
        return UINavigationController(rootViewController: registrationVC)
    }
    
    func createAdvicesNC()->UINavigationController {
        let advicesVC =  AdvicesViewController()
        advicesVC.title = "Советы"
        advicesVC.tabBarItem = UITabBarItem(title: advicesVC.title, image: UIImage(systemName:SFSymbols.advices), tag: 1)
        UINavigationBar.appearance().tintColor = .black
        return UINavigationController(rootViewController: advicesVC)
    }
    func createCalendarNC()-> UINavigationController {
        let calendarVC =  CalendarViewController()
        calendarVC.title = "Сегодня"
        calendarVC.tabBarItem = UITabBarItem(title: calendarVC.title, image: UIImage(systemName: SFSymbols.calendar), tag: 0)
        UINavigationBar.appearance().tintColor = .black
        return UINavigationController(rootViewController: calendarVC)
    }
    
    func createTabBarController()-> UITabBarController {
        let tabBar = UITabBarController()
        UITabBar.appearance().tintColor = .black
        tabBar.viewControllers = [createCalendarNC(),createAdvicesNC()]
        return tabBar
    }
    
    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }
    
    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }
    
    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }
    
    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }
    
    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }
    func changeRootViewController(animated: Bool = true) {
        guard let window = self.window else {
            return
        }
        let vc = createTabBarController()
        window.rootViewController = vc
        UIView.transition(with: window,
                          duration: 1,
                          options: [.transitionCurlUp],
                          animations: nil,
                          completion: nil)
    }
    
    
    
}

