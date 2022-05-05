//
//  PostViewController.swift
//  Zemoga
//
//  Created by Miguel Angel Saravia Belmonte on 5/4/22.
//

import UIKit

class PostViewController: UIViewController {

    private var viewModel: PostViewModel
    private var postList: [PostModel] = []
    private var auxList: [PostModel] = []
    private var userList: [UserModel] = []
    private var commentList: [CommentsModel] = []
    private var group = DispatchGroup()
    
    lazy private var tableView: UITableView = {
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
    }
    
    func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.rowHeight = UITableView.automaticDimension
        
        tableView.register(PostCell.self, forCellReuseIdentifier: PostCell.reuseidentifier)
    }
    
    func setupConstrains() {
        [segment, tableView].forEach{ view.addSubview($0) }
        
        NSLayoutConstraint.activate([
            segment.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: ZenogaConfig.spacelevel2),
            segment.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: ZenogaConfig.spacelevel3),
            segment.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -ZenogaConfig.spacelevel3),
            
            tableView.topAnchor.constraint(equalTo: segment.bottomAnchor, constant: ZenogaConfig.spacelevel4),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
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
            print("entro al 0")
            postList = auxList
            tableView.reloadData()
        case 1:
            auxList = postList
            postList = []
            tableView.reloadData()
        default:
            break
        }
    }
}

extension PostViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return postList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PostCell.reuseidentifier, for: indexPath) as? PostCell else {
            return UITableViewCell()
        }
        let model = postList[indexPath.row]
        cell.accessoryType = .disclosureIndicator
        cell.config(model: model)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let post  = postList[indexPath.row]
        if let user = userList.filter({ $0.id == post.userID }).first {
            let detailVC = DetailViewController(user: user, post: post, viewModel: viewModel)
            navigationController?.pushViewController(detailVC, animated: true)
        }
    }
}
