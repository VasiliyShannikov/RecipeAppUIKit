//
//  CategoryModel.swift
//  APIShowCase
//
//  Created by Vasiliy Shannikov on 25.03.2024.
//

import Foundation

struct CategoryModel: Decodable {
    let meals: [MealCategory]
}
