import SwiftUI

struct MovieCell: View {
    var movie: Movie
    
    var body: some View {
        HStack(alignment: .top, spacing: 20) {
            moviePoster
            
            VStack(alignment: .leading, spacing: 0) {
                movieTitle
                HStack {
                    movieVote
                    movieReleaseDate
                }
                movieOverview
            }.padding()
        }
    }
    
    private var moviePoster: some View {
        AsyncImage(url: URL(string: movie.posterPath)!) {
            Rectangle().foregroundColor(Color.gray.opacity(0.4))
        } image: { (img) -> Image in
            Image(uiImage: img)
                .resizable()
        }
        .frame(width: 100, height: 160)
        .animation(.easeInOut(duration: 0.5))
        .transition(.opacity)
        .scaledToFill()
        .cornerRadius(15)
        .shadow(radius: 15)
    }
    
    private var movieTitle: some View {
        Text(movie.title ?? "")
            .font(.system(size: 15))
            .bold()
            .foregroundColor(.blue)
    }
    
    private var movieVote: some View {
        ZStack {
            Circle()
                .trim(from: 0, to: CGFloat(movie.voteAverage))
                .stroke(Color.orange, lineWidth: 4)
                .frame(width: 40)
                .rotationEffect(.degrees(-90))
            Circle()
                .trim(from: 0, to: CGFloat(1))
                .stroke(Color.orange.opacity(0.2), lineWidth: 4)
                .frame(width: 40)
                .rotationEffect(.degrees(-90))
            Text(String.init(format: "%0.2f", movie.vote_average ?? 0.0))
                .foregroundColor(.orange)
                .font(.subheadline)
        }.frame(height: 80)
    }
    
    private var movieReleaseDate: some View {
        Text("\(movie.release_date ?? "-")公開")
            .foregroundColor(.gray)
            .font(.subheadline)
    }
    
    private var movieOverview: some View {
        movie.overview?.count == 0 ?
        Text("説明がありません")
            .font(.caption)
            .foregroundColor(Color.gray)
            .truncationMode(.tail)
            .lineLimit(7)
        : Text(movie.overview ?? "説明がありません")
            .font(.caption)
            .foregroundColor(Color.gray)
            .truncationMode(.tail)
            .lineLimit(7)
    }
}
