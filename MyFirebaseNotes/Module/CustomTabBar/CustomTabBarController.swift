//
//  CustomTabBarController.swift
//  HW3Module3_LesnoyOleg
//
//  Created by Oleg Lesnoy on 13.06.2024.
//

import UIKit

class CustomTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let homeVC = HomeViewController()
        let favoriteVC = FavoriteViewController()
        let profileVC = ProfileViewController()
        
        let homeNavVC = UINavigationController(rootViewController: homeVC)
        let favoriteNavVC = UINavigationController(rootViewController: favoriteVC)
        let profileNavVC = UINavigationController(rootViewController: profileVC)
        
        
        self.setViewControllers([homeNavVC, favoriteNavVC, profileNavVC], animated: false)
        setTabBar()
        setNavBar(homeNavVC)
        setNavBar(favoriteNavVC)
        setTabItem(vc: homeNavVC, image: UIImage(systemName: "note.text"), title: "Все заметки", tag: 0)
        setTabItem(vc: favoriteNavVC, image: UIImage(systemName: "star.fill"), title: "Избранные", tag: 1)
        setTabItem(vc: profileNavVC, image: UIImage(systemName: "person.crop.circle"), title: "Профиль", tag: 2)
        
    }
}

extension CustomTabBarController {
    private func setTabItem(vc: UIViewController, image: UIImage?, title: String, tag: Int) {
        vc.tabBarItem = UITabBarItem(title: title, image: image, tag: tag)
        if let vc = vc as? UINavigationController {
            vc.navigationBar.prefersLargeTitles = true
        }
    }
    
    private func setTabBar() {
        self.selectedIndex = 0
        
        let tabBarItemAppereance = UITabBarItemAppearance()
        tabBarItemAppereance.configureWithDefault(for: .stacked)
        
        tabBarItemAppereance.normal.iconColor = AppColorSet.TabBar.unselectedItemTintColor
        tabBarItemAppereance.normal.titleTextAttributes = [NSAttributedString.Key.foregroundColor : AppColorSet.TabBar.unselectedItemTintColor]
        tabBarItemAppereance.selected.iconColor = AppColorSet.TabBar.tintColor
        tabBarItemAppereance.selected.titleTextAttributes = [NSAttributedString.Key.foregroundColor : AppColorSet.TabBar.tintColor]
        
        let tabBarAppereance = UITabBarAppearance()
        tabBarAppereance.stackedLayoutAppearance = tabBarItemAppereance
        
        tabBarAppereance.configureWithOpaqueBackground()
        tabBarAppereance.backgroundColor = AppColorSet.TabBar.backgroundColor
        
        tabBar.scrollEdgeAppearance = tabBarAppereance
        tabBar.standardAppearance = tabBarAppereance
    }
    
    private func setNavBar(_ navController: UINavigationController) {
        let navBarAppereance = UINavigationBarAppearance()
        navBarAppereance.configureWithOpaqueBackground()
        navBarAppereance.backgroundColor = AppColorSet.TabBar.backgroundColor
        navBarAppereance.largeTitleTextAttributes = [.foregroundColor: AppColorSet.TabBar.title]
        navBarAppereance.titleTextAttributes = [.foregroundColor: AppColorSet.TabBar.title]
        navController.navigationBar.scrollEdgeAppearance = navBarAppereance
        navController.navigationBar.standardAppearance = navBarAppereance
    }
}
