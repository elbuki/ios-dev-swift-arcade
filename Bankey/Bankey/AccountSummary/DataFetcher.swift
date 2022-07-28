//
//  DataFetcher.swift
//  Bankey
//
//  Created by Marco Carmona on 7/25/22.
//

import Foundation

extension AccountSummaryViewController {
    
    func fetchData() {
        let group = DispatchGroup()
        
        group.enter()
        
        fetchProfile(forUserId: "1") { result in
            switch result {
            case .success(let profile):
                self.profile = profile
            case .failure(let error):
                self.displayError(for: error)
            }
            
            group.leave()
        }
        
        group.enter()
        fetchAccounts(forUserId: "1") { result in
            switch result {
            case .success(let accounts):
                self.accounts = accounts
            case .failure(let error):
                self.displayError(for: error)
            }
            
            group.leave()
        }
        
        group.notify(queue: .main) {
            guard let profile = self.profile else {
                return
            }
            
            self.tableView.refreshControl?.endRefreshing()
            self.isLoaded = true
            self.configureTableHeaderView(with: profile)
            self.configureTableCells(with: self.accounts)
            self.tableView.reloadData()
        }
    }
    
    func displayError(for error: NetworkError) {
        var title: String
        var message: String
        
        switch error {
        case .decodingError:
            title = "Decoding Error"
            message = "We could not process your request. Please try again."
        case .serverError:
            title = "Server Error"
            message = "Ensure you are connected to the internet. Please try again."
        }

        self.showErrorAlert(title: title, message: message)
    }
    
}
