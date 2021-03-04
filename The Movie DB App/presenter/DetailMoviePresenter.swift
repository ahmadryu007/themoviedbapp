//
//  DetailMoviePresenter.swift
//  The Movie DB App
//
//  Created by Ahmad Krisman Ryuzaki on 4/3/21.
//

import Foundation

class DetailMoviePresenter: DetailMovieInteractorToPresenter {
    
    var interactor: DetailMoviePresenterToInteractor?
    var view: DetailMoviePresenterToView?
    
    func videosRequestSuccess(data: Videos) {
        view?.videosLoaded(videos: data)
    }
    
    func videosRequestFail(code: String, message: String) {
        view?.showError(code: code, message: message)
    }
    
    
}

extension DetailMoviePresenter: DetailMovieViewToPresenter {
    
    func getVideos(movieId: Int) {
        interactor?.getVideosRequest(movieId: movieId)
    }
    
}
