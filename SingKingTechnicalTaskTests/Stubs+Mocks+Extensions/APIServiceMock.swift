//
//  SingKingTechnicalTaskTests.swift
//  SingKingTechnicalTaskTests
//
//  Created by Abdalah on 03/10/2022.
//


import Foundation
@testable import SingKingTechnicalTask
// The mock APIService(APIServiceMock) object doesn’t connect to the real server,
// it’s an object designed only for the test.
// Both APIServiceand APIServiceMock conform to APIServiceProtocol,
// so that we are able to inject different dependency in different situation.
class APIServiceMock: ApiServiceProtocol{
    
    
    
    var fetchCharactersListIsCalled = false
    var fetchCharactersNameIsCalled = false
    
    var article :[CharactersNameInfo]?
    
    var completeClosure: ((Result<[CharactersNameInfo] , ResoneError>) -> ())!
 
    func getCharactersListInfo(completion: @escaping (Result<[CharactersNameInfo] , ResoneError>) -> Void)
    {
         fetchCharactersListIsCalled = true
        completeClosure = completion
    }
    func fetchAllNews(from url: URL?, complete: @escaping ((Result<[CharactersNameInfo], ResoneError>) -> Void)) {
        fetchCharactersNameIsCalled = true
    }

    func fetchSuccess() {
        
        completeClosure(.success(article!))
    }

    func fetchFail(error: ResoneError?) {
        completeClosure(.failure(error!))
    }
}
