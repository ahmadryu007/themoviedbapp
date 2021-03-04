//
//  MovieViewController.swift
//  The Movie DB App
//
//  Created by Ahmad Krisman Ryuzaki on 4/3/21.
//

import UIKit
import SDWebImage

class MovieViewController: UIViewController {
    
    var presenter: MovieViewToPresenter?
    var genreId: Int!
    var genreName: String!
    var isLoading = false
    
    var data: [Movie] = []
    let cellId = "movieCellId"
    var footerLoadingView: UICollectionReusableView?
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let view = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        
        view.backgroundColor = UIColor.white
        view.translatesAutoresizingMaskIntoConstraints = false
        view.dataSource = self
        view.delegate = self
        view.register(MovieCell.self, forCellWithReuseIdentifier: cellId)
        view.register(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: "Footer")
        view.isHidden = true
        
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = genreName
        view.backgroundColor = .white
        
        view.addSubview(collectionView)
        collectionView.topAnchor.constraint(equalToSystemSpacingBelow: view.safeAreaLayoutGuide.topAnchor, multiplier: 0).isActive = true
        collectionView.trailingAnchor.constraint(equalToSystemSpacingAfter: view.safeAreaLayoutGuide.trailingAnchor, multiplier: 0).isActive = true
        collectionView.leadingAnchor.constraint(equalToSystemSpacingAfter: view.safeAreaLayoutGuide.leadingAnchor, multiplier: 0).isActive = true
        collectionView.bottomAnchor.constraint(equalToSystemSpacingBelow: view.safeAreaLayoutGuide.bottomAnchor, multiplier: 0).isActive = true
        
        Utility.basicLoading(superView: view)
        presenter?.getMovieList(genreId: genreId)
    }
    
}

extension MovieViewController: MoviePresenterToView {
    
    func showError(code: String, message: String) {
        Utility.basicAlert(controller: self, title: code, message: message)
    }
    
    func movieListLoaded(list: Movies) {
        
        Utility.hideBasicLoading(superView: view)
        collectionView.isHidden = false
        isLoading = false
        
        for movie in list.results {
            data.append(movie)
        }
        
        collectionView.reloadData()
    }
    
}

extension MovieViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as? MovieCell
        
        cell?.movieName.text = data[indexPath.row].title
        
        let imageUrl = URL(string: Constants.imageBaseUrl + (self.data[indexPath.row].posterPath))!
        cell?.movieImage.sd_setImage(with: imageUrl, placeholderImage: nil)
        
        return cell ?? MovieCell()
    }
    
    
}

extension MovieViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = Router.detailMovieRoute(movie: data[indexPath.row])
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 140, height: 200)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 20, bottom: 20, right: 20)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        if isLoading {
            return CGSize.zero
        } else {
            return CGSize(width: collectionView.bounds.width, height: 100)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionFooter {
            let aFooterView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "Footer", for: indexPath)
            footerLoadingView = aFooterView
            footerLoadingView?.backgroundColor = UIColor.clear
            return aFooterView
        }
        return UICollectionReusableView()
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplaySupplementaryView view: UICollectionReusableView, forElementKind elementKind: String, at indexPath: IndexPath) {
        if elementKind == UICollectionView.elementKindSectionFooter {
            if let footer = footerLoadingView {
                Utility.basicLoading(superView: footer)
            }
        }
    }

    func collectionView(_ collectionView: UICollectionView, didEndDisplayingSupplementaryView view: UICollectionReusableView, forElementOfKind elementKind: String, at indexPath: IndexPath) {
        if elementKind == UICollectionView.elementKindSectionFooter {
            if let footer = footerLoadingView {
                Utility.hideBasicLoading(superView: footer)
            }
        }
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if (!isLoading) {
            isLoading = true
            presenter?.getMovieList(genreId: genreId)
        }
    }
    
}

class MovieCell: UICollectionViewCell {
    
    let movieName: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .boldSystemFont(ofSize: 20)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        
        return label
    }()
    
    lazy var movieImage: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 20
        view.layer.masksToBounds = true
        view.contentMode = .scaleAspectFill
        
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(movieImage)
        movieImage.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        movieImage.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        movieImage.widthAnchor.constraint(equalToConstant: 150).isActive = true
        movieImage.heightAnchor.constraint(equalToConstant: 150).isActive = true
        
        contentView.addSubview(movieName)
        movieName.topAnchor.constraint(equalTo: movieImage.bottomAnchor, constant: 7).isActive = true
        movieName.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        movieName.heightAnchor.constraint(equalToConstant: 30).isActive = true
        movieName.widthAnchor.constraint(equalToConstant: 130).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
