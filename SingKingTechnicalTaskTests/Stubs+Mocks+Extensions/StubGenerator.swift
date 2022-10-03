//
//  SingKingTechnicalTaskTests.swift
//  SingKingTechnicalTaskTests
//
//  Created by Abdalah on 03/10/2022.
//


import Foundation
@testable import SingKingTechnicalTask

class StubGenerator {
    func stubNews() -> [CharactersNameInfo]? {
        guard let path = Bundle.unitTest.path(forResource: "charactersList", ofType: "json"),
            let data = try? Data(contentsOf: URL(fileURLWithPath: path)) else {
                return nil
        }

        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        let charactersNameInfo = try? decoder.decode([CharactersNameInfo].self, from: data)
        return charactersNameInfo
    }
}
