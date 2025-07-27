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
            growCube.components.set(GrowComponent(rate: 0.001))
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

            // Bounce component example.
            let bounceCube = makeCube()
            bounceCube.position = nextPosition()
            bounceCube.components.set(BounceComponent(amplitude: 0.1, speed: 2, origin: bounceCube.position))
            anchor.addChild(bounceCube)

            // Twist component example.
            let twistCube = makeCube()
            twistCube.position = nextPosition()
            twistCube.components.set(TwistComponent(axis: [0,1,0], speed: .pi))
            anchor.addChild(twistCube)

            // Flip component example.
            let flipCube = makeCube()
            flipCube.position = nextPosition()
            flipCube.components.set(FlipComponent(axis: [1,0,0], speed: .pi))
            anchor.addChild(flipCube)

            // Hover component example.
            let hoverCube = makeCube()
            hoverCube.position = nextPosition()
            hoverCube.components.set(HoverComponent(height: 0.1, amplitude: 0.05, speed: 2, origin: hoverCube.position))
            anchor.addChild(hoverCube)

            // Seek component example.
            let seekCube = makeCube()
            seekCube.position = nextPosition()
            seekCube.components.set(SeekComponent(target: .zero, speed: 0.2))
            anchor.addChild(seekCube)

            // Stretch component example.
            let stretchCube = makeCube()
            stretchCube.position = nextPosition()
            stretchCube.components.set(StretchComponent(axis: [1,0,0], amplitude: 0.2, speed: 0.2))
            anchor.addChild(stretchCube)

            // RandomColor component example.
            let randomColorCube = makeCube()
            randomColorCube.position = nextPosition()
            randomColorCube.components.set(RandomColorComponent(interval: 1))
            anchor.addChild(randomColorCube)

            // Teleport component example.
            let teleportCube = makeCube()
            teleportCube.position = nextPosition()
            teleportCube.components.set(TeleportComponent(interval: 2, range: 0.2))
            anchor.addChild(teleportCube)

            // Transparency component example.
            let transparencyCube = makeCube()
            transparencyCube.position = nextPosition()
            transparencyCube.components.set(TransparencyComponent(rate: 0.2, alpha: 1))
            anchor.addChild(transparencyCube)

            // Spiral component example.
            let spiralCube = makeCube()
            spiralCube.position = nextPosition()
            spiralCube.components.set(SpiralComponent(center: spiralCube.position, radius: 0.2, speed: 2, heightSpeed: 0.1))
            anchor.addChild(spiralCube)

            // PulseColor component example.
            let pulseColorCube = makeCube()
            pulseColorCube.position = nextPosition()
            pulseColorCube.components.set(PulseColorComponent(colorA: [1,1,1], colorB: [1,0,0], speed: 2))
            anchor.addChild(pulseColorCube)

            // Flicker component example.
            let flickerCube = makeCube()
            flickerCube.position = nextPosition()
            flickerCube.components.set(FlickerComponent(probability: 0.1))
            anchor.addChild(flickerCube)

            // Snap component example.
            let snapCube = makeCube()
            snapCube.position = nextPosition()
            snapCube.components.set(SnapComponent(gridSize: 0.1))
            anchor.addChild(snapCube)

            // Beeline component example.
            let beelineCube = makeCube()
            beelineCube.position = nextPosition()
            beelineCube.components.set(BeelineComponent(direction: [0,0,-1], speed: 0.2))
            anchor.addChild(beelineCube)

            // Boomerang component example.
            let boomerangCube = makeCube()
            boomerangCube.position = nextPosition()
            boomerangCube.components.set(BoomerangComponent(start: boomerangCube.position, end: boomerangCube.position + [0,0,0.3], speed: 0.2))
            anchor.addChild(boomerangCube)

            // Twinkle component example.
            let twinkleCube = makeCube()
            twinkleCube.position = nextPosition()
            twinkleCube.components.set(TwinkleComponent(interval: 0.5))
            anchor.addChild(twinkleCube)

            // RandomScale component example.
            let randomScaleCube = makeCube()
            randomScaleCube.position = nextPosition()
            randomScaleCube.components.set(RandomScaleComponent(range: 0.02))
            anchor.addChild(randomScaleCube)

            // Wobble component example.
            let wobbleCube = makeCube()
            wobbleCube.position = nextPosition()
            wobbleCube.components.set(WobbleComponent(axis: [1,0,0], amplitude: .pi/8, speed: 3))
            anchor.addChild(wobbleCube)

            // Align component example.
            let alignCube = makeCube()
            alignCube.position = nextPosition()
            alignCube.components.set(AlignComponent())
            anchor.addChild(alignCube)

            // ZigZag component example.
            let zigzagCube = makeCube()
            zigzagCube.position = nextPosition()
            zigzagCube.components.set(ZigZagComponent(axis: [1,0,0], speed: 0.2, length: 0.3))
            anchor.addChild(zigzagCube)

            content.add(anchor)
            
        }
    }
}

//#Preview(immersionStyle: .full) {
//    ImmersiveView()
//        .environment(AppModel())
//}
