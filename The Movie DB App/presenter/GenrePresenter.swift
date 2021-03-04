//
//  GenrePresenter.swift
//  The Movie DB App
//
//  Created by Ahmad Krisman Ryuzaki on 4/3/21.
//

import Foundation

class GenrePresenter: GenreViewToPresenter {
    
    var interactor: GenrePresenterToInteractor?
    var view: GenrePresenterToView?
    
    func getGenres() {
        interactor?.getMovieGenreList()
    }
    
    
}

extension GenrePresenter: GenreInteractorToPresenter {
    
    func genreListRequestSuccess(data: Genres) {
        view?.genreListLoaded(list: data)
    }
    
    func genreListRequestFail(code: String, message: String) {
        view?.showError(code: code, message: message)
    }
    
    
}
