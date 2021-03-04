//
//  MovieProtocol.swift
//  The Movie DB App
//
//  Created by Ahmad Krisman Ryuzaki on 4/3/21.
//

import Foundation

// MARK: - Genres
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

// MARK: - Movie
protocol MovieViewToPresenter {
    func getMovieList(genreId: Int)
}

protocol MoviePresenterToView {
    func showError(code: String, message: String)
    func movieListLoaded(list: Movies)
}

protocol MoviePresenterToInteractor {
    func getMovieList(id: Int, page: Int)
}

protocol MovieInteractorToPresenter {
    func movieListRequestSuccess(data: Movies)
    func genreListRequestFail(code: String, message: String)
}

// MARK: - Detail Movie
protocol DetailMovieViewToPresenter {
    func getVideos(movieId: Int)
}

protocol DetailMoviePresenterToView {
    func showError(code: String, message: String)
    func videosLoaded(videos: Videos)
}

protocol DetailMoviePresenterToInteractor {
    func getVideosRequest(movieId: Int)
}

protocol DetailMovieInteractorToPresenter {
    func videosRequestSuccess(data: Videos)
    func videosRequestFail(code: String, message: String)
}
