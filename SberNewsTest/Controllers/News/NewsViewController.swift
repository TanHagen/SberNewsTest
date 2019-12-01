//
//  ViewController.swift
//  SberNewsTest
//
//  Created by Anton Zaitcev on 29/11/2019.
//  Copyright © 2019 Anton Zaitcev. All rights reserved.
//

import UIKit
import SnapKit
import CoreData

class NewsViewController: UIViewController, UIGestureRecognizerDelegate {
    
    let searchController = UISearchBar()
    let tableView = UITableView()
    var gestureRecognizer = UITapGestureRecognizer()
    
    lazy var context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    let viewModel: NewsViewModel
    
    init(_ viewModel: NewsViewModel = NewsViewModel()) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        view.backgroundColor = .white
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createConstraints()
        prepare()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        self.tableView.reloadData()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    func prepare() {
        searchController.delegate = self
        searchController.placeholder = "Enter your request..."
        searchController.layer.borderWidth = 1
        searchController.layer.borderColor = UIColor.white.cgColor
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 85
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(NewsTableViewCell.self, forCellReuseIdentifier: "newsCell")
    }
    
    func createConstraints() {
        
        view.addSubview(searchController)
        searchController.snp.makeConstraints { (make) in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(15)
            make.height.equalTo(40)
            make.left.right.equalToSuperview()
        }
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.top.equalTo(searchController.snp.bottom)
            make.left.right.bottom.equalToSuperview()
        }
    }
}

extension NewsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.newsArray.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
        viewModel.makeNewsAlreadySeen(index: indexPath.row)
        
        let news = viewModel.newsArray[indexPath.row]
        let viewModel = NewsDetailViewModel(detailNews: news)
        let newsDetailViewController = NewsDetailViewController(viewModel)
        navigationController?.pushViewController(newsDetailViewController, animated: true)
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "newsCell", for: indexPath) as! NewsTableViewCell
        
        let news = viewModel.newsArray[indexPath.row]
        
        let cellViewModel = NewsTableViewModel(news: news)
        cell.viewModel = cellViewModel
        
        return cell
    }
    
}

extension NewsViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        viewModel.getNews(request: searchBar.text!) { [weak self] (success, error, news) in
            guard let self = self else { return }
            
            if success {
                searchBar.text = ""
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            } else {
                print("Неудача")
            }
        }
    }
}
