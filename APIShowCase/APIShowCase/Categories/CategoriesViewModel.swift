//
//  CategoriesViewModel.swift
//  APIShowCase
//
//  Created by Vasiliy Shannikov on 25.03.2024.
//

final class CategoriesViewModel {
    let client: Network
    
    init (client: Network) {
        self.client = client
    }

    func getMeals() async throws -> [MealCategory] {
        let request = Request(path: "list.php", params: ["c": "list"])
        let response: CategoryModel  = try await client.executeRequest(request: request)

        return response.meals
    }
}
