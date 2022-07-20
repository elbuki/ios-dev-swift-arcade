//
//  AccountSummaryHeaderView.swift
//  Bankey
//
//  Created by Marco Carmona on 7/6/22.
//

import UIKit

class AccountSummaryHeaderView: UIView {
    
    @IBOutlet var contentView: UIView!
    
    let shakyBellView = ShakyBellView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        commonInit()
        setupShakeyBell()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        commonInit()
    }
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: UIView.noIntrinsicMetric, height: 144)
    }
    
    private func commonInit() {
        let bundle = Bundle(for: AccountSummaryHeaderView.self)
        
        bundle.loadNibNamed("AccountSummaryHeaderView", owner: self, options: nil)
        
        contentView.backgroundColor = appColor
        addSubview(contentView)
        
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: topAnchor),
            contentView.leadingAnchor.constraint(equalTo: leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
    
    private func setupShakeyBell() {
        let constraints = [
            shakyBellView.trailingAnchor.constraint(equalTo: trailingAnchor),
            shakyBellView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ]
        
        shakyBellView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(shakyBellView)
        
        NSLayoutConstraint.activate(constraints)
    }
    
}

