//
//  PostViewController.swift
//  Zemoga
//
//  Created by Miguel Angel Saravia Belmonte on 5/4/22.
//

import UIKit
import RealmSwift

class PostViewController: UIViewController {

    private var viewModel: PostViewModel
    var postList: [PostModel] = []
    private var auxList: [PostModel] = []
    private var userList: [UserModel] = []
    private var commentList: [CommentsModel] = []
    private var realm = RealmService.shared.realm
    private var loadFavoriteList: Bool = false
    private var favoriteList: Results<FavoritesObject>?
    private var group = DispatchGroup()
    
    lazy var tableView: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
       return table
    }()
    
    lazy private var segment: UISegmentedControl = {
        let segment = UISegmentedControl(items: [ZenogaConfig.segmentOne, ZenogaConfig.segmentTwo])
        let normaltitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.whiteColor]
        let selectedtitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.greenColor]
        segment.setTitleTextAttributes(normaltitleTextAttributes, for: .normal)
        segment.setTitleTextAttributes(selectedtitleTextAttributes, for: .selected)
        segment.selectedSegmentIndex = 0
        segment.backgroundColor = UIColor.greenColor
        segment.addTarget(self, action: #selector(handleSegementChange(_:)), for: .valueChanged)
        segment.translatesAutoresizingMaskIntoConstraints = false
        return segment
    }()
    
    lazy private var deleteButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor.red
        button.setTitle(ZenogaConfig.buttonDelete, for: .normal)
        button.addTarget(self, action: #selector(handleDeleteButton(_:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
       return button
    }()
    
    init(viewModel: PostViewModel) {
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
        setupConstrains()
        loadPost()
        loadUsers()
        group.notify(queue: .main) { [weak self] in
            self?.tableView.reloadData()
        }
    }
    
    override func viewWillAppear(_ animated: Bool){
        tableView.reloadData()
    }
}

private extension PostViewController {
    
    func configNavigation() {
        view.backgroundColor = UIColor.whiteColor
        navigationItem.title = ZenogaConfig.postTitle

        navigationController?.navigationBar.backgroundColor = UIColor.greenColor
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.whiteColor]
        
        let backItem = UIBarButtonItem()
        backItem.title = ""
        navigationItem.backBarButtonItem = backItem
        
        let image = UIImage(named: "reload_icon")
        let refreshButton = UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(handleRefreshButton))
        navigationItem.rightBarButtonItem = refreshButton
    }
    
    func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.showsVerticalScrollIndicator = false
        
        tableView.register(PostCell.self, forCellReuseIdentifier: PostCell.reuseidentifier)
    }
    
    func setupConstrains() {
        [segment, deleteButton, tableView].forEach{ view.addSubview($0) }
        
        NSLayoutConstraint.activate([
            segment.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: ZenogaConfig.spacelevel2),
            segment.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: ZenogaConfig.spacelevel3),
            segment.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -ZenogaConfig.spacelevel3),
            
            tableView.topAnchor.constraint(equalTo: segment.bottomAnchor, constant: ZenogaConfig.spacelevel4),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            deleteButton.topAnchor.constraint(equalTo: tableView.bottomAnchor, constant: ZenogaConfig.spacelevel4),
            deleteButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: ZenogaConfig.spacelevel4),
            deleteButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -ZenogaConfig.spacelevel4),
            deleteButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -ZenogaConfig.spacelevel7),
        ])
        deleteButton.layoutIfNeeded()
        deleteButton.layer.cornerRadius = deleteButton.frame.height/2
    }
    
    func loadUsers() {
        group.enter()
        viewModel.serviceCallback(with: .GET, model: [UserModel].self, endPoint: .users) { [weak self] result in
            switch result {
            case .success(let resp):
                self?.userList = resp
                self?.group.leave()
            case .failure(let error):
                print(error.localizedDescription)
                self?.group.leave()
            case .none:
                break
            }
        }
    }
    
    func loadPost() {
        group.enter()
        viewModel.serviceCallback(with: .GET, model: [PostModel].self, endPoint: .posts) { [weak self] result in
            switch result {
            case .success(let resp):
                self?.postList = resp
                self?.group.leave()
            case .failure(let error):
                print(error.localizedDescription)
                self?.group.leave()
            case .none:
                break
            }
        }
    }
    
    @objc func handleSegementChange(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            postList = auxList
            loadFavoriteList = false
            tableView.reloadData()
        case 1:
            auxList = postList
            favoriteList = realm.objects(FavoritesObject.self)
            loadFavoriteList = true
            tableView.reloadData()
        default:
            break
        }
    }
    
    @objc func handleRefreshButton(_ sender: UIButton) {
        if postList.count > 0 {
            showAlertView(message: "The post is not empty")
        } else {
            loadUsers()
            loadPost()
            group.notify(queue: .main) { [weak self] in
                self?.tableView.reloadData()
            }
        }
    }
    
    @objc func handleDeleteButton(_ sender: UIButton) {
        postList = []
        tableView.reloadData()
    }
}

extension PostViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return loadFavoriteList ? (favoriteList?.count ?? 0) : postList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PostCell.reuseidentifier, for: indexPath) as? PostCell else {
            return UITableViewCell()
        }
        
        if let list = favoriteList, loadFavoriteList {
            let postObj = list[indexPath.row].postObjt ?? PostObject()
            cell.accessoryType = .disclosureIndicator
            let model = PostModel(userID: postObj.userId, id: postObj.id, title: postObj.title, body: postObj.title)
            
            cell.config(model: model)
            return cell
        } else {
            let model = postList[indexPath.row]
            cell.accessoryType = .disclosureIndicator
            cell.config(model: model)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let list = favoriteList, loadFavoriteList {
            let postObj = list[indexPath.row].postObjt ?? PostObject()
            let postModel = PostModel(userID: postObj.userId, id: postObj.id, title: postObj.title, body: postObj.body)
            if let user = userList.filter({ $0.id == postObj.userId }).first {
                let detailVC = DetailViewController(user: user, post: postModel, viewModel: viewModel)
                navigationController?.pushViewController(detailVC, animated: true)
            }
        } else {
            let post  = postList[indexPath.row]
            if let user = userList.filter({ $0.id == post.userID }).first {
                let detailVC = DetailViewController(user: user, post: post, viewModel: viewModel)
                navigationController?.pushViewController(detailVC, animated: true)
            }
        }
    }
}
