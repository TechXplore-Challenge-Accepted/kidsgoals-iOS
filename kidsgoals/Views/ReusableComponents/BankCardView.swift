//
//  BankCardView.swift
//  kidsgoals
//
//  Created by M1 on 04.07.2024.
//

import UIKit

class BankCardView: UIView {
    
    // MARK: - Properties
    private let amountLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.textColor = .white
        return label
    }()
    
    // MARK: - Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Functions
    private func setupUI() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [UIColor.systemBlue.cgColor, UIColor.blue.cgColor]
        gradientLayer.locations = [0.0, 1.0]
        layer.insertSublayer(gradientLayer, at: 0)
        
        addSubview(amountLabel)
        NSLayoutConstraint.activate([
            amountLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30),
            amountLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -30)
        ])
        
        layer.cornerRadius = 15
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 2)
        layer.shadowOpacity = 0.3
        layer.shadowRadius = 4
    }
    
    func setAmount(_ amount: Int) {
        amountLabel.text = "\(amount) GEL"
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if let gradientLayer = layer.sublayers?.first as? CAGradientLayer {
            gradientLayer.frame = bounds
            gradientLayer.cornerRadius = 15
            gradientLayer.masksToBounds = true // Ensures corner radius is applied
        }
        
        layer.cornerRadius = 15
        layer.masksToBounds = false
    }
}
