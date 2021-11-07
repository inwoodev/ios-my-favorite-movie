//
//  ios_my_favorite_movieTests.swift
//  ios-my-favorite-movieTests
//
//  Created by 황인우 on 2021/11/01.
//

@testable import ios_my_favorite_movie
import Nimble
import XCTest

class ios_my_favorite_movieTests: XCTestCase {
    var mockURLSession: MockURLSession!
    var movieRespository: MovieRepository!
    var movieService: MovieService!
    var movieTableViewModel: MovieTableViewModel!
    var favoriteMovieTableViewModel: FavoriteMovieTableViewModel!
    override func setUpWithError() throws {
        // given 뷰가 로드되면
        mockURLSession = MockURLSession()
        movieRespository = MovieRepository(urlSession: mockURLSession, requestFactory: RequestFactory())
        movieService = MovieService(movieRepository: movieRespository)
        movieTableViewModel = MovieTableViewModel(movieService: movieService)
        favoriteMovieTableViewModel = FavoriteMovieTableViewModel()
    }

    override func tearDownWithError() throws {
        mockURLSession = nil
        movieService = nil
        movieRespository = nil
        movieService = nil
        movieTableViewModel = nil
    }

    func test_메인화면에서_사용자가_해리포터를_검색하면_해리포터관련_영화검색_결과를_받아오는지_체크() {
        // given
        let expectedFirstMetaData = StubMetaData.firstMovie
        let expectedSecondMetaData = StubMetaData.secondMovie
        
        // when 사용자가 해리포터 검색을 하면
        movieTableViewModel.handleSearchInput("해리포터")
        
        // then 해리포터 영화에 대한 tableView로 데이터를 불러온다
        guard let movieContainer = movieTableViewModel.movieInformation.value else { return }
        expect(movieContainer).toEventually(containElementSatisfying({ metaData in
            return metaData.title == expectedFirstMetaData.title
        }))
        
        expect(movieContainer).toEventually(containElementSatisfying({ metaData in
            return metaData.title == expectedSecondMetaData.title
        }, "예상된 영화 이름과 검색된 영화 이름이 동일할 것이다."))
        
        expect(movieContainer).toEventually(contain([expectedFirstMetaData, expectedSecondMetaData]), description: "총 두 개의 영화가 검색 될 것이다.")
    }
    
    func test_메인화면에서_사용자가_특정영화의_즐겨찾기버튼_클릭하게되면_즐겨찾기_목록에_해당_영화가_추가되는지_체크() {
        // given 검색된 결과물이 tableView가 주어질 때
        let firstIndex = 0
        let stubMovieList = [StubMetaData.firstMovie, StubMetaData.secondMovie]
        movieTableViewModel.movieInformation.value?.append(contentsOf: stubMovieList)
        
        // when 사용자가 첫번째 cell의 영화를 즐겨찾기에 추가할 경우
        movieTableViewModel.handleFavoriteMovieStatus(of: firstIndex)
        guard let selectedMovie = movieTableViewModel.movieInformation.value?[firstIndex] else { return }
        favoriteMovieTableViewModel.addFavoriteMovie(selectedMovie: selectedMovie)
        
        // then
        expect(self.movieTableViewModel.movieInformation.value?[firstIndex].favoriteStatus).to(equal(.checked), description: "첫 번째 영화의 즐겨찾기 체크가 된다.")
        expect(self.favoriteMovieTableViewModel.favoriteList.value?.first?.title).to(equal(StubMetaData.firstMovie.title), description: "MovieTableViewModel에 체크된 영화가 favoriteTableViewModel에 추가 된다.")
    }
    
    func test_메인화면에서_사용자가_특정영화의_즐겨찾기를_해제하게되면_즐겨찾기_목록에서_해당_영화가_제거되는지_체크() {
        // given 즐겨찾기 목록에 영화가 추가되었을 때
        let secondIndex = 1
        let stubFavoriteMarkedMovieList = [StubMetaData.firstMovieMarkedFavorite, StubMetaData.secondMovieMarkedFavorite]
        movieTableViewModel.movieInformation.value?.append(contentsOf: stubFavoriteMarkedMovieList)
        favoriteMovieTableViewModel.favoriteList.value?.append(contentsOf: stubFavoriteMarkedMovieList)
        
        // when 사용자가 두 번째 cell의 영화의 즐겨찾기를 해제할 경우
        movieTableViewModel.handleFavoriteMovieStatus(of: secondIndex)
        guard let titleOfMovieToBeRemoved = movieTableViewModel.movieInformation.value?[secondIndex].title else { return }
        favoriteMovieTableViewModel.removeUnfavoriteMovie(cheking: titleOfMovieToBeRemoved)
        
        // then
        expect(self.movieTableViewModel.movieInformation.value?[secondIndex].favoriteStatus).to(equal(.unchecked), description: "메인페이지의 두 번째 Cell의 영화의 즐겨찾기는 해제될 것이다.")
        expect(self.favoriteMovieTableViewModel.favoriteList.value).notTo(haveCount(2), description: "즐겨찾기 목록은 2개에서 1개로 줄어들 것이다")
        expect(self.favoriteMovieTableViewModel.favoriteList.value).to(haveCount(1), description: "즐겨찾기 목록은 2개에서 1개로 줄어들 것이다")
        expect(self.favoriteMovieTableViewModel.favoriteList.value).to(allPass({ $0?.title != StubMetaData.secondMovieMarkedFavorite.title}), description: "즐겨찾기 목록에 해제된 영화의 이름은 존재하지 않을 것이다.")
    }
}
