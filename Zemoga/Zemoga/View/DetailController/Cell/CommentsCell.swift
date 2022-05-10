//
//  CommentsCell.swift
//  Zemoga
//
//  Created by Miguel Angel Saravia Belmonte on 5/5/22.
//

import UIKit

class CommentsCell: UITableViewCell {
    
    lazy var titleLabel: UILabel = {
       let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        label.textColor = .gray
        label.numberOfLines = 0
        label.sizeToFit()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    static let reuseidentifier = String(describing: CommentsCell.self)

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupConstrains()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func config(model: CommentsModel) {
        titleLabel.text = model.body
    }
}

private extension CommentsCell {
    func setupConstrains() {
        contentView.addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15),
            titleLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 15),
            titleLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -25),
            titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -15)
        ])
    }
}
