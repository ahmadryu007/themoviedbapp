//
//  Router.swift
//  The Movie DB App
//
//  Created by Ahmad Krisman Ryuzaki on 4/3/21.
//

import UIKit

class Router {
    
    class func genreRoute() -> UIViewController {
        
        let interactor = GenreInteractor()
        let presenter = GenrePresenter()
        let view = GenreViewController()
        
        interactor.presenter = presenter
        presenter.interactor = interactor
        presenter.view = view
        view.presenter = presenter
        
        return view
    }
    
    class func movieRoute(genreId: Int, genreName: String) -> UIViewController {
        
        let interactor = MovieInteractor()
        let presenter = MoviePresenter()
        let view = MovieViewController()
        
        interactor.presenter = presenter
        presenter.interactor = interactor
        presenter.view = view
        
        view.presenter = presenter
        view.genreId = genreId
        view.genreName = genreName
        
        return view
        
    }
    
    class func detailMovieRoute(movie: Movie) -> UIViewController {
        
        let interactor = DetailMovieInteractor()
        let presenter = DetailMoviePresenter()
        let view = DetailMovieViewController()
        
        interactor.presenter = presenter
        presenter.interactor = interactor
        presenter.view = view
        
        view.presenter = presenter
        view.movie = movie
        
        return view
        
    }
    
    class func reviewRoute(movieId: Int) -> UIViewController {
        
        let interactor = ReviewInteractor()
        let presenter = ReviewPresenter()
        let view = ReviewViewController()
        
        interactor.presenter = presenter
        presenter.interactor = interactor
        presenter.view = view
        
        view.presenter = presenter
        view.movieId = movieId
        
        return view
    }
}
