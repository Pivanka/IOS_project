//
//  NetworkManager.swift
//  FinanceTracker
//
//  Created by Богдан Конопольський on 04.01.2023.
//

import Foundation

enum NetworkManager
{
    static func fetchCurrencyRates(from urlString: String, completion: @escaping (Result<[CurrencyRateResponseResultModel], FetchError>) -> Void){
        guard
            let url = URL(string: urlString)
        else
        {
            completion(.failure(.badURL))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let data = data
            else
            {
                completion(.failure(.badResponse))
                return
            }
            
            do{
                let decodeModel = try JSONDecoder().decode([CurrencyRateResponseResultModel].self, from: data)
                
                completion(.success(decodeModel))
            }
            catch{
                completion(.failure(.failDecoding))
                print("Decode error: \(error)")
            }
        }
        
        task.resume()
    }
}

enum FetchError : Error
{
    case badURL
    case badResponse
    case failDecoding
}

