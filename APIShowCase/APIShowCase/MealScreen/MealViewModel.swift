//
//  MealViewModel.swift
//  APIShowCase
//
//  Created by Vasiliy Shannikov on 27.03.2024.
//

final class MealViewModel {
    let id: String
    let client: Network
    private(set) var model: MealModel?

    init(id: String, client: Network) {
        self.id = id
        self.client = client
    }

    func getMeal() async throws {
        let request = Request(path: "lookup.php", params: ["i" : id])

        let response: Meals = try await client.executeRequest(request: request)

        model = response.meals.first
    }


}
