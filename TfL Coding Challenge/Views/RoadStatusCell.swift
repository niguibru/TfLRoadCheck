//
//  RoadStatusCell.swift
//  TfL Coding Challenge
//
//  Created by Nicolas Brucchieri on 03/03/2020.
//  Copyright © 2020 Nicolas Brucchieri. All rights reserved.
//

import UIKit

class RoadStatusCell: UITableViewCell {
    
    static let cellReuseIdentifier = "RoadStatusCell"
    
    let contentStatusView: UIView =  {
        let view = UIView()
        view.layer.cornerRadius = 10
        return view
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = label.font.withSize(20)
        label.textAlignment = .center
        label.sizeToFit()
        return label
    }()

    let titleUnderineView: UIView = {
        let label = UILabel()
        label.backgroundColor = .gray
        return label
    }()

    let statusLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()

    let statusDescriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()

    override init(style: CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        commonInit()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }

    func commonInit() {
        selectionStyle = .none
        
        self.addSubview(contentStatusView)
        contentStatusView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            contentStatusView.topAnchor.constraint(equalTo: self.topAnchor),
            contentStatusView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -4),
            contentStatusView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            contentStatusView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
        ])
        
        contentStatusView.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: contentStatusView.topAnchor, constant: 8),
            titleLabel.leadingAnchor.constraint(equalTo: contentStatusView.leadingAnchor, constant: 8),
            titleLabel.trailingAnchor.constraint(equalTo: contentStatusView.trailingAnchor, constant: -8),
        ])
        
        contentStatusView.addSubview(titleUnderineView)
        titleUnderineView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleUnderineView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            titleUnderineView.leadingAnchor.constraint(equalTo: contentStatusView.leadingAnchor, constant: 16),
            titleUnderineView.trailingAnchor.constraint(equalTo: contentStatusView.trailingAnchor, constant: -16),
            titleUnderineView.heightAnchor.constraint(equalToConstant: CGFloat(1))
        ])
        
        contentStatusView.addSubview(statusLabel)
        statusLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            statusLabel.topAnchor.constraint(equalTo: titleUnderineView.bottomAnchor, constant: 8),
            statusLabel.leadingAnchor.constraint(equalTo: contentStatusView.leadingAnchor, constant: 8),
            statusLabel.trailingAnchor.constraint(equalTo: contentStatusView.trailingAnchor, constant: -8),
        ])
        
        contentStatusView.addSubview(statusDescriptionLabel)
        statusDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            statusDescriptionLabel.topAnchor.constraint(equalTo: statusLabel.bottomAnchor, constant: 8),
            statusDescriptionLabel.bottomAnchor.constraint(equalTo: contentStatusView.bottomAnchor, constant: -8),
            statusDescriptionLabel.leadingAnchor.constraint(equalTo: contentStatusView.leadingAnchor, constant: 8),
            statusDescriptionLabel.trailingAnchor.constraint(equalTo: contentStatusView.trailingAnchor, constant: -8),
        ])
    }
    
    func setupWithModel(model: RoadStatus) {
        titleLabel.text = model.displayName
        statusLabel.text = "Road Status\n\(model.statusSeverity)"
        statusDescriptionLabel.text = "Road Status Description\n\(model.statusSeverityDescription)"
        contentStatusView.backgroundColor = model.colorForSeverity()
    }
    
}
