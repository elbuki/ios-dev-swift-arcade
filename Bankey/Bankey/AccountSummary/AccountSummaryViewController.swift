//
//  AccountSummaryViewController.swift
//  Bankey
//
//  Created by Marco Carmona on 7/6/22.
//

import UIKit

class AccountSummaryViewController: UIViewController {
    
    struct Profile {
        let firstName: String
        let lastName: String
    }
    
    var profile: Profile?
    var accounts: [AccountSummaryCell.ViewModel] = []
    
    let tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        layout()
    }
    
    private func setup() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(AccountSummaryCell.self, forCellReuseIdentifier: AccountSummaryCell.reuseID)
        tableView.rowHeight = AccountSummaryCell.rowHeight
        tableView.tableFooterView = UIView()
        
        style()
        layout()
        setupTableHeaderView()
        fetchData()
    }
    
    private func style() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func layout() {
        let constraints = [
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ]
        
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate(constraints)
    }
    
    private func setupTableHeaderView() {
        let header = AccountSummaryHeaderView(frame: .zero)
        var size = header.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)
        
        size.width = UIScreen.main.bounds.width
        header.frame.size = size
        
        tableView.tableHeaderView = header
    }
    
}

extension AccountSummaryViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard !accounts.isEmpty else { return UITableViewCell() }

        let cell = tableView.dequeueReusableCell(
            withIdentifier: AccountSummaryCell.reuseID,
            for: indexPath
        ) as? AccountSummaryCell
    
        guard let summaryCell = cell else {
            fatalError("Could not instantiate AccountSummaryCell")
        }
        
        let account = accounts[indexPath.row]
        
        summaryCell.configure(with: account)
        
        return summaryCell

    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        accounts.count
    }
}

extension AccountSummaryViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}

extension AccountSummaryViewController {
    
    private func fetchData() {
        fetchAccounts()
        fetchProfile()
    }
    
    private func fetchAccounts() {
        let viewModels: [AccountSummaryCell.ViewModel] = [
            .init(accountType: .banking, accountName: "Basic Savings", balance: 929466.23),
            .init(accountType: .banking, accountName: "No-Fee All-In Chequing", balance: 17562.44),
            .init(accountType: .creditCard, accountName: "Visa Avion Card", balance: 412.83),
            .init(accountType: .creditCard, accountName: "Student Mastercard", balance: 50.83),
            .init(accountType: .investment, accountName: "Tax-Free Saver", balance: 2000.00),
            .init(accountType: .investment, accountName: "Growth Fund", balance: 15000.00),
        ]
        
        accounts = viewModels
    }
    
    private func fetchProfile() {
        profile = .init(firstName: "Kevin", lastName: "Smith")
    }
    
}
