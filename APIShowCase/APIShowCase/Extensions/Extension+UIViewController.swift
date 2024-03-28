//
//  Extension+UIViewController.swift
//  APIShowCase
//
//  Created by Vasiliy Shannikov on 26.03.2024.
//


import UIKit

extension UIViewController {
    func showAlert(with message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default)
        alert.addAction(action)

        present(alert, animated: true)
    }

    func setupNavigationBar(with title: String) {
        let backButton = UIBarButtonItem(image: UIImage(named: "chevron.left"),
                                         style: .plain,
                                         target: self,
                                         action: #selector(backButtonTapped))
        navigationItem.leftBarButtonItem = backButton
        self.title = title
        navigationController?.navigationBar.tintColor = .black
    }

    @objc private func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }

    func showLoader() {
        let loader = LoaderView(frame: view.bounds)
        view.addSubview(loader)
        loader.startAnimating()
    }

    func hideLoader() {
        guard let loaderView = view.subviews.last as? LoaderView else { return }

        loaderView.stopAnimating()
        loaderView.removeFromSuperview()
    }
}
