//
//  AppDelegate.swift
//  APIShowCase
//
//  Created by Vasiliy Shannikov on 25.03.2024.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow()

        let viewModel = CategoriesViewModel(client: Network())
        window?.rootViewController = UINavigationController(
            rootViewController: CategoriesViewController(viewModel: viewModel)
        )
        
        window?.makeKeyAndVisible()

        return true
    }
}

