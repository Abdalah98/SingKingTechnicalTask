//
//  ApiSeviceProtocol.swift
//  NewsApi-OrangeTask
//
//  Created by Abdallah on 2/13/22.
//

import Foundation
protocol ApiServiceProtocol {
    func getCharactersListInfo(completion: @escaping (Result<[CharactersNameInfo] , ResoneError>) -> Void)
   
}
