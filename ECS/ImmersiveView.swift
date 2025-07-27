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
            
            // Anchor one meter in front of the user’s head pose. (.head)
            let anchor = AnchorEntity()
            anchor.position = [0, 1.4, -1.0]

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

            func attachLabel(to entity: Entity, text: String) {
                let label = Entity()
                label.position.y += 0.3
                let attachment = ViewAttachmentComponent(
                    rootView: Text(text)
                        .font(.caption)
                        .foregroundStyle(.white)
                )
                label.components.set(attachment)
                entity.addChild(label)
            }

            // Rotate component example (existing cube).
            let rotateCube = makeCube()
            rotateCube.position = nextPosition()
            rotateCube.components.set(RotateComponent(axis: [0, 1, 0], speed: .pi))
            attachLabel(to: rotateCube, text: "RotateComponent")
            anchor.addChild(rotateCube)

            // Blink component example.
            let blinkCube = makeCube()
            blinkCube.position = nextPosition()
            blinkCube.components.set(BlinkComponent(interval: 0.5))
            attachLabel(to: blinkCube, text: "BlinkComponent")
            anchor.addChild(blinkCube)

            // Bob component example.
            let bobCube = makeCube()
            bobCube.position = nextPosition()
            bobCube.components.set(BobComponent(amplitude: 0.1, speed: 2))
            attachLabel(to: bobCube, text: "BobComponent")
            anchor.addChild(bobCube)

            // Color component example.
            let colorCube = makeCube()
            colorCube.position = nextPosition()
            colorCube.components.set(ColorComponent(color: .red))
            attachLabel(to: colorCube, text: "ColorComponent")
            anchor.addChild(colorCube)

            // Drift component example.
            let driftCube = makeCube()
            driftCube.position = nextPosition()
            driftCube.components.set(DriftComponent(velocity: [0.1, 0, 0]))
            attachLabel(to: driftCube, text: "DriftComponent")
            anchor.addChild(driftCube)

            // Elastic component example.
            let elasticCube = makeCube()
            elasticCube.position = nextPosition()
            elasticCube.components.set(ElasticComponent(amplitude: 0.2, speed: 3))
            attachLabel(to: elasticCube, text: "ElasticComponent")
            anchor.addChild(elasticCube)

            // Expire component example.
            let expireCube = makeCube()
            expireCube.position = nextPosition()
            expireCube.components.set(ExpireComponent(timeRemaining: 10))
            attachLabel(to: expireCube, text: "ExpireComponent")
            anchor.addChild(expireCube)

            // Fade component example.
            let fadeCube = makeCube()
            fadeCube.position = nextPosition()
            fadeCube.components.set(FadeComponent(rate: 0.1, alpha: 1))
            attachLabel(to: fadeCube, text: "FadeComponent")
            anchor.addChild(fadeCube)

            // FlashColor component example.
            let flashCube = makeCube()
            flashCube.position = nextPosition()
            flashCube.components.set(FlashColorComponent(interval: 1))
            attachLabel(to: flashCube, text: "FlashColorComponent")
            anchor.addChild(flashCube)

            // Glow component example.
            let glowCube = makeCube()
            glowCube.position = nextPosition()
            glowCube.components.set(GlowComponent(intensity: 0.5))
            attachLabel(to: glowCube, text: "GlowComponent")
            anchor.addChild(glowCube)

            // Gravity component example.
            let gravityCube = makeCube()
            gravityCube.position = nextPosition()
            gravityCube.components.set(GravityComponent())
            attachLabel(to: gravityCube, text: "GravityComponent")
            anchor.addChild(gravityCube)

            // Grow component example.
            let growCube = makeCube()
            growCube.position = nextPosition()
            growCube.components.set(GrowComponent(rate: 0.001))
            attachLabel(to: growCube, text: "GrowComponent")
            anchor.addChild(growCube)

            // Jitter component example.
            let jitterCube = makeCube()
            jitterCube.position = nextPosition()
            jitterCube.components.set(JitterComponent(amplitude: 0.02))
            attachLabel(to: jitterCube, text: "JitterComponent")
            anchor.addChild(jitterCube)

            // Lifetime component example.
            let lifetimeCube = makeCube()
            lifetimeCube.position = nextPosition()
            lifetimeCube.components.set(LifetimeComponent(timeRemaining: 12))
            attachLabel(to: lifetimeCube, text: "LifetimeComponent")
            anchor.addChild(lifetimeCube)

            // Magnet component example.
            let magnetCube = makeCube()
            magnetCube.position = nextPosition()
            magnetCube.components.set(MagnetComponent(target: .zero, strength: 0.5))
            attachLabel(to: magnetCube, text: "MagnetComponent")
            anchor.addChild(magnetCube)

            // Move component example.
            let moveCube = makeCube()
            moveCube.position = nextPosition()
            moveCube.components.set(MoveComponent(velocity: [0.1, 0, 0]))
            attachLabel(to: moveCube, text: "MoveComponent")
            anchor.addChild(moveCube)

            // My component example.
            let myCube = makeCube()
            myCube.position = nextPosition()
            myCube.components.set(MyComponent())
            attachLabel(to: myCube, text: "MyComponent")
            anchor.addChild(myCube)

            // Orbit component example.
            let orbitCube = makeCube()
            orbitCube.position = nextPosition()
            orbitCube.components.set(OrbitComponent(center: orbitCube.position, axis: [0,1,0], speed: 1))
            attachLabel(to: orbitCube, text: "OrbitComponent")
            anchor.addChild(orbitCube)

            // Oscillate component example.
            let oscillateCube = makeCube()
            oscillateCube.position = nextPosition()
            oscillateCube.components.set(OscillateComponent(axis: [1,0,0], amplitude: 0.2, speed: 2))
            attachLabel(to: oscillateCube, text: "OscillateComponent")
            anchor.addChild(oscillateCube)

            // PathMove component example.
            let pathMoveCube = makeCube()
            pathMoveCube.position = nextPosition()
            pathMoveCube.components.set(PathMoveComponent(start: pathMoveCube.position, end: pathMoveCube.position + [0.3,0,0], speed: 0.3))
            attachLabel(to: pathMoveCube, text: "PathMoveComponent")
            anchor.addChild(pathMoveCube)

            // Pulse component example.
            let pulseCube = makeCube()
            pulseCube.position = nextPosition()
            pulseCube.components.set(PulseComponent(amplitude: 0.2, speed: 2))
            attachLabel(to: pulseCube, text: "PulseComponent")
            anchor.addChild(pulseCube)

            // Repel component example.
            let repelCube = makeCube()
            repelCube.position = nextPosition()
            repelCube.components.set(RepelComponent(target: [0,0,-1], strength: 0.5))
            attachLabel(to: repelCube, text: "RepelComponent")
            anchor.addChild(repelCube)

            // Scale component example.
            let scaleCube = makeCube()
            scaleCube.position = nextPosition()
            scaleCube.components.set(ScaleComponent(rate: 0.1))
            attachLabel(to: scaleCube, text: "ScaleComponent")
            anchor.addChild(scaleCube)

            // Shake component example.
            let shakeCube = makeCube()
            shakeCube.position = nextPosition()
            shakeCube.components.set(ShakeComponent(amplitude: 0.05, speed: 5))
            attachLabel(to: shakeCube, text: "ShakeComponent")
            anchor.addChild(shakeCube)

            // Shrink component example.
            let shrinkCube = makeCube()
            shrinkCube.position = nextPosition()
            shrinkCube.components.set(ShrinkComponent(rate: 0.1))
            attachLabel(to: shrinkCube, text: "ShrinkComponent")
            anchor.addChild(shrinkCube)

            // Slide component example.
            let slideCube = makeCube()
            slideCube.position = nextPosition()
            slideCube.components.set(SlideComponent(axis: [1,0,0], speed: 0.3, length: 0.5))
            attachLabel(to: slideCube, text: "SlideComponent")
            anchor.addChild(slideCube)

            // Spin component example.
            let spinCube = makeCube()
            spinCube.position = nextPosition()
            spinCube.components.set(SpinComponent(axis: [0,1,0], speed: .pi))
            attachLabel(to: spinCube, text: "SpinComponent")
            anchor.addChild(spinCube)

            // Strobe component example.
            let strobeCube = makeCube()
            strobeCube.position = nextPosition()
            strobeCube.components.set(StrobeComponent(interval: 0.5, colorA: .blue, colorB: .green))
            attachLabel(to: strobeCube, text: "StrobeComponent")
            anchor.addChild(strobeCube)

            // Tilt component example.
            let tiltCube = makeCube()
            tiltCube.position = nextPosition()
            tiltCube.components.set(TiltComponent(axis: [0,0,1], amplitude: .pi/8, speed: 2))
            attachLabel(to: tiltCube, text: "TiltComponent")
            anchor.addChild(tiltCube)

            // Vibrate component example.
            let vibrateCube = makeCube()
            vibrateCube.position = nextPosition()
            vibrateCube.components.set(VibrateComponent(amplitude: .pi/8, speed: 10))
            attachLabel(to: vibrateCube, text: "VibrateComponent")
            anchor.addChild(vibrateCube)

            // Wander component example.
            let wanderCube = makeCube()
            wanderCube.position = nextPosition()
            wanderCube.components.set(WanderComponent(range: 0.2))
            attachLabel(to: wanderCube, text: "WanderComponent")
            anchor.addChild(wanderCube)

            // Bounce component example.
            let bounceCube = makeCube()
            bounceCube.position = nextPosition()
            bounceCube.components.set(BounceComponent(amplitude: 0.1, speed: 2, origin: bounceCube.position))
            attachLabel(to: bounceCube, text: "BounceComponent")
            anchor.addChild(bounceCube)

            // Twist component example.
            let twistCube = makeCube()
            twistCube.position = nextPosition()
            twistCube.components.set(TwistComponent(axis: [0,1,0], speed: .pi))
            attachLabel(to: twistCube, text: "TwistComponent")
            anchor.addChild(twistCube)

            // Flip component example.
            let flipCube = makeCube()
            flipCube.position = nextPosition()
            flipCube.components.set(FlipComponent(axis: [1,0,0], speed: .pi))
            attachLabel(to: flipCube, text: "FlipComponent")
            anchor.addChild(flipCube)

            // Hover component example.
            let hoverCube = makeCube()
            hoverCube.position = nextPosition()
            hoverCube.components.set(HoverComponent(height: 0.1, amplitude: 0.05, speed: 2, origin: hoverCube.position))
            attachLabel(to: hoverCube, text: "HoverComponent")
            anchor.addChild(hoverCube)

            // Seek component example.
            let seekCube = makeCube()
            seekCube.position = nextPosition()
            seekCube.components.set(SeekComponent(target: .zero, speed: 0.2))
            attachLabel(to: seekCube, text: "SeekComponent")
            anchor.addChild(seekCube)

            // Stretch component example.
            let stretchCube = makeCube()
            stretchCube.position = nextPosition()
            stretchCube.components.set(StretchComponent(axis: [1,0,0], amplitude: 0.2, speed: 0.2))
            attachLabel(to: stretchCube, text: "StretchComponent")
            anchor.addChild(stretchCube)

            // RandomColor component example.
            let randomColorCube = makeCube()
            randomColorCube.position = nextPosition()
            randomColorCube.components.set(RandomColorComponent(interval: 1))
            attachLabel(to: randomColorCube, text: "RandomColorComponent")
            anchor.addChild(randomColorCube)

            // Teleport component example.
            let teleportCube = makeCube()
            teleportCube.position = nextPosition()
            teleportCube.components.set(TeleportComponent(interval: 2, range: 0.2))
            attachLabel(to: teleportCube, text: "TeleportComponent")
            anchor.addChild(teleportCube)

            // Transparency component example.
            let transparencyCube = makeCube()
            transparencyCube.position = nextPosition()
            transparencyCube.components.set(TransparencyComponent(rate: 0.2, alpha: 1))
            attachLabel(to: transparencyCube, text: "TransparencyComponent")
            anchor.addChild(transparencyCube)

            // Spiral component example.
            let spiralCube = makeCube()
            spiralCube.position = nextPosition()
            spiralCube.components.set(SpiralComponent(center: spiralCube.position, radius: 0.2, speed: 2, heightSpeed: 0.1))
            attachLabel(to: spiralCube, text: "SpiralComponent")
            anchor.addChild(spiralCube)

            // PulseColor component example.
            let pulseColorCube = makeCube()
            pulseColorCube.position = nextPosition()
            pulseColorCube.components.set(PulseColorComponent(colorA: [1,1,1], colorB: [1,0,0], speed: 2))
            attachLabel(to: pulseColorCube, text: "PulseColorComponent")
            anchor.addChild(pulseColorCube)

            // Flicker component example.
            let flickerCube = makeCube()
            flickerCube.position = nextPosition()
            flickerCube.components.set(FlickerComponent(probability: 0.1))
            attachLabel(to: flickerCube, text: "FlickerComponent")
            anchor.addChild(flickerCube)

            // Snap component example.
            let snapCube = makeCube()
            snapCube.position = nextPosition()
            snapCube.components.set(SnapComponent(gridSize: 0.1))
            attachLabel(to: snapCube, text: "SnapComponent")
            anchor.addChild(snapCube)

            // Beeline component example.
            let beelineCube = makeCube()
            beelineCube.position = nextPosition()
            beelineCube.components.set(BeelineComponent(direction: [0,0,-1], speed: 0.2))
            attachLabel(to: beelineCube, text: "BeelineComponent")
            anchor.addChild(beelineCube)

            // Boomerang component example.
            let boomerangCube = makeCube()
            boomerangCube.position = nextPosition()
            boomerangCube.components.set(BoomerangComponent(start: boomerangCube.position, end: boomerangCube.position + [0,0,0.3], speed: 0.2))
            attachLabel(to: boomerangCube, text: "BoomerangComponent")
            anchor.addChild(boomerangCube)

            // Twinkle component example.
            let twinkleCube = makeCube()
            twinkleCube.position = nextPosition()
            twinkleCube.components.set(TwinkleComponent(interval: 0.5))
            attachLabel(to: twinkleCube, text: "TwinkleComponent")
            anchor.addChild(twinkleCube)

            // RandomScale component example.
            let randomScaleCube = makeCube()
            randomScaleCube.position = nextPosition()
            randomScaleCube.components.set(RandomScaleComponent(range: 0.02))
            attachLabel(to: randomScaleCube, text: "RandomScaleComponent")
            anchor.addChild(randomScaleCube)

            // Wobble component example.
            let wobbleCube = makeCube()
            wobbleCube.position = nextPosition()
            wobbleCube.components.set(WobbleComponent(axis: [1,0,0], amplitude: .pi/8, speed: 3))
            attachLabel(to: wobbleCube, text: "WobbleComponent")
            anchor.addChild(wobbleCube)

            // Align component example.
            let alignCube = makeCube()
            alignCube.position = nextPosition()
            alignCube.components.set(AlignComponent())
            attachLabel(to: alignCube, text: "AlignComponent")
            anchor.addChild(alignCube)

            // ZigZag component example.
            let zigzagCube = makeCube()
            zigzagCube.position = nextPosition()
            zigzagCube.components.set(ZigZagComponent(axis: [1,0,0], speed: 0.2, length: 0.3))
            attachLabel(to: zigzagCube, text: "ZigZagComponent")
            anchor.addChild(zigzagCube)

            // MoveX component example.
            let moveXCube = makeCube()
            moveXCube.position = nextPosition()
            moveXCube.components.set(MoveXComponent(speed: 0.1))
            attachLabel(to: moveXCube, text: "MoveXComponent")
            anchor.addChild(moveXCube)

            // MoveY component example.
            let moveYCube = makeCube()
            moveYCube.position = nextPosition()
            moveYCube.components.set(MoveYComponent(speed: 0.1))
            attachLabel(to: moveYCube, text: "MoveYComponent")
            anchor.addChild(moveYCube)

            // MoveZ component example.
            let moveZCube = makeCube()
            moveZCube.position = nextPosition()
            moveZCube.components.set(MoveZComponent(speed: 0.1))
            attachLabel(to: moveZCube, text: "MoveZComponent")
            anchor.addChild(moveZCube)

            // PulseScale component example.
            let pulseScaleCube = makeCube()
            pulseScaleCube.position = nextPosition()
            pulseScaleCube.components.set(PulseScaleComponent(amplitude: 0.2, speed: 2))
            attachLabel(to: pulseScaleCube, text: "PulseScaleComponent")
            anchor.addChild(pulseScaleCube)

            // ColorCycle component example.
            let colorCycleCube = makeCube()
            colorCycleCube.position = nextPosition()
            colorCycleCube.components.set(ColorCycleComponent(speed: 0.5))
            attachLabel(to: colorCycleCube, text: "ColorCycleComponent")
            anchor.addChild(colorCycleCube)

            // PingPongX component example.
            let pingPongXCube = makeCube()
            pingPongXCube.position = nextPosition()
            pingPongXCube.components.set(PingPongXComponent(amplitude: 0.1, speed: 2, origin: pingPongXCube.position.x))
            attachLabel(to: pingPongXCube, text: "PingPongXComponent")
            anchor.addChild(pingPongXCube)

            // PingPongY component example.
            let pingPongYCube = makeCube()
            pingPongYCube.position = nextPosition()
            pingPongYCube.components.set(PingPongYComponent(amplitude: 0.1, speed: 2, origin: pingPongYCube.position.y))
            attachLabel(to: pingPongYCube, text: "PingPongYComponent")
            anchor.addChild(pingPongYCube)

            // PingPongZ component example.
            let pingPongZCube = makeCube()
            pingPongZCube.position = nextPosition()
            pingPongZCube.components.set(PingPongZComponent(amplitude: 0.1, speed: 2, origin: pingPongZCube.position.z))
            attachLabel(to: pingPongZCube, text: "PingPongZComponent")
            anchor.addChild(pingPongZCube)

            // RollX component example.
            let rollXCube = makeCube()
            rollXCube.position = nextPosition()
            rollXCube.components.set(RollXComponent(speed: .pi))
            attachLabel(to: rollXCube, text: "RollXComponent")
            anchor.addChild(rollXCube)

            // RollZ component example.
            let rollZCube = makeCube()
            rollZCube.position = nextPosition()
            rollZCube.components.set(RollZComponent(speed: .pi))
            attachLabel(to: rollZCube, text: "RollZComponent")
            anchor.addChild(rollZCube)

            // FlashScale component example.
            let flashScaleCube = makeCube()
            flashScaleCube.position = nextPosition()
            flashScaleCube.components.set(FlashScaleComponent(interval: 1))
            attachLabel(to: flashScaleCube, text: "FlashScaleComponent")
            anchor.addChild(flashScaleCube)

            // DiagonalDrift component example.
            let diagonalDriftCube = makeCube()
            diagonalDriftCube.position = nextPosition()
            diagonalDriftCube.components.set(DiagonalDriftComponent(velocity: [0.05, 0, 0.05]))
            attachLabel(to: diagonalDriftCube, text: "DiagonalDriftComponent")
            anchor.addChild(diagonalDriftCube)

            // Rock component example.
            let rockCube = makeCube()
            rockCube.position = nextPosition()
            rockCube.components.set(RockComponent(amplitude: .pi/8, speed: 3))
            attachLabel(to: rockCube, text: "RockComponent")
            anchor.addChild(rockCube)

            // Shimmer component example.
            let shimmerCube = makeCube()
            shimmerCube.position = nextPosition()
            shimmerCube.components.set(ShimmerComponent(speed: 3))
            attachLabel(to: shimmerCube, text: "ShimmerComponent")
            anchor.addChild(shimmerCube)

            // SpiralMove component example.
            let spiralMoveCube = makeCube()
            spiralMoveCube.position = nextPosition()
            spiralMoveCube.components.set(SpiralMoveComponent(center: spiralMoveCube.position, radius: 0.2, speed: 2, angle: 0, heightSpeed: 0.05))
            attachLabel(to: spiralMoveCube, text: "SpiralMoveComponent")
            anchor.addChild(spiralMoveCube)

            // TeleportRandom component example.
            let teleportRandomCube = makeCube()
            teleportRandomCube.position = nextPosition()
            teleportRandomCube.components.set(TeleportRandomComponent(interval: 2, range: 0.2))
            attachLabel(to: teleportRandomCube, text: "TeleportRandomComponent")
            anchor.addChild(teleportRandomCube)

            // BlinkColor component example.
            let blinkColorCube = makeCube()
            blinkColorCube.position = nextPosition()
            blinkColorCube.components.set(BlinkColorComponent(interval: 1, colorA: [1,0,0], colorB: [0,1,0]))
            attachLabel(to: blinkColorCube, text: "BlinkColorComponent")
            anchor.addChild(blinkColorCube)

            // BounceTilt component example.
            let bounceTiltCube = makeCube()
            bounceTiltCube.position = nextPosition()
            bounceTiltCube.components.set(BounceTiltComponent(amplitude: 0.1, speed: 3, origin: bounceTiltCube.position))
            attachLabel(to: bounceTiltCube, text: "BounceTiltComponent")
            anchor.addChild(bounceTiltCube)

            // SeekRotate component example.
            let seekRotateCube = makeCube()
            seekRotateCube.position = nextPosition()
            seekRotateCube.components.set(SeekRotateComponent(target: .zero, moveSpeed: 0.1, rotateSpeed: .pi))
            attachLabel(to: seekRotateCube, text: "SeekRotateComponent")
            anchor.addChild(seekRotateCube)

            // OrbitScale component example.
            let orbitScaleCube = makeCube()
            orbitScaleCube.position = nextPosition()
            orbitScaleCube.components.set(OrbitScaleComponent(center: orbitScaleCube.position, radius: 0.2, speed: 2, angle: 0, amplitude: 0.2, phase: 0))
            attachLabel(to: orbitScaleCube, text: "OrbitScaleComponent")
            anchor.addChild(orbitScaleCube)

            content.add(anchor)
            
        }
    }
}

//#Preview(immersionStyle: .full) {
//    ImmersiveView()
//        .environment(AppModel())
//}
