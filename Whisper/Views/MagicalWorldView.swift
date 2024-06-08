import SwiftUI
import ARKit
import RealityKit
import AVFoundation

struct MagicalWorldView: View {
    @State private var backgroundMusicPlayer: AVAudioPlayer?

       var body: some View {
           ARViewContainerEnchantedVillage()
               .edgesIgnoringSafeArea(.all)
               .navigationBarTitle("Home")
               .onAppear {
                   startBackgroundMusic()
               }
               .onDisappear {
                   stopBackgroundMusic()
               }
       }

       func startBackgroundMusic() {
           guard let musicURL = Bundle.main.url(forResource: "the-magic-tree", withExtension: "mp3") else {
               print("Unable to locate sound file")
               return
           }

           do {
               backgroundMusicPlayer = try AVAudioPlayer(contentsOf: musicURL)
               backgroundMusicPlayer?.numberOfLoops = -1 // Repeat indefinitely
               backgroundMusicPlayer?.play()
           } catch {
               print("Error playing sound: \(error.localizedDescription)")
           }
       }

       func stopBackgroundMusic() {
           backgroundMusicPlayer?.stop()
       }
   }

   struct ARViewContainerEnchantedVillage: UIViewRepresentable {
       static var arViewInstance: ARView?

       func makeUIView(context: Context) -> ARView {
           let arView = ARView(frame: .zero)
           ARViewContainerEnchantedVillage.arViewInstance = arView

           // Setup the skybox in the AR scene
           configureSkybox(for: arView)

           return arView
       }

       func updateUIView(_ uiView: ARView, context: Context) {}

       func configureSkybox(for arView: ARView) {
           // Locate the skybox model file
           guard let skyboxModelURL = Bundle.main.url(forResource: "Fairy_Castle_Night", withExtension: "usdz") else {
               print("Skybox model not found.")
               return
           }

           // Load the skybox model as an entity
           let skyboxEntity: Entity
           do {
               skyboxEntity = try Entity.load(contentsOf: skyboxModelURL)
           } catch {
               print("Error loading skybox entity: \(error.localizedDescription)")
               return
           }

           // Create an anchor entity and attach the skybox entity
           let skyboxAnchor = AnchorEntity(world: [0, 0, 0])
           skyboxAnchor.addChild(skyboxEntity)

           // Add the anchor to the AR scene
           arView.scene.addAnchor(skyboxAnchor)
       }
}

#Preview {
    MagicalWorldView()
}


