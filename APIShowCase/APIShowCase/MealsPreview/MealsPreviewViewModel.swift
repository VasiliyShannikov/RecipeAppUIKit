//
//  MealsPreviewViewModel.swift
//  APIShowCase
//
//  Created by Vasiliy Shannikov on 25.03.2024.
//

final class MealsPreviewViewModel {
    private let client: Network
    private let category: String

    init(client: Network, category: String) {
        self.client = client
        self.category = category
    }

    func getMealsPreviews() async throws -> [PreviewMealModel] {
        let request = Request(path: "filter.php", params: ["c" : category])
        let response: PreviewModel = try await client.executeRequest(request: request)

        return response.meals
    }
}
