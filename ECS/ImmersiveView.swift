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
    @State private var toggles: [ObjectIdentifier: () -> Void] = [:]

    /// Helper to add or remove a component on an entity.
    func toggle<T: Component>(_ entity: Entity, component: @autoclosure () -> T) {
        if entity.components.has(T.self) {
            entity.components.remove(T.self)
        } else {
            entity.components.set(component())
        }
    }

    /// Registers a toggle closure for the given entity.
    mutating func registerToggle<T: Component>(_ entity: Entity, component: @autoclosure @escaping () -> T) {
        toggles[ObjectIdentifier(entity)] = { [weak entity] in
            guard let entity else { return }
            toggle(entity, component: component())
        }
    }

    var body: some View {
        RealityView { content in
            // Add the initial RealityKit content
//            if let immersiveContentEntity = try? await Entity(named: "SkyDome", in: realityKitContentBundle) {
//                content.add(immersiveContentEntity)
//            }
            
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
                let cube = ModelEntity(
                    mesh: .generateBox(size: 0.25),
                    materials: [SimpleMaterial(color: .cyan, isMetallic: false)]
                )
                cube.components.set(CollisionComponent(shapes: [.generateBox(size: 0.25)]))
                cube.components.set(InputTargetComponent())
                return cube
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
            registerToggle(rotateCube, component: RotateComponent(axis: [0, 1, 0], speed: .pi))
            attachLabel(to: rotateCube, text: "RotateComponent")
            anchor.addChild(rotateCube)

            // Blink component example.
            let blinkCube = makeCube()
            blinkCube.position = nextPosition()
            registerToggle(blinkCube, component: BlinkComponent(interval: 0.5))
            attachLabel(to: blinkCube, text: "BlinkComponent")
            anchor.addChild(blinkCube)

            // Bob component example.
            let bobCube = makeCube()
            bobCube.position = nextPosition()
            registerToggle(bobCube, component: BobComponent(amplitude: 0.1, speed: 2))
            attachLabel(to: bobCube, text: "BobComponent")
            anchor.addChild(bobCube)

            // Color component example.
            let colorCube = makeCube()
            colorCube.position = nextPosition()
            registerToggle(colorCube, component: ColorComponent(color: .red))
            attachLabel(to: colorCube, text: "ColorComponent")
            anchor.addChild(colorCube)

            // Drift component example.
            let driftCube = makeCube()
            driftCube.position = nextPosition()
            registerToggle(driftCube, component: DriftComponent(velocity: [0.1, 0, 0]))
            attachLabel(to: driftCube, text: "DriftComponent")
            anchor.addChild(driftCube)

            // Elastic component example.
            let elasticCube = makeCube()
            elasticCube.position = nextPosition()
            registerToggle(elasticCube, component: ElasticComponent(amplitude: 0.2, speed: 3))
            attachLabel(to: elasticCube, text: "ElasticComponent")
            anchor.addChild(elasticCube)

            // Expire component example.
            let expireCube = makeCube()
            expireCube.position = nextPosition()
            registerToggle(expireCube, component: ExpireComponent(timeRemaining: 10))
            attachLabel(to: expireCube, text: "ExpireComponent")
            anchor.addChild(expireCube)

            // Fade component example.
            let fadeCube = makeCube()
            fadeCube.position = nextPosition()
            registerToggle(fadeCube, component: FadeComponent(rate: 0.1, alpha: 1))
            attachLabel(to: fadeCube, text: "FadeComponent")
            anchor.addChild(fadeCube)

            // FlashColor component example.
            let flashCube = makeCube()
            flashCube.position = nextPosition()
            registerToggle(flashCube, component: FlashColorComponent(interval: 1))
            attachLabel(to: flashCube, text: "FlashColorComponent")
            anchor.addChild(flashCube)

            // Glow component example.
            let glowCube = makeCube()
            glowCube.position = nextPosition()
            registerToggle(glowCube, component: GlowComponent(intensity: 0.5))
            attachLabel(to: glowCube, text: "GlowComponent")
            anchor.addChild(glowCube)

            // Gravity component example.
            let gravityCube = makeCube()
            gravityCube.position = nextPosition()
            registerToggle(gravityCube, component: GravityComponent())
            attachLabel(to: gravityCube, text: "GravityComponent")
            anchor.addChild(gravityCube)

            // Grow component example.
            let growCube = makeCube()
            growCube.position = nextPosition()
            registerToggle(growCube, component: GrowComponent(rate: 0.001))
            attachLabel(to: growCube, text: "GrowComponent")
            anchor.addChild(growCube)

            // Jitter component example.
            let jitterCube = makeCube()
            jitterCube.position = nextPosition()
            registerToggle(jitterCube, component: JitterComponent(amplitude: 0.02))
            attachLabel(to: jitterCube, text: "JitterComponent")
            anchor.addChild(jitterCube)

            // Lifetime component example.
            let lifetimeCube = makeCube()
            lifetimeCube.position = nextPosition()
            registerToggle(lifetimeCube, component: LifetimeComponent(timeRemaining: 12))
            attachLabel(to: lifetimeCube, text: "LifetimeComponent")
            anchor.addChild(lifetimeCube)

            // Magnet component example.
            let magnetCube = makeCube()
            magnetCube.position = nextPosition()
            registerToggle(magnetCube, component: MagnetComponent(target: .zero, strength: 0.5))
            attachLabel(to: magnetCube, text: "MagnetComponent")
            anchor.addChild(magnetCube)

            // Move component example.
            let moveCube = makeCube()
            moveCube.position = nextPosition()
            registerToggle(moveCube, component: MoveComponent(velocity: [0.1, 0, 0]))
            attachLabel(to: moveCube, text: "MoveComponent")
            anchor.addChild(moveCube)

            // My component example.
            let myCube = makeCube()
            myCube.position = nextPosition()
            registerToggle(myCube, component: MyComponent())
            attachLabel(to: myCube, text: "MyComponent")
            anchor.addChild(myCube)

            // Orbit component example.
            let orbitCube = makeCube()
            orbitCube.position = nextPosition()
            registerToggle(orbitCube, component: OrbitComponent(center: orbitCube.position, axis: [0,1,0], speed: 1))
            attachLabel(to: orbitCube, text: "OrbitComponent")
            anchor.addChild(orbitCube)

            // Oscillate component example.
            let oscillateCube = makeCube()
            oscillateCube.position = nextPosition()
            registerToggle(oscillateCube, component: OscillateComponent(axis: [1,0,0], amplitude: 0.2, speed: 2))
            attachLabel(to: oscillateCube, text: "OscillateComponent")
            anchor.addChild(oscillateCube)

            // PathMove component example.
            let pathMoveCube = makeCube()
            pathMoveCube.position = nextPosition()
            registerToggle(pathMoveCube, component: PathMoveComponent(start: pathMoveCube.position, end: pathMoveCube.position + [0.3,0,0], speed: 0.3))
            attachLabel(to: pathMoveCube, text: "PathMoveComponent")
            anchor.addChild(pathMoveCube)

            // Pulse component example.
            let pulseCube = makeCube()
            pulseCube.position = nextPosition()
            registerToggle(pulseCube, component: PulseComponent(amplitude: 0.2, speed: 2))
            attachLabel(to: pulseCube, text: "PulseComponent")
            anchor.addChild(pulseCube)

            // Repel component example.
            let repelCube = makeCube()
            repelCube.position = nextPosition()
            registerToggle(repelCube, component: RepelComponent(target: [0,0,-1], strength: 0.5))
            attachLabel(to: repelCube, text: "RepelComponent")
            anchor.addChild(repelCube)

            // Scale component example.
            let scaleCube = makeCube()
            scaleCube.position = nextPosition()
            registerToggle(scaleCube, component: ScaleComponent(rate: 0.01))
            attachLabel(to: scaleCube, text: "ScaleComponent")
            anchor.addChild(scaleCube)

            // Shake component example.
            let shakeCube = makeCube()
            shakeCube.position = nextPosition()
            registerToggle(shakeCube, component: ShakeComponent(amplitude: 0.05, speed: 5))
            attachLabel(to: shakeCube, text: "ShakeComponent")
            anchor.addChild(shakeCube)

            // Shrink component example.
            let shrinkCube = makeCube()
            shrinkCube.position = nextPosition()
            registerToggle(shrinkCube, component: ShrinkComponent(rate: 0.1))
            attachLabel(to: shrinkCube, text: "ShrinkComponent")
            anchor.addChild(shrinkCube)

            // Slide component example.
            let slideCube = makeCube()
            slideCube.position = nextPosition()
            registerToggle(slideCube, component: SlideComponent(axis: [1,0,0], speed: 0.3, length: 0.5))
            attachLabel(to: slideCube, text: "SlideComponent")
            anchor.addChild(slideCube)

            // Spin component example.
            let spinCube = makeCube()
            spinCube.position = nextPosition()
            registerToggle(spinCube, component: SpinComponent(axis: [0,1,0], speed: .pi))
            attachLabel(to: spinCube, text: "SpinComponent")
            anchor.addChild(spinCube)

            // Strobe component example.
            let strobeCube = makeCube()
            strobeCube.position = nextPosition()
            registerToggle(strobeCube, component: StrobeComponent(interval: 0.5, colorA: .blue, colorB: .green))
            attachLabel(to: strobeCube, text: "StrobeComponent")
            anchor.addChild(strobeCube)

            // Tilt component example.
            let tiltCube = makeCube()
            tiltCube.position = nextPosition()
            registerToggle(tiltCube, component: TiltComponent(axis: [0,0,1], amplitude: .pi/8, speed: 2))
            attachLabel(to: tiltCube, text: "TiltComponent")
            anchor.addChild(tiltCube)

            // Vibrate component example.
            let vibrateCube = makeCube()
            vibrateCube.position = nextPosition()
            registerToggle(vibrateCube, component: VibrateComponent(amplitude: .pi/8, speed: 10))
            attachLabel(to: vibrateCube, text: "VibrateComponent")
            anchor.addChild(vibrateCube)

            // Wander component example.
            let wanderCube = makeCube()
            wanderCube.position = nextPosition()
            registerToggle(wanderCube, component: WanderComponent(range: 0.2))
            attachLabel(to: wanderCube, text: "WanderComponent")
            anchor.addChild(wanderCube)

            // Bounce component example.
            let bounceCube = makeCube()
            bounceCube.position = nextPosition()
            registerToggle(bounceCube, component: BounceComponent(amplitude: 0.1, speed: 2, origin: bounceCube.position))
            attachLabel(to: bounceCube, text: "BounceComponent")
            anchor.addChild(bounceCube)

            // Twist component example.
            let twistCube = makeCube()
            twistCube.position = nextPosition()
            registerToggle(twistCube, component: TwistComponent(axis: [0,1,0], speed: .pi))
            attachLabel(to: twistCube, text: "TwistComponent")
            anchor.addChild(twistCube)

            // Flip component example.
            let flipCube = makeCube()
            flipCube.position = nextPosition()
            registerToggle(flipCube, component: FlipComponent(axis: [1,0,0], speed: .pi))
            attachLabel(to: flipCube, text: "FlipComponent")
            anchor.addChild(flipCube)

            // Hover component example.
            let hoverCube = makeCube()
            hoverCube.position = nextPosition()
            registerToggle(hoverCube, component: HoverComponent(height: 0.1, amplitude: 0.05, speed: 2, origin: hoverCube.position))
            attachLabel(to: hoverCube, text: "HoverComponent")
            anchor.addChild(hoverCube)

            // Seek component example.
            let seekCube = makeCube()
            seekCube.position = nextPosition()
            registerToggle(seekCube, component: SeekComponent(target: .zero, speed: 0.2))
            attachLabel(to: seekCube, text: "SeekComponent")
            anchor.addChild(seekCube)

            // Stretch component example.
            let stretchCube = makeCube()
            stretchCube.position = nextPosition()
            registerToggle(stretchCube, component: StretchComponent(axis: [1,0,0], amplitude: 0.2, speed: 0.2))
            attachLabel(to: stretchCube, text: "StretchComponent")
            anchor.addChild(stretchCube)

            // RandomColor component example.
            let randomColorCube = makeCube()
            randomColorCube.position = nextPosition()
            registerToggle(randomColorCube, component: RandomColorComponent(interval: 1))
            attachLabel(to: randomColorCube, text: "RandomColorComponent")
            anchor.addChild(randomColorCube)

            // Teleport component example.
            let teleportCube = makeCube()
            teleportCube.position = nextPosition()
            registerToggle(teleportCube, component: TeleportComponent(interval: 2, range: 0.2))
            attachLabel(to: teleportCube, text: "TeleportComponent")
            anchor.addChild(teleportCube)

            // Transparency component example.
            let transparencyCube = makeCube()
            transparencyCube.position = nextPosition()
            registerToggle(transparencyCube, component: TransparencyComponent(rate: 0.2, alpha: 1))
            attachLabel(to: transparencyCube, text: "TransparencyComponent")
            anchor.addChild(transparencyCube)

            // Spiral component example.
            let spiralCube = makeCube()
            spiralCube.position = nextPosition()
            registerToggle(spiralCube, component: SpiralComponent(center: spiralCube.position, radius: 0.2, speed: 0.2, heightSpeed: 0.01))
            attachLabel(to: spiralCube, text: "SpiralComponent")
            anchor.addChild(spiralCube)

            // PulseColor component example.
            let pulseColorCube = makeCube()
            pulseColorCube.position = nextPosition()
            registerToggle(pulseColorCube, component: PulseColorComponent(colorA: [1,1,1], colorB: [1,0,0], speed: 2))
            attachLabel(to: pulseColorCube, text: "PulseColorComponent")
            anchor.addChild(pulseColorCube)

            // Flicker component example.
            let flickerCube = makeCube()
            flickerCube.position = nextPosition()
            registerToggle(flickerCube, component: FlickerComponent(probability: 0.1))
            attachLabel(to: flickerCube, text: "FlickerComponent")
            anchor.addChild(flickerCube)

            // Snap component example.
            let snapCube = makeCube()
            snapCube.position = nextPosition()
            registerToggle(snapCube, component: SnapComponent(gridSize: 0.1))
            attachLabel(to: snapCube, text: "SnapComponent")
            anchor.addChild(snapCube)

            // Beeline component example.
            let beelineCube = makeCube()
            beelineCube.position = nextPosition()
            registerToggle(beelineCube, component: BeelineComponent(direction: [0,0,-1], speed: 0.2))
            attachLabel(to: beelineCube, text: "BeelineComponent")
            anchor.addChild(beelineCube)

            // Boomerang component example.
            let boomerangCube = makeCube()
            boomerangCube.position = nextPosition()
            registerToggle(boomerangCube, component: BoomerangComponent(start: boomerangCube.position, end: boomerangCube.position + [0,0,0.3], speed: 0.2))
            attachLabel(to: boomerangCube, text: "BoomerangComponent")
            anchor.addChild(boomerangCube)

            // Twinkle component example.
            let twinkleCube = makeCube()
            twinkleCube.position = nextPosition()
            registerToggle(twinkleCube, component: TwinkleComponent(interval: 0.5))
            attachLabel(to: twinkleCube, text: "TwinkleComponent")
            anchor.addChild(twinkleCube)

            // RandomScale component example.
            let randomScaleCube = makeCube()
            randomScaleCube.position = nextPosition()
            registerToggle(randomScaleCube, component: RandomScaleComponent(range: 0.02))
            attachLabel(to: randomScaleCube, text: "RandomScaleComponent")
            anchor.addChild(randomScaleCube)

            // Wobble component example.
            let wobbleCube = makeCube()
            wobbleCube.position = nextPosition()
            registerToggle(wobbleCube, component: WobbleComponent(axis: [1,0,0], amplitude: .pi/8, speed: 3))
            attachLabel(to: wobbleCube, text: "WobbleComponent")
            anchor.addChild(wobbleCube)

            // Align component example.
            let alignCube = makeCube()
            alignCube.position = nextPosition()
            registerToggle(alignCube, component: AlignComponent())
            attachLabel(to: alignCube, text: "AlignComponent")
            anchor.addChild(alignCube)

            // ZigZag component example.
            let zigzagCube = makeCube()
            zigzagCube.position = nextPosition()
            registerToggle(zigzagCube, component: ZigZagComponent(axis: [1,0,0], speed: 0.2, length: 0.3))
            attachLabel(to: zigzagCube, text: "ZigZagComponent")
            anchor.addChild(zigzagCube)

            // MoveX component example.
            let moveXCube = makeCube()
            moveXCube.position = nextPosition()
            moveXCube.model?.materials = [UnlitMaterial(color: .cyan.withAlphaComponent(0.3))]
            registerToggle(moveXCube, component: MoveXComponent(speed: 0.01))
            attachLabel(to: moveXCube, text: "MoveXComponent")
            anchor.addChild(moveXCube)

            // MoveY component example.
            let moveYCube = makeCube()
            moveYCube.position = nextPosition()
            moveYCube.model?.materials = [UnlitMaterial(color: .cyan.withAlphaComponent(0.3))]
            registerToggle(moveYCube, component: MoveYComponent(speed: 0.01))
            attachLabel(to: moveYCube, text: "MoveYComponent")
            anchor.addChild(moveYCube)

            // MoveZ component example.
            let moveZCube = makeCube()
            moveZCube.position = nextPosition()
            moveZCube.model?.materials = [UnlitMaterial(color: .cyan.withAlphaComponent(0.3))]
            registerToggle(moveZCube, component: MoveZComponent(speed: 0.01))
            attachLabel(to: moveZCube, text: "MoveZComponent")
            anchor.addChild(moveZCube)

            // PulseScale component example.
            let pulseScaleCube = makeCube()
            pulseScaleCube.position = nextPosition()
            registerToggle(pulseScaleCube, component: PulseScaleComponent(amplitude: 0.02, speed: 2))
            attachLabel(to: pulseScaleCube, text: "PulseScaleComponent")
            anchor.addChild(pulseScaleCube)

            // ColorCycle component example.
            let colorCycleCube = makeCube()
            colorCycleCube.position = nextPosition()
            registerToggle(colorCycleCube, component: ColorCycleComponent(speed: 0.5))
            attachLabel(to: colorCycleCube, text: "ColorCycleComponent")
            anchor.addChild(colorCycleCube)

            // PingPongX component example.
            let pingPongXCube = makeCube()
            pingPongXCube.position = nextPosition()
            registerToggle(pingPongXCube, component: PingPongXComponent(amplitude: 0.1, speed: 2, origin: pingPongXCube.position.x))
            attachLabel(to: pingPongXCube, text: "PingPongXComponent")
            anchor.addChild(pingPongXCube)

            // PingPongY component example.
            let pingPongYCube = makeCube()
            pingPongYCube.position = nextPosition()
            registerToggle(pingPongYCube, component: PingPongYComponent(amplitude: 0.1, speed: 2, origin: pingPongYCube.position.y))
            attachLabel(to: pingPongYCube, text: "PingPongYComponent")
            anchor.addChild(pingPongYCube)

            // PingPongZ component example.
            let pingPongZCube = makeCube()
            pingPongZCube.position = nextPosition()
            registerToggle(pingPongZCube, component: PingPongZComponent(amplitude: 0.1, speed: 2, origin: pingPongZCube.position.z))
            attachLabel(to: pingPongZCube, text: "PingPongZComponent")
            anchor.addChild(pingPongZCube)

            // RollX component example.
            let rollXCube = makeCube()
            rollXCube.position = nextPosition()
            registerToggle(rollXCube, component: RollXComponent(speed: .pi))
            attachLabel(to: rollXCube, text: "RollXComponent")
            anchor.addChild(rollXCube)

            // RollZ component example.
            let rollZCube = makeCube()
            rollZCube.position = nextPosition()
            registerToggle(rollZCube, component: RollZComponent(speed: .pi))
            attachLabel(to: rollZCube, text: "RollZComponent")
            anchor.addChild(rollZCube)

            // FlashScale component example.
            let flashScaleCube = makeCube()
            flashScaleCube.position = nextPosition()
            registerToggle(flashScaleCube, component: FlashScaleComponent(interval: 1))
            attachLabel(to: flashScaleCube, text: "FlashScaleComponent")
            anchor.addChild(flashScaleCube)

            // DiagonalDrift component example.
            let diagonalDriftCube = makeCube()
            diagonalDriftCube.position = nextPosition()
            registerToggle(diagonalDriftCube, component: DiagonalDriftComponent(velocity: [0.05, 0, 0.05]))
            attachLabel(to: diagonalDriftCube, text: "DiagonalDriftComponent")
            anchor.addChild(diagonalDriftCube)

            // Rock component example.
            let rockCube = makeCube()
            rockCube.position = nextPosition()
            registerToggle(rockCube, component: RockComponent(amplitude: .pi/8, speed: 3))
            attachLabel(to: rockCube, text: "RockComponent")
            anchor.addChild(rockCube)

            // Shimmer component example.
            let shimmerCube = makeCube()
            shimmerCube.position = nextPosition()
            registerToggle(shimmerCube, component: ShimmerComponent(speed: 3))
            attachLabel(to: shimmerCube, text: "ShimmerComponent")
            anchor.addChild(shimmerCube)

            // SpiralMove component example.
            let spiralMoveCube = makeCube()
            spiralMoveCube.position = nextPosition()
            registerToggle(spiralMoveCube, component: SpiralMoveComponent(center: spiralMoveCube.position, radius: 0.2, speed: 0.2, angle: 0, heightSpeed: 0.05))
            attachLabel(to: spiralMoveCube, text: "SpiralMoveComponent")
            anchor.addChild(spiralMoveCube)

            // TeleportRandom component example.
            let teleportRandomCube = makeCube()
            teleportRandomCube.position = nextPosition()
            registerToggle(teleportRandomCube, component: TeleportRandomComponent(interval: 2, range: 0.2))
            attachLabel(to: teleportRandomCube, text: "TeleportRandomComponent")
            anchor.addChild(teleportRandomCube)

            // BlinkColor component example.
            let blinkColorCube = makeCube()
            blinkColorCube.position = nextPosition()
            registerToggle(blinkColorCube, component: BlinkColorComponent(interval: 1, colorA: [1,0,0], colorB: [0,1,0]))
            attachLabel(to: blinkColorCube, text: "BlinkColorComponent")
            anchor.addChild(blinkColorCube)

            // BounceTilt component example.
            let bounceTiltCube = makeCube()
            bounceTiltCube.position = nextPosition()
            registerToggle(bounceTiltCube, component: BounceTiltComponent(amplitude: 0.1, speed: 3, origin: bounceTiltCube.position))
            attachLabel(to: bounceTiltCube, text: "BounceTiltComponent")
            anchor.addChild(bounceTiltCube)

            // SeekRotate component example.
            let seekRotateCube = makeCube()
            seekRotateCube.position = nextPosition()
            registerToggle(seekRotateCube, component: SeekRotateComponent(target: .zero, moveSpeed: 0.1, rotateSpeed: .pi))
            attachLabel(to: seekRotateCube, text: "SeekRotateComponent")
            anchor.addChild(seekRotateCube)

            // OrbitScale component example.
            let orbitScaleCube = makeCube()
            orbitScaleCube.position = nextPosition()
            registerToggle(orbitScaleCube, component: OrbitScaleComponent(center: orbitScaleCube.position, radius: 0.2, speed: 0.2, angle: 0, amplitude: 0.2, phase: 0))
            attachLabel(to: orbitScaleCube, text: "OrbitScaleComponent")
            anchor.addChild(orbitScaleCube)

            // Sway component example.
            let swayCube = makeCube()
            swayCube.position = nextPosition()
            registerToggle(swayCube, component: SwayComponent(amplitudeX: 0.1, amplitudeZ: 0.1, speed: 2, phase: 0, origin: swayCube.position))
            attachLabel(to: swayCube, text: "SwayComponent")
            anchor.addChild(swayCube)

            // DriftRotate component example.
            let driftRotateCube = makeCube()
            driftRotateCube.position = nextPosition()
            registerToggle(driftRotateCube, component: DriftRotateComponent(velocity: [0.05, 0, 0], rotationSpeed: .pi))
            attachLabel(to: driftRotateCube, text: "DriftRotateComponent")
            anchor.addChild(driftRotateCube)

            // BounceScale component example.
            let bounceScaleCube = makeCube()
            bounceScaleCube.position = nextPosition()
            registerToggle(bounceScaleCube, component: BounceScaleComponent(amplitude: 0.2, speed: 2, phase: 0))
            attachLabel(to: bounceScaleCube, text: "BounceScaleComponent")
            anchor.addChild(bounceScaleCube)

            // FadeColor component example.
            let fadeColorCube = makeCube()
            fadeColorCube.position = nextPosition()
            registerToggle(fadeColorCube, component: FadeColorComponent(colorA: [1,1,1], colorB: [0,0,1], speed: 2, phase: 0))
            attachLabel(to: fadeColorCube, text: "FadeColorComponent")
            anchor.addChild(fadeColorCube)

            // PulseOpacity component example.
            let pulseOpacityCube = makeCube()
            pulseOpacityCube.position = nextPosition()
            registerToggle(pulseOpacityCube, component: PulseOpacityComponent(baseAlpha: 1, amplitude: 0.5, speed: 2, phase: 0))
            attachLabel(to: pulseOpacityCube, text: "PulseOpacityComponent")
            anchor.addChild(pulseOpacityCube)

            // StepMove component example.
            let stepMoveCube = makeCube()
            stepMoveCube.position = nextPosition()
            registerToggle(stepMoveCube, component: StepMoveComponent(axis: [0,0,1], step: 0.05, interval: 0.5, timer: 0))
            attachLabel(to: stepMoveCube, text: "StepMoveComponent")
            anchor.addChild(stepMoveCube)

            // ShakeRotation component example.
            let shakeRotationCube = makeCube()
            shakeRotationCube.position = nextPosition()
            registerToggle(shakeRotationCube, component: ShakeRotationComponent(amplitude: .pi/8, speed: 5, phase: 0))
            attachLabel(to: shakeRotationCube, text: "ShakeRotationComponent")
            anchor.addChild(shakeRotationCube)

            // GrowFade component example.
            let growFadeCube = makeCube()
            growFadeCube.position = nextPosition()
            registerToggle(growFadeCube, component: GrowFadeComponent(growRate: 0.01, fadeRate: 0.1, alpha: 1))
            attachLabel(to: growFadeCube, text: "GrowFadeComponent")
            anchor.addChild(growFadeCube)

            // PulseColorScale component example.
            let pulseColorScaleCube = makeCube()
            pulseColorScaleCube.position = nextPosition()
            registerToggle(pulseColorScaleCube, component: PulseColorScaleComponent(amplitude: 0.1, colorA: [1,0,0], colorB: [0,1,0], speed: 2, phase: 0))
            attachLabel(to: pulseColorScaleCube, text: "PulseColorScaleComponent")
            anchor.addChild(pulseColorScaleCube)

            // DriftColor component example.
            let driftColorCube = makeCube()
            driftColorCube.position = nextPosition()
            registerToggle(driftColorCube, component: DriftColorComponent(velocity: [0.05,0,0], speed: 2, phase: 0))
            attachLabel(to: driftColorCube, text: "DriftColorComponent")
            anchor.addChild(driftColorCube)

            // OrbitTilt component example.
            let orbitTiltCube = makeCube()
            orbitTiltCube.position = nextPosition()
            registerToggle(orbitTiltCube, component: OrbitTiltComponent(center: orbitTiltCube.position, radius: 0.2, speed: 2, angle: 0, tiltAmplitude: .pi/8))
            attachLabel(to: orbitTiltCube, text: "OrbitTiltComponent")
            anchor.addChild(orbitTiltCube)

            // PulseRotation component example.
            let pulseRotationCube = makeCube()
            pulseRotationCube.position = nextPosition()
            registerToggle(pulseRotationCube, component: PulseRotationComponent(axis: [0,1,0], amplitude: .pi/4, speed: 2, phase: 0))
            attachLabel(to: pulseRotationCube, text: "PulseRotationComponent")
            anchor.addChild(pulseRotationCube)

            // OrbitColor component example.
            let orbitColorCube = makeCube()
            orbitColorCube.position = nextPosition()
            registerToggle(orbitColorCube, component: OrbitColorComponent(center: orbitColorCube.position, radius: 0.2, speed: 2, angle: 0, colorSpeed: 1, phase: 0))
            attachLabel(to: orbitColorCube, text: "OrbitColorComponent")
            anchor.addChild(orbitColorCube)

            // SlideTilt component example.
            let slideTiltCube = makeCube()
            slideTiltCube.position = nextPosition()
            registerToggle(slideTiltCube, component: SlideTiltComponent(axis: [1,0,0], speed: 0.2, length: 0.3, position: 0, tiltAmplitude: .pi/8, forward: true))
            attachLabel(to: slideTiltCube, text: "SlideTiltComponent")
            anchor.addChild(slideTiltCube)

            // SpinScale component example.
            let spinScaleCube = makeCube()
            spinScaleCube.position = nextPosition()
            registerToggle(spinScaleCube, component: SpinScaleComponent(axis: [0,1,0], spinSpeed: .pi, scaleRate: 0.01))
            attachLabel(to: spinScaleCube, text: "SpinScaleComponent")
            anchor.addChild(spinScaleCube)

            // BobRotate component example.
            let bobRotateCube = makeCube()
            bobRotateCube.position = nextPosition()
            registerToggle(bobRotateCube, component: BobRotateComponent(amplitude: 0.1, speed: 2, rotateSpeed: .pi, phase: 0, origin: bobRotateCube.position.y))
            attachLabel(to: bobRotateCube, text: "BobRotateComponent")
            anchor.addChild(bobRotateCube)

            // TiltRandom component example.
            let tiltRandomCube = makeCube()
            tiltRandomCube.position = nextPosition()
            registerToggle(tiltRandomCube, component: TiltRandomComponent(amplitude: .pi/8, interval: 1, timer: 0))
            attachLabel(to: tiltRandomCube, text: "TiltRandomComponent")
            anchor.addChild(tiltRandomCube)

            // ColorRise component example.
            let colorRiseCube = makeCube()
            colorRiseCube.position = nextPosition()
            registerToggle(colorRiseCube, component: ColorRiseComponent(speed: 0.05, colorA: [0,0,1], colorB: [1,0,0], height: 0.5))
            attachLabel(to: colorRiseCube, text: "ColorRiseComponent")
            anchor.addChild(colorRiseCube)

            // Jump component example.
            let jumpCube = makeCube()
            jumpCube.position = nextPosition()
            registerToggle(jumpCube, component: JumpComponent(height: 0.2, speed: 4, phase: 0, origin: jumpCube.position.y))
            attachLabel(to: jumpCube, text: "JumpComponent")
            anchor.addChild(jumpCube)

            // Nudge component example.
            let nudgeCube = makeCube()
            nudgeCube.position = nextPosition()
            registerToggle(nudgeCube, component: NudgeComponent(amplitude: 0.05))
            attachLabel(to: nudgeCube, text: "NudgeComponent")
            anchor.addChild(nudgeCube)

            // RollY component example.
            let rollYCube = makeCube()
            rollYCube.position = nextPosition()
            registerToggle(rollYCube, component: RollYComponent(speed: .pi))
            attachLabel(to: rollYCube, text: "RollYComponent")
            anchor.addChild(rollYCube)

            // Glide component example.
            let glideCube = makeCube()
            glideCube.position = nextPosition()
            registerToggle(glideCube, component: GlideComponent(velocity: [0.05, 0, 0]))
            attachLabel(to: glideCube, text: "GlideComponent")
            anchor.addChild(glideCube)

            // ToggleVisibility component example.
            let toggleCube = makeCube()
            toggleCube.position = nextPosition()
            registerToggle(toggleCube, component: ToggleVisibilityComponent(interval: 1))
            attachLabel(to: toggleCube, text: "ToggleVisibilityComponent")
            anchor.addChild(toggleCube)

            // BounceX component example.
            let bounceXCube = makeCube()
            bounceXCube.position = nextPosition()
            registerToggle(bounceXCube, component: BounceXComponent(amplitude: 0.1, speed: 2, phase: 0, origin: bounceXCube.position))
            attachLabel(to: bounceXCube, text: "BounceXComponent")
            anchor.addChild(bounceXCube)

            // BounceZ component example.
            let bounceZCube = makeCube()
            bounceZCube.position = nextPosition()
            registerToggle(bounceZCube, component: BounceZComponent(amplitude: 0.1, speed: 2, phase: 0, origin: bounceZCube.position))
            attachLabel(to: bounceZCube, text: "BounceZComponent")
            anchor.addChild(bounceZCube)

            // SpinColor component example.
            let spinColorCube = makeCube()
            spinColorCube.position = nextPosition()
            registerToggle(spinColorCube, component: SpinColorComponent(spinSpeed: .pi, colorSpeed: 2))
            attachLabel(to: spinColorCube, text: "SpinColorComponent")
            anchor.addChild(spinColorCube)

            // ScaleX component example.
            let scaleXCube = makeCube()
            scaleXCube.position = nextPosition()
            scaleXCube.model?.materials = [UnlitMaterial(color: .white.withAlphaComponent(0.1))]
            scaleXCube.components.set(GlowComponent(intensity: 0.5))
            registerToggle(scaleXCube, component: ScaleXComponent(rate: 0.1))
            attachLabel(to: scaleXCube, text: "ScaleXComponent")
            anchor.addChild(scaleXCube)

            // ScaleY component example.
            let scaleYCube = makeCube()
            scaleYCube.position = nextPosition()
            scaleYCube.model?.materials = [UnlitMaterial(color: .white.withAlphaComponent(0.1))]
            registerToggle(scaleYCube, component: ScaleYComponent(rate: 0.1))
            scaleYCube.components.set(GlowComponent(intensity: 0.5))
            attachLabel(to: scaleYCube, text: "ScaleYComponent")
            anchor.addChild(scaleYCube)

            // ScaleZ component example.
            let scaleZCube = makeCube()
            scaleZCube.position = nextPosition()
            scaleZCube.model?.materials = [UnlitMaterial(color: .white.withAlphaComponent(0.1))]
            scaleZCube.components.set(GlowComponent(intensity: 0.5))
            registerToggle(scaleZCube, component: ScaleZComponent(rate: 0.1))
            attachLabel(to: scaleZCube, text: "ScaleZComponent")
            anchor.addChild(scaleZCube)

            // TiltX component example.
            let tiltXCube = makeCube()
            tiltXCube.position = nextPosition()
            registerToggle(tiltXCube, component: TiltXComponent(amplitude: .pi/8, speed: 2, phase: 0))
            attachLabel(to: tiltXCube, text: "TiltXComponent")
            anchor.addChild(tiltXCube)

            // TiltY component example.
            let tiltYCube = makeCube()
            tiltYCube.position = nextPosition()
            registerToggle(tiltYCube, component: TiltYComponent(amplitude: .pi/8, speed: 2, phase: 0))
            attachLabel(to: tiltYCube, text: "TiltYComponent")
            anchor.addChild(tiltYCube)

            // TiltZ component example.
            let tiltZCube = makeCube()
            tiltZCube.position = nextPosition()
            registerToggle(tiltZCube, component: TiltZComponent(amplitude: .pi/8, speed: 2, phase: 0))
            attachLabel(to: tiltZCube, text: "TiltZComponent")
            anchor.addChild(tiltZCube)

            // JumpX component example.
            let jumpXCube = makeCube()
            jumpXCube.position = nextPosition()
            registerToggle(jumpXCube, component: JumpXComponent(height: 0.2, speed: 4, phase: 0, origin: jumpXCube.position.x))
            attachLabel(to: jumpXCube, text: "JumpXComponent")
            anchor.addChild(jumpXCube)

            // JumpZ component example.
            let jumpZCube = makeCube()
            jumpZCube.position = nextPosition()
            registerToggle(jumpZCube, component: JumpZComponent(height: 0.2, speed: 4, phase: 0, origin: jumpZCube.position.z))
            attachLabel(to: jumpZCube, text: "JumpZComponent")
            anchor.addChild(jumpZCube)

            // SlideY component example.
            let slideYCube = makeCube()
            slideYCube.position = nextPosition()
            registerToggle(slideYCube, component: SlideYComponent(speed: 0.2, length: 0.3, position: 0, forward: true))
            attachLabel(to: slideYCube, text: "SlideYComponent")
            anchor.addChild(slideYCube)

            // SlideZ component example.
            let slideZCube = makeCube()
            slideZCube.position = nextPosition()
            registerToggle(slideZCube, component: SlideZComponent(speed: 0.2, length: 0.3, position: 0, forward: true))
            attachLabel(to: slideZCube, text: "SlideZComponent")
            anchor.addChild(slideZCube)

            // PulseWidth component example.
            let pulseWidthCube = makeCube()
            pulseWidthCube.position = nextPosition()
            registerToggle(pulseWidthCube, component: PulseWidthComponent(amplitude: 0.2, speed: 2, phase: 0))
            attachLabel(to: pulseWidthCube, text: "PulseWidthComponent")
            anchor.addChild(pulseWidthCube)

            // PulseHeight component example.
            let pulseHeightCube = makeCube()
            pulseHeightCube.position = nextPosition()
            registerToggle(pulseHeightCube, component: PulseHeightComponent(amplitude: 0.2, speed: 2, phase: 0))
            attachLabel(to: pulseHeightCube, text: "PulseHeightComponent")
            anchor.addChild(pulseHeightCube)

            // PulseDepth component example.
            let pulseDepthCube = makeCube()
            pulseDepthCube.position = nextPosition()
            registerToggle(pulseDepthCube, component: PulseDepthComponent(amplitude: 0.2, speed: 2, phase: 0))
            attachLabel(to: pulseDepthCube, text: "PulseDepthComponent")
            anchor.addChild(pulseDepthCube)

            // OrbitX component example.
            let orbitXCube = makeCube()
            orbitXCube.position = nextPosition()
            registerToggle(orbitXCube, component: OrbitXComponent(center: orbitXCube.position, radius: 0.2, speed: 2, angle: 0))
            attachLabel(to: orbitXCube, text: "OrbitXComponent")
            anchor.addChild(orbitXCube)

            // HitHighlight component example.
            let hitCube = makeCube()
            hitCube.position = nextPosition()
            hitCube.components.set(CollisionComponent(shapes: [.generateBox(size: [10, 0.1, 10])]))
            registerToggle(hitCube, component: HitHighlightComponent())
            attachLabel(to: hitCube, text: "HitHighlightComponent")
            anchor.addChild(hitCube)

            // ProximityDetector component example.
            let proximityCube = makeCube()
            proximityCube.position = nextPosition()
            registerToggle(proximityCube, component: ProximityDetectorComponent(radius: 0.4))
            attachLabel(to: proximityCube, text: "ProximityDetectorComponent")
            anchor.addChild(proximityCube)

            // BoundaryEnforcer component example.
            let boundaryCube = makeCube()
            boundaryCube.position = nextPosition()
            boundaryCube.components.set(MoveComponent(velocity: [0.2,0,0]))
            registerToggle(boundaryCube, component: BoundaryEnforcerComponent(minBounds: [-1,-1,-1], maxBounds: [1,1,-0.5]))
            attachLabel(to: boundaryCube, text: "BoundaryEnforcerComponent")
            anchor.addChild(boundaryCube)

            content.add(anchor)

        }
        .gesture(
            SpatialTapGesture()
                .targetedToAnyEntity()
                .onEnded { value in
                    toggles[ObjectIdentifier(value.entity)]?()
                }
        )
    }
}

//#Preview(immersionStyle: .full) {
//    ImmersiveView()
//        .environment(AppModel())
//}

