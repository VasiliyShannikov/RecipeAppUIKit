//
//  MealModel.swift
//  APIShowCase
//
//  Created by Vasiliy Shannikov on 27.03.2024.
//

struct MealModel: Decodable {
    let name: String
    let imageLink: String
    let recipe: String
    let pageLink: String
    let youTubeLink: String

    enum CodingKeys: String, CodingKey {
        case name = "strMeal"
        case imageLink = "strMealThumb"
        case pageLink = "strSource"
        case youTubeLink = "strYoutube"
        case recipe = "strInstructions"
    }
}
