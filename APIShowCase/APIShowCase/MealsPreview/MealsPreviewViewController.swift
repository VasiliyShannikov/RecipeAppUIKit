//
//  MealsPreviewViewController.swift
//  APIShowCase
//
//  Created by Vasiliy Shannikov on 25.03.2024.
//

import UIKit
import SnapKit

final class MealsPreviewViewController: UIViewController {
    private let viewModel: MealsPreviewViewModel
    private var meals = [PreviewMealModel]()

    private var mealsCollection: UICollectionView!

    init(viewModel: MealsPreviewViewModel) {
        self.viewModel = viewModel

        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Preview"
        view.backgroundColor = .white
        setupCollectionView()

        Task {
            do {
                showLoader()
                mealsCollection.isHidden = true
                meals = try await viewModel.getMealsPreviews()
                hideLoader()
                mealsCollection.reloadData()
                mealsCollection.isHidden = false
            } catch {
                hideLoader()
                showAlert(with: error.localizedDescription)
            }

        }
    }

    private func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical

        mealsCollection = UICollectionView(frame: CGRect(), collectionViewLayout: layout)
        mealsCollection.backgroundColor = .white

        mealsCollection.delegate = self
        mealsCollection.dataSource = self
        mealsCollection.register(MealPreviewCollectionViewCell.self, forCellWithReuseIdentifier: "cell")

        view.addSubview(mealsCollection)

        mealsCollection.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(100)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.bottom.equalToSuperview().offset(-32)
        }
    }
}

extension MealsPreviewViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        meals.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell",
                                                      for: indexPath) as! MealPreviewCollectionViewCell
        cell.configure(with: meals[indexPath.item])

        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let viewModel = MealViewModel(id: meals[indexPath.item].id, client: Network())
        let mealScreen = MealViewController(viewModel: viewModel)

        navigationController?.pushViewController(mealScreen, animated: true)
    }
}

extension MealsPreviewViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: 174, height: 210)
    }
}
