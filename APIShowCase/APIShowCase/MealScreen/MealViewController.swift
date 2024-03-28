//
//  MealViewController.swift
//  APIShowCase
//
//  Created by Vasiliy Shannikov on 27.03.2024.
//

import UIKit
import SDWebImage
import SnapKit

final class MealViewController: UIViewController {
    let viewModel: MealViewModel

    private lazy var mealImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 8
        imageView.clipsToBounds = true

        return imageView
    }()

    private lazy var textView: UITextView = {
        let textView = UITextView()
        textView.isEditable = false

        return textView
    }()

    private lazy var pageLink: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(linkPressed), for: .touchUpInside)

        return button
    }()

    private lazy var youTubeLink: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(linkPressed), for: .touchUpInside)

        return button
    }()

    init(viewModel: MealViewModel) {
        self.viewModel = viewModel

        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white

        showLoader()

        Task {
            do {
                try await viewModel.getMeal()
                hideLoader()
                guard let model = viewModel.model else {
                    showAlert(with: "No image")

                    return
                }
                setupView(with: model)

            } catch {
                hideLoader()
                showAlert(with: error.localizedDescription)
            }
        }
    }
    
    private func setupView(with model: MealModel) {
        configureViews(model)

        [mealImageView, textView, pageLink, youTubeLink].forEach { view.addSubview($0) }

        mealImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(100)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(350)
        }

        let sizeThatFits = textView.sizeThatFits(CGSize(width: view.bounds.width - 32, height: CGFloat.greatestFiniteMagnitude))
        let optimalHeight = sizeThatFits.height

        textView.snp.makeConstraints { make in
            make.top.equalTo(mealImageView.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
            make.width.equalTo(mealImageView)
            make.height.equalTo(optimalHeight > 250 ? 250 : optimalHeight)
        }

        pageLink.snp.makeConstraints { make in
            make.top.equalTo(textView.snp.bottom).offset(4)
            make.leading.equalTo(mealImageView.snp.leading)
        }

        youTubeLink.snp.makeConstraints { make in
            make.top.equalTo(pageLink.snp.bottom).offset(4)
            make.leading.equalTo(mealImageView.snp.leading)
        }
    }

    private func configureViews(_ model: MealModel) {
        title = model.name
        mealImageView.sd_setImage(with: URL(string: model.imageLink))
        textView.text = model.recipe
        pageLink.setText(text: String(model.pageLink.prefix(20)),
                         color: .blue,
                         size: 14,
                         weight: .regular,
                         alignment: .left)
        youTubeLink.setText(text: String(model.youTubeLink.prefix(20)),
                            color: .blue,
                            size: 14,
                            weight: .regular,
                            alignment: .left)
    }

    @objc private func linkPressed(_ sender: UIButton) {
        guard let model = viewModel.model else { return }

        switch sender {
        case pageLink:
            if let url = URL(string: model.pageLink) {
                UIApplication.shared.open(url)
            }
        case youTubeLink:
            if let url = URL(string: model.youTubeLink) {
                UIApplication.shared.open(url)
            }
        default:
            break
        }
    }
}

