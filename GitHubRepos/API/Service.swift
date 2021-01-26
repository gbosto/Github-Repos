//
//  Service.swift
//  GitHubRepos
//
//  Created by Giorgi on 1/26/21.
//

import Foundation

struct Service {
    static func fetchData(username: String, completion: @escaping(Result<[Repo], Error>)->Void){
        guard let url = URL(string: "https://api.github.com/users/\(username)/repos") else {return}
        
        
        let session = URLSession.shared
        let task = session.dataTask(with: url) { data, _, error in
            
            if error != nil {
                completion(.failure(error!))
                return
            }
            
            guard let data = data else {return}

            let decoder = JSONDecoder()
            
            do {
                let repos: [Repo] = try decoder.decode([Repo].self, from: data)
                completion(.success(repos))
            } catch let error {
                completion(.failure(error))
            }
            
        }
        task.resume()
    }
    
    
    static func fetchImageData(forImageUrl url: String, completion: @escaping(Result<Data, Error>) -> Void) {
        guard let url = URL(string: url) else {return}
        
        let session = URLSession.shared
        let task = session.dataTask(with: url) { data, _, error in
            if error != nil {
                completion(.failure(error!))
                return
            }
            guard let data = data else {return}
            completion(.success(data))
        }
        task.resume()
    }
}

