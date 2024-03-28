//
//  CategoriesViewController.swift
//  APIShowCase
//
//  Created by Vasiliy Shannikov on 25.03.2024.
//

import UIKit
import SnapKit

class CategoriesViewController: UIViewController {
    private let viewModel: CategoriesViewModel
    var meals: [MealCategory] = []

    private let mealsList = UITableView()

    init(viewModel: CategoriesViewModel) {
        self.viewModel = viewModel

        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        mealsList.delegate = self
        mealsList.dataSource = self
        mealsList.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        setupView()

        Task {
            do {
                showLoader()
                meals = try await viewModel.getMeals()
                hideLoader()
                mealsList.reloadData()
                mealsList.isHidden = false
            } catch {
                hideLoader()
                showAlert(with: error.localizedDescription)
            }
        }
    }

    private func setupView() {
        title = "Meals Category"
        view.addSubview(mealsList)

        mealsList.delegate = self
        mealsList.dataSource = self
        mealsList.register(UITableViewCell.self, forCellReuseIdentifier: "cell")

        mealsList.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(50)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview().offset(-48)
        }
    }
}

extension CategoriesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        meals.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = meals[indexPath.item].category
        cell.accessoryType = .disclosureIndicator
        cell.selectionStyle = .none

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let viewModel = MealsPreviewViewModel(client: Network(), category: meals[indexPath.item].category ?? "")
        let previewScreen = MealsPreviewViewController(viewModel: viewModel)

        navigationController?.pushViewController(previewScreen, animated: true)
    }
}

