//
//  Extension+UIButton.swift
//  APIShowCase
//
//  Created by Vasiliy Shannikov on 27.03.2024.
//

import UIKit

extension UIButton {
    func setText(text: String, color: UIColor, size: CGFloat, weight: UIFont.Weight, alignment: NSTextAlignment = .center ) {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = alignment

        let attributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: size, weight: weight),
            .foregroundColor: color,
            .paragraphStyle: paragraphStyle
        ]

        let attributedString = NSAttributedString(string: text, attributes: attributes)

        setAttributedTitle(attributedString, for: .normal)
    }
}
