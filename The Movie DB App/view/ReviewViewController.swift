//
//  ReviewViewController.swift
//  The Movie DB App
//
//  Created by Ahmad Krisman Ryuzaki on 5/3/21.
//

import UIKit

class ReviewViewController: UIViewController {
    
    var presenter: ReviewViewToPresenter?
    var movieId: Int!
    var data: [Review] = []
    
    let cellId = "reviewCellId"
    var footerLoadingView: UICollectionReusableView?
    var isLoading = false
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let view = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        
        view.backgroundColor = UIColor.white
        view.translatesAutoresizingMaskIntoConstraints = false
        view.dataSource = self
        view.delegate = self
        view.register(ReviewCell.self, forCellWithReuseIdentifier: cellId)
        view.register(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: "Footer")
        view.isHidden = true
        
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Review"
        view.backgroundColor = .white
        
        presenter?.getReview(movieId: movieId)
        Utility.basicLoading(superView: view)
        
        view.addSubview(collectionView)
        collectionView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        collectionView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        collectionView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        collectionView.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
    }
    
}

extension ReviewViewController: ReviewPresenterToView {
    
    func showError(code: String, message: String) {
        Utility.basicAlert(controller: self, title: code, message: message)
    }
    
    func reviewLoaded(review: Reviews) {
        Utility.hideBasicLoading(superView: view)
        collectionView.isHidden = false
        
        for value in review.results {
            data.append(value)
        }
        
        collectionView.reloadData()
    }
    
}

extension ReviewViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as? ReviewCell
        
        cell?.author.text = data[indexPath.row].author
        cell?.detailReview.text = data[indexPath.row].updatedAt
        cell?.contentReview.text = data[indexPath.row].content
        
        if let avatarUrl = data[indexPath.row].authorDetails.avatarPath {
            if let imageUrl = URL(string: Constants.imageBaseUrl + avatarUrl) {
                cell?.avatar.sd_setImage(with: imageUrl, placeholderImage: nil)
            }
        }
        
        return cell ?? ReviewCell()
    }
    
    
}

extension ReviewViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 270)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
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
            presenter?.getReview(movieId: movieId)
        }
    }
    
}


class ReviewCell: UICollectionViewCell {
    
    let avatar: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = view.frame.width / 2
        view.layer.masksToBounds = true
        view.contentMode = .scaleAspectFill
        
        return view
    }()
    
    let author: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .boldSystemFont(ofSize: 20)
        
        return label
    }()
    
    let detailReview: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .italicSystemFont(ofSize: 15)
        
        return label
    }()
    
    let contentReview: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .justified
        label.font = .systemFont(ofSize: 10)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(avatar)
        avatar.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5).isActive = true
        avatar.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 5).isActive = true
        avatar.widthAnchor.constraint(equalToConstant: 70).isActive = true
        avatar.heightAnchor.constraint(equalToConstant: 70).isActive = true
        
        contentView.addSubview(author)
        author.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5).isActive = true
        author.leftAnchor.constraint(equalTo: avatar.rightAnchor, constant: 20).isActive = true
        
        contentView.addSubview(detailReview)
        detailReview.topAnchor.constraint(equalTo: author.bottomAnchor, constant: 2).isActive = true
        detailReview.leftAnchor.constraint(equalTo: author.leftAnchor).isActive = true
        
        contentView.addSubview(contentReview)
        contentReview.topAnchor.constraint(equalTo: detailReview.bottomAnchor, constant: 15).isActive = true
        contentReview.leftAnchor.constraint(equalTo: author.leftAnchor).isActive = true
        contentReview.widthAnchor.constraint(equalToConstant: 240).isActive = true
        contentReview.heightAnchor.constraint(equalToConstant: 180).isActive = true
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
