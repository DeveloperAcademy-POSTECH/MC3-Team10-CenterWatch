import SwiftUI

struct FloatHeart: View {
    @State var points: [CGPoint] = [CGPoint.zero]
    @State var dragLocation: CGPoint?
    @State var tapLocation: CGPoint?

    var body: some View {
        let tapDetector = TapGesture()
            .onEnded {
                tapLocation = dragLocation
                guard let point = tapLocation else {
                    return
                }
                points.append(point)
            }

        let dragGesture = DragGesture(minimumDistance: 0, coordinateSpace: .global)
            .onChanged { value in
                self.dragLocation = value.location
            }

        ZStack {
            ForEach(points.indices, id: \.self) { index in
                CreateCircle(location: points[index])
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.black.scaledToFill())
        .ignoresSafeArea()
        .gesture(dragGesture.sequenced(before: tapDetector))
    }
}

struct CreateCircle: View {
    @State private var currentLocation: CGPoint
    @State private var onAppeared: Bool = false

    init(location: CGPoint) {
        currentLocation = location
    }

    var body: some View {
        Image(systemName: "heart.fill")
            .foregroundColor(Color.blue)
            .font(.system(size: 60))
            .position(currentLocation)
            .offset(y: onAppeared ? -1000 : 0)
            .scaleEffect(onAppeared ? 4 : 0.5)
            .opacity(onAppeared ? 1 : 0.7)
            .blur(radius: onAppeared ? 2 : 0)
            .onAppear() {
                withAnimation(.easeIn(duration: 3)) {
                    onAppeared.toggle()
                }
            }
    }
}

struct FloatHeart_Previews: PreviewProvider {
    static var previews: some View {
        FloatHeart()
    }
}
