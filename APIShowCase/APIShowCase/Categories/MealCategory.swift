//
//  MealCategory.swift
//  APIShowCase
//
//  Created by Vasiliy Shannikov on 25.03.2024.
//

import Foundation
struct MealCategory: Decodable {
    let category: String?

    enum CodingKeys: String, CodingKey {
        case category = "strCategory"
    }
}

