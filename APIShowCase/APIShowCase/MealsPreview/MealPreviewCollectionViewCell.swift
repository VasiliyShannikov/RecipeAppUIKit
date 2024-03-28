//
//  MealPreviewCollectionViewCell.swift
//  APIShowCase
//
//  Created by Vasiliy Shannikov on 26.03.2024.
//

import UIKit
import SnapKit
import SDWebImage

final class MealPreviewCollectionViewCell: UICollectionViewCell {
    private let imageView = UIImageView(image: UIImage(named: "smile"))
    private let nameLabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)

        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(with model: PreviewMealModel) {
        imageView.sd_setImage(with: URL(string: model.imagePath))
        imageView.layer.cornerRadius = 8
        imageView.clipsToBounds = true

        nameLabel.setText(text: model.name, color: .black, size: 12, weight: .semibold, lineHeight: 14)
        nameLabel.numberOfLines = 0
    }

    private func setupView() {
        [imageView, nameLabel].forEach { addSubview($0) }

        imageView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalTo(imageView.snp.width)
        }

        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(4)
            make.centerX.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
        }

        nameLabel.setText(text: "Some meal", color: .black, size: 12, weight: .semibold, lineHeight: 14)
    }
}
