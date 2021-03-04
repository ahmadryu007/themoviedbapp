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
}
