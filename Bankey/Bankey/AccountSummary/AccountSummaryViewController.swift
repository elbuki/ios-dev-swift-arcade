//
//  AccountSummaryViewController.swift
//  Bankey
//
//  Created by Marco Carmona on 7/6/22.
//

import UIKit

class AccountSummaryViewController: UIViewController {
    
    let baseUrl = "https://fierce-retreat-36855.herokuapp.com"
    
    // Request models
    var profile: Profile?
    var accounts: [Account] = []
    
    // View models
    var headerViewModel = AccountSummaryHeaderView.ViewModel(
        welcomeMessage: "Welcome",
        name: "",
        date: Date.now
    )
    var accountCellViewModels: [AccountSummaryCell.ViewModel] = []
    
    // Components
    var tableView = UITableView()
    var headerView = AccountSummaryHeaderView(frame: .zero)
    let refreshControl = UIRefreshControl()
    
    var isLoaded = false
    
    lazy var logoutBarButtonItem: UIBarButtonItem = {
        let barButtonItem = UIBarButtonItem(
            title: "Logout",
            style: .plain,
            target: self,
            action: #selector(logoutTapped)
        )
        
        barButtonItem.tintColor = .label
        
        return barButtonItem
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        layout()
    }
    
    private func setup() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(
            AccountSummaryCell.self,
            forCellReuseIdentifier: AccountSummaryCell.reuseID
        )
        tableView.register(
            SkeletonCell.self,
            forCellReuseIdentifier: SkeletonCell.reuseID
        )
        
        tableView.rowHeight = AccountSummaryCell.rowHeight
        tableView.tableFooterView = UIView()
        tableView.backgroundColor = appColor
        
        setUpNavigationBar()
        style()
        layout()
        setupTableHeaderView()
        setupRefreshControl()
        setupSkeletons()
        fetchData()
        // Continue on 2:30
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
        var size = headerView.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)
        
        size.width = UIScreen.main.bounds.width
        headerView.frame.size = size
        
        tableView.tableHeaderView = headerView
    }
    
    private func setUpNavigationBar() {
        navigationItem.rightBarButtonItem = logoutBarButtonItem
    }
    
    func setupRefreshControl() {
        refreshControl.tintColor = appColor
        refreshControl.addTarget(
            self,
            action: #selector(refreshContent),
            for: .valueChanged
        )
        
        tableView.refreshControl = refreshControl
    }
    
    private func setupSkeletons() {
        let row = Account.makeSkeleton()
        
        accounts = Array(repeating: row, count: 10)
        
        configureTableCells(with: accounts)
    }
    
}

extension AccountSummaryViewController: UITableViewDataSource {
    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        
        guard !accountCellViewModels.isEmpty else { return UITableViewCell() }
        
        let account = accountCellViewModels[indexPath.row]
        let identifier = isLoaded ? AccountSummaryCell.reuseID : SkeletonCell.reuseID
        
        let cell = tableView.dequeueReusableCell(
            withIdentifier: identifier,
            for: indexPath
        )
        
        if let skeletonCell = cell as? SkeletonCell, !isLoaded {
            return skeletonCell
        }
    
        guard let summaryCell = cell as? AccountSummaryCell else {
            fatalError("Could not instantiate account summary cell: \(identifier)")
        }
        
        summaryCell.configure(with: account)
        
        return summaryCell

    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        accountCellViewModels.count
    }
}

extension AccountSummaryViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}

// MARK: Actions
extension AccountSummaryViewController {

    @objc private func logoutTapped() {
        NotificationCenter.default.post(name: .logout, object: nil)
    }
    
    @objc private func refreshContent() {
        reset()
        setupSkeletons()
        tableView.reloadData()
        fetchData()
    }
    
    private func reset() {
        profile = nil
        accounts = []
        isLoaded = false
    }
    
}

// MARK: - Networking
extension AccountSummaryViewController {
    
    func configureTableHeaderView(with profile: Profile) {
        let vm = AccountSummaryHeaderView.ViewModel(
            welcomeMessage: "Good morning",
            name: profile.firstName,
            date: Date.now
        )
        
        headerView.configure(viewModel: vm)
    }
    
    func configureTableCells(with accounts: [Account]) {
        accountCellViewModels = accounts.map {
            AccountSummaryCell.ViewModel(
                accountType: $0.type,
                accountName: $0.name,
                balance: $0.amount
            )
        }
    }
    
    func showErrorAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)

        alert.addAction(.init(title: "OK", style: .default, handler: nil))
        
        present(alert, animated: true, completion: nil)
    }
    
}
