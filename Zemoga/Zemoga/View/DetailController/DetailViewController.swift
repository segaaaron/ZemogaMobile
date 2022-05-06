//
//  DetailViewController.swift
//  Zemoga
//
//  Created by Miguel Angel Saravia Belmonte on 5/5/22.
//

import UIKit

class DetailViewController: UIViewController {
    
    private var user: UserModel
    private var post: PostModel
    private var viewModel: PostViewModel
    private var commentsList: [CommentsModel] = []
    private var isStarOn = false {
        didSet {
            configNavigation()
        }
    }
    
    lazy private var tableView: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
       return table
    }()
    
    lazy private var titleLabel: UILabel = {
       let label = UILabel()
        label.text = ZenogaConfig.descriptionTitle
        label.font = UIFont.systemFont(ofSize: 25, weight: .heavy)
        label.numberOfLines = 0
        label.sizeToFit()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy private var descriptionLabel: UILabel = {
       let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        label.textColor = .gray
        label.numberOfLines = 0
        label.sizeToFit()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy private var commentsLabel: UILabel = {
       let label = UILabel()
        label.text = "  " + ZenogaConfig.commentsTitle
        label.font = UIFont.systemFont(ofSize: 25, weight: .heavy)
        label.backgroundColor = UIColor.LightGrayColor
        label.numberOfLines = 0
        label.sizeToFit()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy private var userTitleLabel: UILabel = {
       let label = UILabel()
        label.text = ZenogaConfig.userTitle
        label.font = UIFont.systemFont(ofSize: 25, weight: .heavy)
        label.numberOfLines = 0
        label.sizeToFit()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy private var userNameLabel: UILabel = {
       let label = UILabel()
        label.text = ZenogaConfig.nameUser
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        label.numberOfLines = 0
        label.sizeToFit()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy private var userEmailLabel: UILabel = {
       let label = UILabel()
        label.text = ZenogaConfig.emailUser
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        label.numberOfLines = 0
        label.sizeToFit()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy private var userPhoneLabel: UILabel = {
       let label = UILabel()
        label.text = ZenogaConfig.phoneUser
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        label.numberOfLines = 0
        label.sizeToFit()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy private var userWebsiteLabel: UILabel = {
       let label = UILabel()
        label.text = ZenogaConfig.websiteUser
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        label.numberOfLines = 0
        label.sizeToFit()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy private var textNameLabel: UILabel = {
       let label = UILabel()
        label.textColor = .gray
        label.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        label.numberOfLines = 0
        label.sizeToFit()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy private var textEmailLabel: UILabel = {
       let label = UILabel()
        label.textColor = .gray
        label.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        label.numberOfLines = 0
        label.sizeToFit()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy private var textPhoneLabel: UILabel = {
       let label = UILabel()
        label.textColor = .gray
        label.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        label.numberOfLines = 0
        label.sizeToFit()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy private var textWebsiteLabel: UILabel = {
       let label = UILabel()
        label.textColor = .gray
        label.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        label.numberOfLines = 0
        label.sizeToFit()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    init(user: UserModel, post: PostModel, viewModel: PostViewModel){
        self.user = user
        self.post = post
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configNavigation()
        setupTableView()
        setupDescription()
        loadCommentsList()
        loadDescription()
    }
}

private extension DetailViewController {
    func configNavigation() {
        view.backgroundColor = UIColor.whiteColor
        navigationItem.title = ZenogaConfig.descriptionTitle

        navigationController?.navigationBar.backgroundColor = UIColor.greenColor
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.whiteColor]
        
        let starOn = UIImage(named: "star_on")?.withRenderingMode(.alwaysTemplate)
        
        let starOff = UIImage(named: "star_off")
        
        let image = isStarOn ? starOn : starOff
        let starButton = UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(handleAddfavorites))
        starButton.tintColor = isStarOn ? UIColor.yellow : UIColor.whiteColor
        navigationItem.rightBarButtonItem = starButton
    }
    
    func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.rowHeight = UITableView.automaticDimension
        
        tableView.register(CommentsCell.self, forCellReuseIdentifier: CommentsCell.reuseidentifier)
    }
    
    func setupDescription() {
        [titleLabel, descriptionLabel, userTitleLabel, userNameLabel, textNameLabel, userEmailLabel, textEmailLabel, userPhoneLabel, textPhoneLabel, userWebsiteLabel, textWebsiteLabel, commentsLabel, tableView].forEach { view.addSubview($0) }
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: ZenogaConfig.spacelevel4),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: ZenogaConfig.spacelevel3),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -ZenogaConfig.spacelevel3),
            
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.topAnchor, constant: ZenogaConfig.spacelevel7),
            descriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: ZenogaConfig.spacelevel3),
            descriptionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -ZenogaConfig.spacelevel3),
            
            userTitleLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: ZenogaConfig.spacelevel5),
            userTitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: ZenogaConfig.spacelevel3),
            userTitleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -ZenogaConfig.spacelevel3),

            userNameLabel.topAnchor.constraint(equalTo: userTitleLabel.bottomAnchor, constant: ZenogaConfig.spacelevel3),
            userNameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: ZenogaConfig.spacelevel3),
            userNameLabel.widthAnchor.constraint(equalToConstant: ZenogaConfig.widhtSpaceLv1),
    
            textNameLabel.centerYAnchor.constraint(equalTo: userNameLabel.centerYAnchor),
            textNameLabel.leadingAnchor.constraint(equalTo: userNameLabel.trailingAnchor, constant: ZenogaConfig.spacelevel2),
            textNameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -ZenogaConfig.spacelevel3),

            userEmailLabel.topAnchor.constraint(equalTo: userNameLabel.bottomAnchor, constant: ZenogaConfig.spacelevel3),
            userEmailLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: ZenogaConfig.spacelevel3),
            userEmailLabel.widthAnchor.constraint(equalToConstant: ZenogaConfig.widhtSpaceLv1),
            
            textEmailLabel.centerYAnchor.constraint(equalTo: userEmailLabel.centerYAnchor),
            textEmailLabel.leadingAnchor.constraint(equalTo: userEmailLabel.trailingAnchor, constant: ZenogaConfig.spacelevel2),
            textEmailLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -ZenogaConfig.spacelevel3),

            userPhoneLabel.topAnchor.constraint(equalTo: userEmailLabel.bottomAnchor, constant: ZenogaConfig.spacelevel3),
            userPhoneLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: ZenogaConfig.spacelevel3),
            userPhoneLabel.widthAnchor.constraint(equalToConstant: ZenogaConfig.widhtSpaceLv1),
            
            textPhoneLabel.centerYAnchor.constraint(equalTo: userPhoneLabel.centerYAnchor),
            textPhoneLabel.leadingAnchor.constraint(equalTo: userPhoneLabel.trailingAnchor, constant: ZenogaConfig.spacelevel2),
            textPhoneLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -ZenogaConfig.spacelevel3),

            userWebsiteLabel.topAnchor.constraint(equalTo: userPhoneLabel.bottomAnchor, constant: ZenogaConfig.spacelevel3),
            userWebsiteLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: ZenogaConfig.spacelevel3),
            userWebsiteLabel.widthAnchor.constraint(equalToConstant: ZenogaConfig.widhtSpaceLv1),
            
            textWebsiteLabel.centerYAnchor.constraint(equalTo: userWebsiteLabel.centerYAnchor),
            textWebsiteLabel.leadingAnchor.constraint(equalTo: userWebsiteLabel.trailingAnchor, constant: ZenogaConfig.spacelevel2),
            textWebsiteLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -ZenogaConfig.spacelevel3),
            
            commentsLabel.topAnchor.constraint(equalTo: userWebsiteLabel.bottomAnchor, constant: ZenogaConfig.spacelevel5),
            commentsLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: ZenogaConfig.spacelevel3),
            commentsLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -ZenogaConfig.spacelevel3),
            
            tableView.topAnchor.constraint(equalTo: commentsLabel.bottomAnchor, constant: ZenogaConfig.spacelevel2),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: ZenogaConfig.spacelevel4),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -ZenogaConfig.spacelevel4),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -ZenogaConfig.spacelevel2),
        ])
    }
    
    func loadCommentsList() {
        let id = post.id
        viewModel.serviceCallback(with: .GET, model: [CommentsModel].self, endPoint: .comments(id: id)) { [weak self] result in
            switch result {
            case .success(let resp):
                self?.commentsList = resp
                DispatchQueue.main.async { [weak self] in
                    self?.tableView.reloadData()
                }
            case .failure(let error):
                print(error.localizedDescription)
            case .none:
                break
            }
        }
    }
    
    func loadDescription() {
        descriptionLabel.text = post.body
        textNameLabel.text = user.username
        textEmailLabel.text = user.email
        textPhoneLabel.text = user.phone
        textWebsiteLabel.text = user.website
    }
    
    @objc func handleAddfavorites(_ sender: UIButton) {
        isStarOn = !isStarOn
    }
}

extension DetailViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return commentsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CommentsCell.reuseidentifier, for: indexPath) as? CommentsCell else {
            return UITableViewCell()
        }
        let model = commentsList[indexPath.row]
        cell.config(model: model)
        return cell
    }
}
