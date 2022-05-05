//
//  PostCell.swift
//  Zemoga
//
//  Created by Miguel Angel Saravia Belmonte on 5/4/22.
//

import UIKit

class PostCell: UITableViewCell {
    
    lazy var bodyLabel: UILabel = {
       let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        label.numberOfLines = 0
        label.sizeToFit()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    static let reuseidentifier = String(describing: PostCell.self)

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupConstrains()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func config(model: PostModel) {
        bodyLabel.text = model.title
    }
    
    private func setupConstrains() {
        contentView.addSubview(bodyLabel)
        
        NSLayoutConstraint.activate([
            bodyLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15),
            bodyLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 15),
            bodyLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -25),
            bodyLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -15)
        ])
    }
}
