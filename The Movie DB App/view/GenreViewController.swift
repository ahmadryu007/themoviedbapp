//
//  ViewController.swift
//  The Movie DB App
//
//  Created by Ahmad Krisman Ryuzaki on 4/3/21.
//

import UIKit

class GenreViewController: UIViewController {
    
    var data: Genres?
    var presenter: GenreViewToPresenter?
    var cellId = "genreCellId"
    
    lazy var tableView: UITableView = {
        let view = UITableView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.dataSource = self
        view.delegate = self
        view.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
        
        return view
    }()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        title = "Select Genre"
        view.backgroundColor = .white
        
        presenter?.getGenres()
        Utility.basicLoading(superView: self.view)
    }

}

extension GenreViewController: GenrePresenterToView {
    
    func showError(code: String, message: String) {
        Utility.basicAlert(controller: self, title: code, message: message)
    }
    
    func genreListLoaded(list: Genres) {
        data = list
        
        view.addSubview(tableView)
        tableView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        tableView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        tableView.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
        tableView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        
        tableView.reloadData()
    }
    
}

extension GenreViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data?.genres.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        cell.textLabel?.text = data?.genres[indexPath.row].name
        cell.accessoryType = .disclosureIndicator
        
        return cell
    }
    
    
}

extension GenreViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = Router.movieRoute(genreId: data?.genres[indexPath.row].id ?? 0, genreName: data?.genres[indexPath.row].name ?? "")
        navigationController?.pushViewController(vc, animated: true)
    }
}

