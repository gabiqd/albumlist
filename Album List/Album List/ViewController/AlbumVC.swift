//
//  AlbumVC.swift
//  Album List
//
//  Created by Gabriel on 04/12/2020.
//  Copyright © 2020 Gabriel Quispe Delgadillo. All rights reserved.
//

import UIKit

class AlbumVC: UIViewController {
    private let cellID = "albumCellID"
    private var tableView: UITableView!
    private let loadingViewController = LoadingViewController()
    
    lazy private(set) var viewModel: AlbumListViewModel = {
        let service = NetworkService()
        let viewModel = AlbumListViewModel(networkService: service)
        return viewModel
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        
        initViews()
        setUpConstraints()
        
        self.add(loadingViewController)
        
        viewModel.onAlbumsListUpdated = { [weak self] viewModel in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
                self?.loadingViewController.remove()
            }
        }
    }
    
    func initViews() {
        tableView = {
            let tableView = UITableView()
            tableView.translatesAutoresizingMaskIntoConstraints = false
            tableView.dataSource = self
            tableView.delegate = self
            tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellID)
            return tableView
        }()
    }
    
    func setUpConstraints() {
        self.view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: self.view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
        ])
    }
}

extension AlbumVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        
        let photoVC = PhotosVC(with: viewModel.albumsViewModels[indexPath.row].id)
        self.navigationController?.pushViewController(photoVC, animated: true)
    }
}

extension AlbumVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.albumsViewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath)
        cell.textLabel?.text = viewModel.albumsViewModels[indexPath.row].title
        
        return cell
    }
    
    
}
