//
//  AccountSummaryViewController+Networking.swift
//  Bankey
//
//  Created by Marco Carmona on 7/21/22.
//

import Foundation

enum NetworkError: Error {
    case serverError
    case decodingError
}

struct Profile: Codable {
    let id: String
    let firstName: String
    let lastName: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case firstName = "first_name"
        case lastName = "last_name"
    }
}

extension AccountSummaryViewController {
    
    func fetchProfile(
        forUserId userId: String,
        completion: @escaping (Result<Profile, NetworkError>
    ) -> Void) {
            
        guard let url = URL(
            string: "\(baseUrl)/bankey/profile/\(userId)"
        ) else {
            fatalError("Could not create fetching URL")
        }
        
        let request = URLSession.shared.dataTask(with: url) { data, response, error in

            DispatchQueue.main.async {
                guard let data = data, error == nil else {
                    completion(.failure(.serverError))
                    return
                }
                
                do {
                    let profile = try JSONDecoder().decode(Profile.self, from: data)
                    
                    completion(.success(profile))
                    dump(profile)
                } catch {
                    completion(.failure(.decodingError))
                }
            }

        }
        
        request.resume()
        
    }
    
}

struct Account: Codable {
    let id: String
    let type: AccountType
    let name: String
    let amount: Decimal
    let createdDateTime: Date
    
    static func makeSkeleton() -> Account {
        return Account(
            id: "1",
            type: .banking,
            name: "Account name",
            amount: 0.0,
            createdDateTime: Date.now
        )
    }
}

extension AccountSummaryViewController {
    
    func fetchAccounts(
        forUserId userId: String,
        completion: @escaping (Result<[Account], NetworkError>) -> Void
    ) {
        
        guard let url = URL(
            string: "\(baseUrl)/bankey/profile/\(userId)/accounts"
        ) else {
            fatalError("Could not create fetching URL")
        }
        
        let request = URLSession.shared.dataTask(with: url) { data, response, error in
            DispatchQueue.main.async {
                var accounts: [Account]
                
                guard let data = data, error == nil else {
                    completion(.failure(.serverError))
                    return
                }
                
                do {
                    let decoder = JSONDecoder()
                    
                    decoder.dateDecodingStrategy = .iso8601
                    
                    accounts = try decoder.decode([Account].self, from: data)
                    
                    completion(.success(accounts))
                } catch {
                    completion(.failure(.decodingError))
                }
            }
        }
        
        request.resume()
        
    }
    
}
