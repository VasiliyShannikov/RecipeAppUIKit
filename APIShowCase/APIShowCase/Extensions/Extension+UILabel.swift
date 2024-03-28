//
//  Extension+UILabel.swift
//  APIShowCase
//
//  Created by Vasiliy Shannikov on 26.03.2024.
//

import UIKit

extension UILabel {
    func setText(text: String,
                 color: UIColor,
                 size: CGFloat,
                 weight: UIFont.Weight,
                 lineHeight: CGFloat = 18,
                 alignment: NSTextAlignment = .center) {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = alignment
        paragraphStyle.minimumLineHeight = lineHeight

        let attributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: size, weight: weight),
            .foregroundColor: color,
            .paragraphStyle: paragraphStyle,
            .kern: 0.36,
        ]

        let attributedString = NSAttributedString(string: text, attributes: attributes)

        attributedText = attributedString
    }
}

