//
//  DetailMovieViewController.swift
//  The Movie DB App
//
//  Created by Ahmad Krisman Ryuzaki on 4/3/21.
//

import UIKit
import youtube_ios_player_helper

class DetailMovieViewController: UIViewController {
    
    var presenter: DetailMovieViewToPresenter?
    var movie: Movie!
    
    lazy var scrollView: UIScrollView = {
        let scroll = UIScrollView(frame: view.frame)
        scroll.alwaysBounceVertical = true
        scroll.isUserInteractionEnabled = true
        
        return scroll
    }()
    
    let movieImage: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 20
        view.layer.masksToBounds = true
        view.contentMode = .scaleAspectFill
        
        return view
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.font = .boldSystemFont(ofSize: 25)
        label.textAlignment = .center
        
        return label
    }()
    
    let subtitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.font = .systemFont(ofSize: 20)
        label.textAlignment = .center
        
        return label
    }()
    
    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.font = .systemFont(ofSize: 17)
        label.textAlignment = .justified
        
        return label
    }()
    
    let footerView: YTPlayerView = {
        let view = YTPlayerView()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        view.backgroundColor = .white
        
        scrollView.contentSize = CGSize(width: view.frame.width, height: 950)
        scrollView.isScrollEnabled = true
        view.addSubview(scrollView)
        
        scrollView.addSubview(movieImage)
        movieImage.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        movieImage.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 20).isActive = true
        movieImage.widthAnchor.constraint(equalToConstant: 250).isActive = true
        movieImage.heightAnchor.constraint(equalToConstant: 330).isActive = true
        
        scrollView.addSubview(titleLabel)
        titleLabel.topAnchor.constraint(equalTo: movieImage.bottomAnchor, constant: 15).isActive = true
        titleLabel.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        titleLabel.widthAnchor.constraint(equalToConstant: 230).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        scrollView.addSubview(subtitleLabel)
        subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 1).isActive = true
        subtitleLabel.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        subtitleLabel.widthAnchor.constraint(equalToConstant: 260).isActive = true
        subtitleLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        scrollView.addSubview(descriptionLabel)
        descriptionLabel.topAnchor.constraint(equalTo: subtitleLabel.bottomAnchor, constant: 10).isActive = true
        descriptionLabel.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        descriptionLabel.widthAnchor.constraint(equalToConstant: scrollView.frame.width - 40).isActive = true
        descriptionLabel.heightAnchor.constraint(equalToConstant: 200).isActive = true
        
        scrollView.addSubview(footerView)
        footerView.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 5).isActive = true
        footerView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        footerView.widthAnchor.constraint(equalToConstant: view.frame.width - 40).isActive = true
        footerView.heightAnchor.constraint(equalToConstant: view.frame.height * 0.4).isActive = true
        
        let imageUrl = URL(string: Constants.imageBaseUrl + movie.posterPath)!
        movieImage.sd_setImage(with: imageUrl, placeholderImage: nil)
        
        titleLabel.text = movie.originalTitle
        subtitleLabel.text = "\(movie.popularity), \(movie.voteAverage)"
        descriptionLabel.text = movie.overview
        
        presenter?.getVideos(movieId: movie.id)
        Utility.basicLoading(superView: footerView)
        
        let rightItemBar = UIBarButtonItem(title: "Review", style: .plain, target: self, action: #selector(goToReview(sender:)))
        navigationItem.setRightBarButton(rightItemBar, animated: true)
    }
    
    @objc func goToReview(sender: Any){
        let vc = Router.reviewRoute(movieId: movie.id)
        present(vc, animated: true, completion: nil)
    }
}

extension DetailMovieViewController: DetailMoviePresenterToView {
    
    func showError(code: String, message: String) {
        Utility.basicAlert(controller: self, title: code, message: message)
    }
    
    func videosLoaded(videos: Videos) {
        Utility.hideBasicLoading(superView: footerView)
        
        footerView.load(withVideoId: videos.results[0].key)
    }
    
}
