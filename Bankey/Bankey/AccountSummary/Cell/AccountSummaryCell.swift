//
//  AccountSummaryCell.swift
//  Bankey
//
//  Created by Marco Carmona on 7/6/22.
//

import UIKit
import Foundation

class AccountSummaryCell: UITableViewCell {
    
    enum AccountType: String {
        case banking = "Banking"
        case creditCard = "Credit Card"
        case investment = "Investment"
    }
    
    struct ViewModel {
        let accountType: AccountType
        let accountName: String
        let balance: Decimal
        
        var balanceAsAttributedString: NSAttributedString {
            return CurrencyFormatter().makeAttributedCurrency(balance)
        }
    }
    
    let viewModel: ViewModel? = nil
    
    let typeLabel = UILabel()
    let underlineView = UIView()
    let nameLabel = UILabel()
    
    let balanceStackView = UIStackView()
    let balanceLabel = UILabel()
    let balanceAmountLabel = UILabel()
    
    let chevronImageView = UIImageView()
    
    static let reuseID = "AccountSummaryCell"
    static let rowHeight: CGFloat = 112
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setup()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension AccountSummaryCell {
    func setup() {
        guard var chevronImage = UIImage(systemName: "chevron.right") else {
            fatalError("Could not load chevron image")
        }
        
        chevronImage = chevronImage.withTintColor(appColor, renderingMode: .alwaysOriginal)
        
        typeLabel.translatesAutoresizingMaskIntoConstraints = false
        typeLabel.font = .preferredFont(forTextStyle: .caption1)
        typeLabel.adjustsFontForContentSizeCategory = true
        typeLabel.text = "Account type"
        
        underlineView.translatesAutoresizingMaskIntoConstraints = false
        underlineView.backgroundColor = appColor
        
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.font = .preferredFont(forTextStyle: .body)
        nameLabel.text = "Account name"
        
        balanceStackView.translatesAutoresizingMaskIntoConstraints = false
        balanceStackView.axis = .vertical
        balanceStackView.spacing = 0
        
        balanceLabel.translatesAutoresizingMaskIntoConstraints = false
        balanceLabel.font = .preferredFont(forTextStyle: .body)
        balanceLabel.textAlignment = .right
        balanceLabel.adjustsFontSizeToFitWidth = true
        balanceLabel.text = "Some balance"
        
        balanceAmountLabel.translatesAutoresizingMaskIntoConstraints = false
        balanceAmountLabel.textAlignment = .right
        balanceAmountLabel.attributedText = makeFormattedBalance(dollars: "929,466", cents: "23")
        
        chevronImageView.translatesAutoresizingMaskIntoConstraints = false
        chevronImageView.image = chevronImage
        
        
        balanceStackView.addArrangedSubview(balanceLabel)
        balanceStackView.addArrangedSubview(balanceAmountLabel)
        
        contentView.addSubview(typeLabel)
        contentView.addSubview(underlineView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(balanceStackView)
        contentView.addSubview(chevronImageView)
    }
    
    func layout() {
        let constraints = [
            typeLabel.topAnchor.constraint(equalToSystemSpacingBelow: topAnchor, multiplier: 2),
            typeLabel.leadingAnchor.constraint(
                equalToSystemSpacingAfter: leadingAnchor,
                multiplier: 2
            ),
            /// MARK: Underline view
            underlineView.topAnchor.constraint(
                equalToSystemSpacingBelow: typeLabel.bottomAnchor,
                multiplier: 1
            ),
            underlineView.leadingAnchor.constraint(
                equalToSystemSpacingAfter: leadingAnchor,
                multiplier: 2
            ),
            underlineView.widthAnchor.constraint(equalTo: typeLabel.widthAnchor),
            underlineView.heightAnchor.constraint(equalToConstant: 4),
            /// MARK: Name label
            nameLabel.topAnchor.constraint(
                equalToSystemSpacingBelow: underlineView.bottomAnchor,
                multiplier: 2
            ),
            nameLabel.leadingAnchor.constraint(
                equalToSystemSpacingAfter: leadingAnchor,
                multiplier: 2
            ),
            /// MARK: Balance stack view
            balanceStackView.topAnchor.constraint(
                equalToSystemSpacingBelow: underlineView.bottomAnchor,
                multiplier: 0
            ),
            balanceStackView.leadingAnchor.constraint(
                equalTo: nameLabel.trailingAnchor,
                constant: 4
            ),
            trailingAnchor.constraint(
                equalToSystemSpacingAfter: balanceStackView.trailingAnchor,
                multiplier: 4
            ),
            /// MARK: Chevron image view
            chevronImageView.topAnchor.constraint(
                equalToSystemSpacingBelow: underlineView.topAnchor,
                multiplier: 1
            ),
            trailingAnchor.constraint(
                equalToSystemSpacingAfter: chevronImageView.trailingAnchor,
                multiplier: 1
            ),
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
    
    private func makeFormattedBalance(dollars: String, cents: String) -> NSMutableAttributedString {
        let dollarSignAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.preferredFont(forTextStyle: .callout),
            .baselineOffset: 8,
        ]
        
        let dollarAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.preferredFont(forTextStyle: .title1),
        ]
        
        let centAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.preferredFont(forTextStyle: .footnote),
            .baselineOffset: 8,
        ]
        
        let rootString = NSMutableAttributedString(string: "$", attributes: dollarSignAttributes)
        let dollarString = NSAttributedString(string: dollars, attributes: dollarAttributes)
        let centString = NSAttributedString(string: cents, attributes: centAttributes)
        
        rootString.append(dollarString)
        rootString.append(centString)
        
        return rootString
    }
}

extension AccountSummaryCell {
    func configure(with vm: ViewModel) {
        var underlineColor: UIColor
        var balanceText: String
        
        typeLabel.text = vm.accountType.rawValue
        nameLabel.text = vm.accountName
        balanceAmountLabel.attributedText = vm.balanceAsAttributedString
        
        switch vm.accountType {
        case .banking:
            underlineColor = appColor
            balanceText = "Current balance"
        case .creditCard:
            underlineColor = .systemOrange
            balanceText = "Balance"
        case .investment:
            underlineColor = .systemPurple
            balanceText = "Value"
        }
        
        underlineView.backgroundColor = underlineColor
        balanceLabel.text = balanceText
    }
}
