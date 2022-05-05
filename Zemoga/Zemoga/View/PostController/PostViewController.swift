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
    
    lazy private var tableView: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
       return table
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
    }
    
    private func configNavigation() {
        view.backgroundColor = UIColor.whiteColor
        navigationItem.title = "Posts"

        navigationController?.navigationBar.backgroundColor = UIColor.greenColor
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.whiteColor]
    }
    
    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.rowHeight = UITableView.automaticDimension
        
        tableView.register(PostCell.self, forCellReuseIdentifier: PostCell.reuseidentifier)
    }
    
    private func setupConstrains() {
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func loadPost() {
        viewModel.servicePost { [weak self] result in
            switch result {
            case .success(let resp):
                self?.postList = resp
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            case .failure(let error):
                print(error.localizedDescription)
            case .none:
                break
            }
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
        cell.config(model: model)
        return cell
    }
    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return view.frame.height * 0.15
//    }
}
