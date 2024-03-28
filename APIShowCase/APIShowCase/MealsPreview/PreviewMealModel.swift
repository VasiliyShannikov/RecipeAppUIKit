//
//  PreviewMealModel.swift
//  APIShowCase
//
//  Created by Vasiliy Shannikov on 25.03.2024.
//

struct PreviewMealModel: Decodable {
    let name: String
    let imagePath: String
    let id: String

    enum CodingKeys: String, CodingKey {
        case name = "strMeal"
        case imagePath = "strMealThumb"
        case id = "idMeal"
    }
}
