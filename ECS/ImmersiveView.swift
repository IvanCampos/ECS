//
//  ImmersiveView.swift
//  ECS
//
//  Created by IVAN CAMPOS on 7/26/25.
//

import SwiftUI
import RealityKit
import RealityKitContent

struct ImmersiveView: View {
    @Environment(AppModel.self) var appModel

    var body: some View {
        RealityView { content in
            // Add the initial RealityKit content
            if let immersiveContentEntity = try? await Entity(named: "SkyDome", in: realityKitContentBundle) {
                content.add(immersiveContentEntity)
            }
            
            // Anchor one meter in front of the user’s head pose.
            let anchor = AnchorEntity(.head)
            anchor.position = [0, 0, -1.0]

            // Helper for creating a cube entity at the next grid position.
            var index = 0
            let columns = 5
            let spacingX: Float = 0.5
            let spacingZ: Float = 0.4
            func nextPosition() -> SIMD3<Float> {
                defer { index += 1 }
                let row = index / columns
                let col = index % columns
                return [Float(col) * spacingX - 1.0, 0, -1.0 - Float(row) * spacingZ]
            }

            func makeCube() -> ModelEntity {
                ModelEntity(
                    mesh: .generateBox(size: 0.25),
                    materials: [SimpleMaterial(color: .cyan, isMetallic: false)]
                )
            }

            // Rotate component example (existing cube).
            let rotateCube = makeCube()
            rotateCube.position = nextPosition()
            rotateCube.components.set(RotateComponent(axis: [0, 1, 0], speed: .pi))
            anchor.addChild(rotateCube)

            // Blink component example.
            let blinkCube = makeCube()
            blinkCube.position = nextPosition()
            blinkCube.components.set(BlinkComponent(interval: 0.5))
            anchor.addChild(blinkCube)

            // Bob component example.
            let bobCube = makeCube()
            bobCube.position = nextPosition()
            bobCube.components.set(BobComponent(amplitude: 0.1, speed: 2))
            anchor.addChild(bobCube)

            // Color component example.
            let colorCube = makeCube()
            colorCube.position = nextPosition()
            colorCube.components.set(ColorComponent(color: .red))
            anchor.addChild(colorCube)

            // Drift component example.
            let driftCube = makeCube()
            driftCube.position = nextPosition()
            driftCube.components.set(DriftComponent(velocity: [0.1, 0, 0]))
            anchor.addChild(driftCube)

            // Elastic component example.
            let elasticCube = makeCube()
            elasticCube.position = nextPosition()
            elasticCube.components.set(ElasticComponent(amplitude: 0.2, speed: 3))
            anchor.addChild(elasticCube)

            // Expire component example.
            let expireCube = makeCube()
            expireCube.position = nextPosition()
            expireCube.components.set(ExpireComponent(timeRemaining: 10))
            anchor.addChild(expireCube)

            // Fade component example.
            let fadeCube = makeCube()
            fadeCube.position = nextPosition()
            fadeCube.components.set(FadeComponent(rate: 0.1, alpha: 1))
            anchor.addChild(fadeCube)

            // FlashColor component example.
            let flashCube = makeCube()
            flashCube.position = nextPosition()
            flashCube.components.set(FlashColorComponent(interval: 1))
            anchor.addChild(flashCube)

            // Glow component example.
            let glowCube = makeCube()
            glowCube.position = nextPosition()
            glowCube.components.set(GlowComponent(intensity: 0.5))
            anchor.addChild(glowCube)

            // Gravity component example.
            let gravityCube = makeCube()
            gravityCube.position = nextPosition()
            gravityCube.components.set(GravityComponent())
            anchor.addChild(gravityCube)

            // Grow component example.
            let growCube = makeCube()
            growCube.position = nextPosition()
            growCube.components.set(GrowComponent(rate: 0.1))
            anchor.addChild(growCube)

            // Jitter component example.
            let jitterCube = makeCube()
            jitterCube.position = nextPosition()
            jitterCube.components.set(JitterComponent(amplitude: 0.02))
            anchor.addChild(jitterCube)

            // Lifetime component example.
            let lifetimeCube = makeCube()
            lifetimeCube.position = nextPosition()
            lifetimeCube.components.set(LifetimeComponent(timeRemaining: 12))
            anchor.addChild(lifetimeCube)

            // Magnet component example.
            let magnetCube = makeCube()
            magnetCube.position = nextPosition()
            magnetCube.components.set(MagnetComponent(target: .zero, strength: 0.5))
            anchor.addChild(magnetCube)

            // Move component example.
            let moveCube = makeCube()
            moveCube.position = nextPosition()
            moveCube.components.set(MoveComponent(velocity: [0.1, 0, 0]))
            anchor.addChild(moveCube)

            // My component example.
            let myCube = makeCube()
            myCube.position = nextPosition()
            myCube.components.set(MyComponent())
            anchor.addChild(myCube)

            // Orbit component example.
            let orbitCube = makeCube()
            orbitCube.position = nextPosition()
            orbitCube.components.set(OrbitComponent(center: orbitCube.position, axis: [0,1,0], speed: 1))
            anchor.addChild(orbitCube)

            // Oscillate component example.
            let oscillateCube = makeCube()
            oscillateCube.position = nextPosition()
            oscillateCube.components.set(OscillateComponent(axis: [1,0,0], amplitude: 0.2, speed: 2))
            anchor.addChild(oscillateCube)

            // PathMove component example.
            let pathMoveCube = makeCube()
            pathMoveCube.position = nextPosition()
            pathMoveCube.components.set(PathMoveComponent(start: pathMoveCube.position, end: pathMoveCube.position + [0.3,0,0], speed: 0.3))
            anchor.addChild(pathMoveCube)

            // Pulse component example.
            let pulseCube = makeCube()
            pulseCube.position = nextPosition()
            pulseCube.components.set(PulseComponent(amplitude: 0.2, speed: 2))
            anchor.addChild(pulseCube)

            // Repel component example.
            let repelCube = makeCube()
            repelCube.position = nextPosition()
            repelCube.components.set(RepelComponent(target: [0,0,-1], strength: 0.5))
            anchor.addChild(repelCube)

            // Scale component example.
            let scaleCube = makeCube()
            scaleCube.position = nextPosition()
            scaleCube.components.set(ScaleComponent(rate: 0.1))
            anchor.addChild(scaleCube)

            // Shake component example.
            let shakeCube = makeCube()
            shakeCube.position = nextPosition()
            shakeCube.components.set(ShakeComponent(amplitude: 0.05, speed: 5))
            anchor.addChild(shakeCube)

            // Shrink component example.
            let shrinkCube = makeCube()
            shrinkCube.position = nextPosition()
            shrinkCube.components.set(ShrinkComponent(rate: 0.1))
            anchor.addChild(shrinkCube)

            // Slide component example.
            let slideCube = makeCube()
            slideCube.position = nextPosition()
            slideCube.components.set(SlideComponent(axis: [1,0,0], speed: 0.3, length: 0.5))
            anchor.addChild(slideCube)

            // Spin component example.
            let spinCube = makeCube()
            spinCube.position = nextPosition()
            spinCube.components.set(SpinComponent(axis: [0,1,0], speed: .pi))
            anchor.addChild(spinCube)

            // Strobe component example.
            let strobeCube = makeCube()
            strobeCube.position = nextPosition()
            strobeCube.components.set(StrobeComponent(interval: 0.5, colorA: .blue, colorB: .green))
            anchor.addChild(strobeCube)

            // Tilt component example.
            let tiltCube = makeCube()
            tiltCube.position = nextPosition()
            tiltCube.components.set(TiltComponent(axis: [0,0,1], amplitude: .pi/8, speed: 2))
            anchor.addChild(tiltCube)

            // Vibrate component example.
            let vibrateCube = makeCube()
            vibrateCube.position = nextPosition()
            vibrateCube.components.set(VibrateComponent(amplitude: .pi/8, speed: 10))
            anchor.addChild(vibrateCube)

            // Wander component example.
            let wanderCube = makeCube()
            wanderCube.position = nextPosition()
            wanderCube.components.set(WanderComponent(range: 0.2))
            anchor.addChild(wanderCube)

            content.add(anchor)
            
        }
    }
}

//#Preview(immersionStyle: .full) {
//    ImmersiveView()
//        .environment(AppModel())
//}
