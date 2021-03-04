//
//  MovieProtocol.swift
//  The Movie DB App
//
//  Created by Ahmad Krisman Ryuzaki on 4/3/21.
//

import Foundation

protocol GenreViewToPresenter {
    func getGenres()
}

protocol GenrePresenterToView {
    func showError(code: String, message: String)
    func genreListLoaded(list: Genres)
}

protocol GenrePresenterToInteractor {
    func getMovieGenreList()
}

protocol GenreInteractorToPresenter {
    func genreListRequestSuccess(data: Genres)
    func genreListRequestFail(code: String, message: String)
}
