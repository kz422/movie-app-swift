import SwiftUI

struct MoviereviewView: View {
    var movie: Movie
    
    @ObservedObject var movieReviewManager: MovieReviewsManager
    
    init(movie: Movie) {
        self.movie = movie
        self.movieReviewManager = MovieReviewsManager(movie: movie)
        
        UITableView.appearance().separatorStyle = .none
        UITableView.appearance().backgroundColor = .clear
        
        UITableViewCell.appearance().backgroundColor = .clear
    }
    
    var body: some View {
        ZStack {
            List {
                ForEach(movieReviewManager.reviews) { review in
                        Text(review.author ?? "")
                            .font(.title)
                            .bold()
                        
                        Text(review.content ?? "")
                            .font(.body)
                            .lineLimit(nil)
                }
            }
            .onAppear {
                movieReviewManager.getMovieReviews()
            }.listRowBackground(Color.clear)
            .padding(.top, 70)
        }.edgesIgnoringSafeArea(.all)
    }
}
