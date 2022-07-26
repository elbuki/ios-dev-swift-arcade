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
                print(error.localizedDescription)
            }
            
            group.leave()
        }
        
        group.enter()
        fetchAccounts(forUserId: "1") { result in
            switch result {
            case .success(let accounts):
                self.accounts = accounts
            case .failure(let error):
                print(error.localizedDescription)
            }
            
            group.leave()
        }
        
        group.notify(queue: .main) {
            guard let profile = self.profile else {
                fatalError("Could not unwrap profile")
            }
            
            self.tableView.refreshControl?.endRefreshing()
            self.isLoaded = true
            self.configureTableHeaderView(with: profile)
            self.configureTableCells(with: self.accounts)
            self.tableView.reloadData()
        }
    }
    
}
