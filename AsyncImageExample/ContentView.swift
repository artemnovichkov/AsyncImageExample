//
//  Created by Artem Novichkov on 8.06.2021.
//

import SwiftUI

struct ContentView: View {

    private let url = URL(string: "https://picsum.photos/200")

    var body: some View {
        List {
            ForEach(0..<10) { _ in
                AsyncImage(url: url,
                           content: view)
                    .listRowInsets(.init(.zero))
            }
        }
        .listStyle(.plain)
    }

    @ViewBuilder
    private func view(for phase: AsyncImagePhase) -> some View {
        switch phase {
        case .empty:
            ProgressView()
        case .success(let image):
            image
                .resizable()
                .aspectRatio(contentMode: .fit)
        case .failure(let error):
            VStack(spacing: 16) {
                Image(systemName: "xmark.octagon.fill")
                    .foregroundColor(.red)
                Text(error.localizedDescription)
                    .multilineTextAlignment(.center)
            }
        @unknown default:
            Text("Unknown")
                .foregroundColor(.gray)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
