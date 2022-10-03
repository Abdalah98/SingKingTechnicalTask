//
//  ApiService.swift
//  NewsApi-OrangeTask
//
//  Created by Abdallah on 2/13/22.
//

import Foundation
class ApiService : ApiServiceProtocol{
    
    private let charactersListURL: URL? = {
        URL(string: "https://breakingbadapi.com/api/characters")
    }()
    
    func getCharactersListInfo( completion: @escaping (Result<[CharactersNameInfo], ResoneError>) -> Void) {
        fetchAllCharactersList(from: charactersListURL, complete: completion)
    }
    
    
    func fetchAllCharactersList(from url: URL?,  complete completion: @escaping ((Result<[CharactersNameInfo], ResoneError>) -> Void)) {
        guard let url = url else {
            completion(.failure(.invaldURL))
            
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, err) in
            if let _ = err {
                completion(.failure(.unableToComplete))
                return
            }
            
            guard response != nil  else {
                completion(.failure(.invalidResponse))
                
                return
            }
            guard let data = data else {
                completion(.failure(.invalidData))
                return }
            
            do {
                let objects = try JSONDecoder().decode([CharactersNameInfo].self, from: data)
                // success
                //objects.articles.sort { $0.date < $1.date }
                
                completion(.success(objects))
            } catch {
                completion(.failure(.invalidData))
            }
        }.resume()
    }
    
    
}


