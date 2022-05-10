//
//  PostCell.swift
//  Zemoga
//
//  Created by Miguel Angel Saravia Belmonte on 5/4/22.
//

import UIKit
import RealmSwift

class PostCell: UITableViewCell {
    
    private var favoriteList: Results<FavoritesObject>?
    private var realm = RealmService.shared.realm
    
    lazy var titleLabel: UILabel = {
       let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        label.numberOfLines = 0
        label.sizeToFit()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var starImage: UIImageView = {
       let imageView = UIImageView()
        imageView.image = UIImage(named: "star_on")?.withRenderingMode(.alwaysTemplate)
        imageView.tintColor = UIColor.MediumYellowColor
        imageView.isHidden = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    static let reuseidentifier = String(describing: PostCell.self)

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupConstrains()
        favoriteList = realm.objects(FavoritesObject.self)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func config(model: PostModel) {
        titleLabel.text = model.title
        validateStatus(post: model)
    }
    
    private func setupConstrains() {
        [starImage, titleLabel].forEach { contentView.addSubview($0) }
        
        NSLayoutConstraint.activate([
            starImage.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            starImage.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 5),
            starImage.widthAnchor.constraint(equalToConstant: 30),
            starImage.heightAnchor.constraint(equalToConstant: 30),
            
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15),
            titleLabel.leftAnchor.constraint(equalTo: starImage.rightAnchor, constant: 15),
            titleLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -25),
            titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -15)
        ])
    }
    
    private func validateStatus(post: PostModel) {
        var resp: Bool = false
        if let _ = favoriteList?.firstIndex(where: { $0.postObjt?.id == post.id }) {
            resp = true
        }
        showStart(resp)
    }
    
    private func showStart(_ status: Bool) {
        DispatchQueue.main.async { [weak self] in
            self?.starImage.isHidden = !status
        }
    }
}
