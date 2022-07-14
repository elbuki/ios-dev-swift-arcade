//
//  AccountSummaryCell.swift
//  Bankey
//
//  Created by Marco Carmona on 7/6/22.
//

import UIKit

class AccountSummaryCell: UITableViewCell {
    
    let typeLabel = UILabel()
    let underlineView = UIView()
    let nameLabel = UILabel()
    
    let balanceStackView = UIStackView()
    let balanceLabel = UILabel()
    let balanceAmountLabel = UILabel()
    
    let chevronImageView = UIImageView()
    
    static let reuseID = "AccountSummaryCell"
    static let rowHeight: CGFloat = 100
    
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
        balanceAmountLabel.text = "$XXX,XXX.XX"
        
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
}
