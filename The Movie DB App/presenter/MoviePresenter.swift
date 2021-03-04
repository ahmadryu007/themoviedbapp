//
//  MoviePresenter.swift
//  The Movie DB App
//
//  Created by Ahmad Krisman Ryuzaki on 4/3/21.
//

import Foundation

class MoviePresenter: MovieViewToPresenter {
    
    var interactor: MoviePresenterToInteractor?
    var view: MoviePresenterToView?
    var lastPageFetch: Int = 0
    
    func getMovieList(genreId: Int) {
        interactor?.getMovieList(id: genreId, page: lastPageFetch + 1)
    }
    
}

extension MoviePresenter: MovieInteractorToPresenter {
    
    func movieListRequestSuccess(data: Movies) {
        lastPageFetch = data.page
        view?.movieListLoaded(list: data)
    }
    
    func genreListRequestFail(code: String, message: String) {
        view?.showError(code: code, message: message)
    }
    
    
}
