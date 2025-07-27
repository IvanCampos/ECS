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
                cube.components.set(CollisionComponent(shapes: [.generateBox(size: [0.25, 0.25, 0.25])], mode: .default, filter: .default))
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
            toggles[ObjectIdentifier(rotateCube)] = { [weak rotateCube] in
                guard let rotateCube else { return }
                toggle(rotateCube, component: RotateComponent(axis: [0, 1, 0], speed: .pi))
            }
            attachLabel(to: rotateCube, text: "RotateComponent")
            anchor.addChild(rotateCube)

            // Blink component example.
            let blinkCube = makeCube()
            blinkCube.position = nextPosition()
            toggles[ObjectIdentifier(blinkCube)] = { [weak blinkCube] in
                guard let blinkCube else { return }
                toggle(blinkCube, component: BlinkComponent(interval: 0.5))
            }
            attachLabel(to: blinkCube, text: "BlinkComponent")
            anchor.addChild(blinkCube)

            // Bob component example.
            let bobCube = makeCube()
            bobCube.position = nextPosition()
            toggles[ObjectIdentifier(bobCube)] = { [weak bobCube] in
                guard let bobCube else { return }
                toggle(bobCube, component: BobComponent(amplitude: 0.1, speed: 2))
            }
            attachLabel(to: bobCube, text: "BobComponent")
            anchor.addChild(bobCube)

            // Color component example.
            let colorCube = makeCube()
            colorCube.position = nextPosition()
            toggles[ObjectIdentifier(colorCube)] = { [weak colorCube] in
                guard let colorCube else { return }
                toggle(colorCube, component: ColorComponent(color: .red))
            }
            attachLabel(to: colorCube, text: "ColorComponent")
            anchor.addChild(colorCube)

            // Drift component example.
            let driftCube = makeCube()
            driftCube.position = nextPosition()
            toggles[ObjectIdentifier(driftCube)] = { [weak driftCube] in
                guard let driftCube else { return }
                toggle(driftCube, component: DriftComponent(velocity: [0.1, 0, 0]))
            }
            attachLabel(to: driftCube, text: "DriftComponent")
            anchor.addChild(driftCube)

            // Elastic component example.
            let elasticCube = makeCube()
            elasticCube.position = nextPosition()
            toggles[ObjectIdentifier(elasticCube)] = { [weak elasticCube] in
                guard let elasticCube else { return }
                toggle(elasticCube, component: ElasticComponent(amplitude: 0.2, speed: 3))
            }
            attachLabel(to: elasticCube, text: "ElasticComponent")
            anchor.addChild(elasticCube)

            // Expire component example.
            let expireCube = makeCube()
            expireCube.position = nextPosition()
            toggles[ObjectIdentifier(expireCube)] = { [weak expireCube] in
                guard let expireCube else { return }
                toggle(expireCube, component: ExpireComponent(timeRemaining: 10))
            }
            attachLabel(to: expireCube, text: "ExpireComponent")
            anchor.addChild(expireCube)

            // Fade component example.
            let fadeCube = makeCube()
            fadeCube.position = nextPosition()
            toggles[ObjectIdentifier(fadeCube)] = { [weak fadeCube] in
                guard let fadeCube else { return }
                toggle(fadeCube, component: FadeComponent(rate: 0.1, alpha: 1))
            }
            attachLabel(to: fadeCube, text: "FadeComponent")
            anchor.addChild(fadeCube)

            // FlashColor component example.
            let flashCube = makeCube()
            flashCube.position = nextPosition()
            toggles[ObjectIdentifier(flashCube)] = { [weak flashCube] in
                guard let flashCube else { return }
                toggle(flashCube, component: FlashColorComponent(interval: 1))
            }
            attachLabel(to: flashCube, text: "FlashColorComponent")
            anchor.addChild(flashCube)

            // Glow component example.
            let glowCube = makeCube()
            glowCube.position = nextPosition()
            toggles[ObjectIdentifier(glowCube)] = { [weak glowCube] in
                guard let glowCube else { return }
                toggle(glowCube, component: GlowComponent(intensity: 0.5))
            }
            attachLabel(to: glowCube, text: "GlowComponent")
            anchor.addChild(glowCube)

            // Gravity component example.
            let gravityCube = makeCube()
            gravityCube.position = nextPosition()
            toggles[ObjectIdentifier(gravityCube)] = { [weak gravityCube] in
                guard let gravityCube else { return }
                toggle(gravityCube, component: GravityComponent())
            }
            attachLabel(to: gravityCube, text: "GravityComponent")
            anchor.addChild(gravityCube)

            // Grow component example.
            let growCube = makeCube()
            growCube.position = nextPosition()
            toggles[ObjectIdentifier(growCube)] = { [weak growCube] in
                guard let growCube else { return }
                toggle(growCube, component: GrowComponent(rate: 0.001))
            }
            attachLabel(to: growCube, text: "GrowComponent")
            anchor.addChild(growCube)

            // Jitter component example.
            let jitterCube = makeCube()
            jitterCube.position = nextPosition()
            toggles[ObjectIdentifier(jitterCube)] = { [weak jitterCube] in
                guard let jitterCube else { return }
                toggle(jitterCube, component: JitterComponent(amplitude: 0.02))
            }
            attachLabel(to: jitterCube, text: "JitterComponent")
            anchor.addChild(jitterCube)

            // Lifetime component example.
            let lifetimeCube = makeCube()
            lifetimeCube.position = nextPosition()
            toggles[ObjectIdentifier(lifetimeCube)] = { [weak lifetimeCube] in
                guard let lifetimeCube else { return }
                toggle(lifetimeCube, component: LifetimeComponent(timeRemaining: 12))
            }
            attachLabel(to: lifetimeCube, text: "LifetimeComponent")
            anchor.addChild(lifetimeCube)

            // Magnet component example.
            let magnetCube = makeCube()
            magnetCube.position = nextPosition()
            toggles[ObjectIdentifier(magnetCube)] = { [weak magnetCube] in
                guard let magnetCube else { return }
                toggle(magnetCube, component: MagnetComponent(target: .zero, strength: 0.5))
            }
            attachLabel(to: magnetCube, text: "MagnetComponent")
            anchor.addChild(magnetCube)

            // Move component example.
            let moveCube = makeCube()
            moveCube.position = nextPosition()
            toggles[ObjectIdentifier(moveCube)] = { [weak moveCube] in
                guard let moveCube else { return }
                toggle(moveCube, component: MoveComponent(velocity: [0.1, 0, 0]))
            }
            attachLabel(to: moveCube, text: "MoveComponent")
            anchor.addChild(moveCube)

            // My component example.
            let myCube = makeCube()
            myCube.position = nextPosition()
            toggles[ObjectIdentifier(myCube)] = { [weak myCube] in
                guard let myCube else { return }
                toggle(myCube, component: MyComponent())
            }
            attachLabel(to: myCube, text: "MyComponent")
            anchor.addChild(myCube)

            // Orbit component example.
            let orbitCube = makeCube()
            orbitCube.position = nextPosition()
            toggles[ObjectIdentifier(orbitCube)] = { [weak orbitCube] in
                guard let orbitCube else { return }
                toggle(orbitCube, component: OrbitComponent(center: orbitCube.position, axis: [0,1,0], speed: 1))
            }
            attachLabel(to: orbitCube, text: "OrbitComponent")
            anchor.addChild(orbitCube)

            // Oscillate component example.
            let oscillateCube = makeCube()
            oscillateCube.position = nextPosition()
            toggles[ObjectIdentifier(oscillateCube)] = { [weak oscillateCube] in
                guard let oscillateCube else { return }
                toggle(oscillateCube, component: OscillateComponent(axis: [1,0,0], amplitude: 0.2, speed: 2))
            }
            attachLabel(to: oscillateCube, text: "OscillateComponent")
            anchor.addChild(oscillateCube)

            // PathMove component example.
            let pathMoveCube = makeCube()
            pathMoveCube.position = nextPosition()
            toggles[ObjectIdentifier(pathMoveCube)] = { [weak pathMoveCube] in
                guard let pathMoveCube else { return }
                toggle(pathMoveCube, component: PathMoveComponent(start: pathMoveCube.position, end: pathMoveCube.position + [0.3,0,0], speed: 0.3))
            }
            attachLabel(to: pathMoveCube, text: "PathMoveComponent")
            anchor.addChild(pathMoveCube)

            // Pulse component example.
            let pulseCube = makeCube()
            pulseCube.position = nextPosition()
            toggles[ObjectIdentifier(pulseCube)] = { [weak pulseCube] in
                guard let pulseCube else { return }
                toggle(pulseCube, component: PulseComponent(amplitude: 0.2, speed: 2))
            }
            attachLabel(to: pulseCube, text: "PulseComponent")
            anchor.addChild(pulseCube)

            // Repel component example.
            let repelCube = makeCube()
            repelCube.position = nextPosition()
            toggles[ObjectIdentifier(repelCube)] = { [weak repelCube] in
                guard let repelCube else { return }
                toggle(repelCube, component: RepelComponent(target: [0,0,-1], strength: 0.5))
            }
            attachLabel(to: repelCube, text: "RepelComponent")
            anchor.addChild(repelCube)

            // Scale component example.
            let scaleCube = makeCube()
            scaleCube.position = nextPosition()
            toggles[ObjectIdentifier(scaleCube)] = { [weak scaleCube] in
                guard let scaleCube else { return }
                toggle(scaleCube, component: ScaleComponent(rate: 0.01))
            }
            attachLabel(to: scaleCube, text: "ScaleComponent")
            anchor.addChild(scaleCube)

            // Shake component example.
            let shakeCube = makeCube()
            shakeCube.position = nextPosition()
            toggles[ObjectIdentifier(shakeCube)] = { [weak shakeCube] in
                guard let shakeCube else { return }
                toggle(shakeCube, component: ShakeComponent(amplitude: 0.05, speed: 5))
            }
            attachLabel(to: shakeCube, text: "ShakeComponent")
            anchor.addChild(shakeCube)

            // Shrink component example.
            let shrinkCube = makeCube()
            shrinkCube.position = nextPosition()
            toggles[ObjectIdentifier(shrinkCube)] = { [weak shrinkCube] in
                guard let shrinkCube else { return }
                toggle(shrinkCube, component: ShrinkComponent(rate: 0.1))
            }
            attachLabel(to: shrinkCube, text: "ShrinkComponent")
            anchor.addChild(shrinkCube)

            // Slide component example.
            let slideCube = makeCube()
            slideCube.position = nextPosition()
            toggles[ObjectIdentifier(slideCube)] = { [weak slideCube] in
                guard let slideCube else { return }
                toggle(slideCube, component: SlideComponent(axis: [1,0,0], speed: 0.3, length: 0.5))
            }
            attachLabel(to: slideCube, text: "SlideComponent")
            anchor.addChild(slideCube)

            // Spin component example.
            let spinCube = makeCube()
            spinCube.position = nextPosition()
            toggles[ObjectIdentifier(spinCube)] = { [weak spinCube] in
                guard let spinCube else { return }
                toggle(spinCube, component: SpinComponent(axis: [0,1,0], speed: .pi))
            }
            attachLabel(to: spinCube, text: "SpinComponent")
            anchor.addChild(spinCube)

            // Strobe component example.
            let strobeCube = makeCube()
            strobeCube.position = nextPosition()
            toggles[ObjectIdentifier(strobeCube)] = { [weak strobeCube] in
                guard let strobeCube else { return }
                toggle(strobeCube, component: StrobeComponent(interval: 0.5, colorA: .blue, colorB: .green))
            }
            attachLabel(to: strobeCube, text: "StrobeComponent")
            anchor.addChild(strobeCube)

            // Tilt component example.
            let tiltCube = makeCube()
            tiltCube.position = nextPosition()
            toggles[ObjectIdentifier(tiltCube)] = { [weak tiltCube] in
                guard let tiltCube else { return }
                toggle(tiltCube, component: TiltComponent(axis: [0,0,1], amplitude: .pi/8, speed: 2))
            }
            attachLabel(to: tiltCube, text: "TiltComponent")
            anchor.addChild(tiltCube)

            // Vibrate component example.
            let vibrateCube = makeCube()
            vibrateCube.position = nextPosition()
            toggles[ObjectIdentifier(vibrateCube)] = { [weak vibrateCube] in
                guard let vibrateCube else { return }
                toggle(vibrateCube, component: VibrateComponent(amplitude: .pi/8, speed: 10))
            }
            attachLabel(to: vibrateCube, text: "VibrateComponent")
            anchor.addChild(vibrateCube)

            // Wander component example.
            let wanderCube = makeCube()
            wanderCube.position = nextPosition()
            toggles[ObjectIdentifier(wanderCube)] = { [weak wanderCube] in
                guard let wanderCube else { return }
                toggle(wanderCube, component: WanderComponent(range: 0.2))
            }
            attachLabel(to: wanderCube, text: "WanderComponent")
            anchor.addChild(wanderCube)

            // Bounce component example.
            let bounceCube = makeCube()
            bounceCube.position = nextPosition()
            toggles[ObjectIdentifier(bounceCube)] = { [weak bounceCube] in
                guard let bounceCube else { return }
                toggle(bounceCube, component: BounceComponent(amplitude: 0.1, speed: 2, origin: bounceCube.position))
            }
            attachLabel(to: bounceCube, text: "BounceComponent")
            anchor.addChild(bounceCube)

            // Twist component example.
            let twistCube = makeCube()
            twistCube.position = nextPosition()
            toggles[ObjectIdentifier(twistCube)] = { [weak twistCube] in
                guard let twistCube else { return }
                toggle(twistCube, component: TwistComponent(axis: [0,1,0], speed: .pi))
            }
            attachLabel(to: twistCube, text: "TwistComponent")
            anchor.addChild(twistCube)

            // Flip component example.
            let flipCube = makeCube()
            flipCube.position = nextPosition()
            toggles[ObjectIdentifier(flipCube)] = { [weak flipCube] in
                guard let flipCube else { return }
                toggle(flipCube, component: FlipComponent(axis: [1,0,0], speed: .pi))
            }
            attachLabel(to: flipCube, text: "FlipComponent")
            anchor.addChild(flipCube)

            // Hover component example.
            let hoverCube = makeCube()
            hoverCube.position = nextPosition()
            toggles[ObjectIdentifier(hoverCube)] = { [weak hoverCube] in
                guard let hoverCube else { return }
                toggle(hoverCube, component: HoverComponent(height: 0.1, amplitude: 0.05, speed: 2, origin: hoverCube.position))
            }
            attachLabel(to: hoverCube, text: "HoverComponent")
            anchor.addChild(hoverCube)

            // Seek component example.
            let seekCube = makeCube()
            seekCube.position = nextPosition()
            toggles[ObjectIdentifier(seekCube)] = { [weak seekCube] in
                guard let seekCube else { return }
                toggle(seekCube, component: SeekComponent(target: .zero, speed: 0.2))
            }
            attachLabel(to: seekCube, text: "SeekComponent")
            anchor.addChild(seekCube)

            // Stretch component example.
            let stretchCube = makeCube()
            stretchCube.position = nextPosition()
            toggles[ObjectIdentifier(stretchCube)] = { [weak stretchCube] in
                guard let stretchCube else { return }
                toggle(stretchCube, component: StretchComponent(axis: [1,0,0], amplitude: 0.2, speed: 0.2))
            }
            attachLabel(to: stretchCube, text: "StretchComponent")
            anchor.addChild(stretchCube)

            // RandomColor component example.
            let randomColorCube = makeCube()
            randomColorCube.position = nextPosition()
            toggles[ObjectIdentifier(randomColorCube)] = { [weak randomColorCube] in
                guard let randomColorCube else { return }
                toggle(randomColorCube, component: RandomColorComponent(interval: 1))
            }
            attachLabel(to: randomColorCube, text: "RandomColorComponent")
            anchor.addChild(randomColorCube)

            // Teleport component example.
            let teleportCube = makeCube()
            teleportCube.position = nextPosition()
            toggles[ObjectIdentifier(teleportCube)] = { [weak teleportCube] in
                guard let teleportCube else { return }
                toggle(teleportCube, component: TeleportComponent(interval: 2, range: 0.2))
            }
            attachLabel(to: teleportCube, text: "TeleportComponent")
            anchor.addChild(teleportCube)

            // Transparency component example.
            let transparencyCube = makeCube()
            transparencyCube.position = nextPosition()
            toggles[ObjectIdentifier(transparencyCube)] = { [weak transparencyCube] in
                guard let transparencyCube else { return }
                toggle(transparencyCube, component: TransparencyComponent(rate: 0.2, alpha: 1))
            }
            attachLabel(to: transparencyCube, text: "TransparencyComponent")
            anchor.addChild(transparencyCube)

            // Spiral component example.
            let spiralCube = makeCube()
            spiralCube.position = nextPosition()
            toggles[ObjectIdentifier(spiralCube)] = { [weak spiralCube] in
                guard let spiralCube else { return }
                toggle(spiralCube, component: SpiralComponent(center: spiralCube.position, radius: 0.2, speed: 0.2, heightSpeed: 0.01))
            }
            attachLabel(to: spiralCube, text: "SpiralComponent")
            anchor.addChild(spiralCube)

            // PulseColor component example.
            let pulseColorCube = makeCube()
            pulseColorCube.position = nextPosition()
            toggles[ObjectIdentifier(pulseColorCube)] = { [weak pulseColorCube] in
                guard let pulseColorCube else { return }
                toggle(pulseColorCube, component: PulseColorComponent(colorA: [1,1,1], colorB: [1,0,0], speed: 2))
            }
            attachLabel(to: pulseColorCube, text: "PulseColorComponent")
            anchor.addChild(pulseColorCube)

            // Flicker component example.
            let flickerCube = makeCube()
            flickerCube.position = nextPosition()
            toggles[ObjectIdentifier(flickerCube)] = { [weak flickerCube] in
                guard let flickerCube else { return }
                toggle(flickerCube, component: FlickerComponent(probability: 0.1))
            }
            attachLabel(to: flickerCube, text: "FlickerComponent")
            anchor.addChild(flickerCube)

            // Snap component example.
            let snapCube = makeCube()
            snapCube.position = nextPosition()
            toggles[ObjectIdentifier(snapCube)] = { [weak snapCube] in
                guard let snapCube else { return }
                toggle(snapCube, component: SnapComponent(gridSize: 0.1))
            }
            attachLabel(to: snapCube, text: "SnapComponent")
            anchor.addChild(snapCube)

            // Beeline component example.
            let beelineCube = makeCube()
            beelineCube.position = nextPosition()
            toggles[ObjectIdentifier(beelineCube)] = { [weak beelineCube] in
                guard let beelineCube else { return }
                toggle(beelineCube, component: BeelineComponent(direction: [0,0,-1], speed: 0.2))
            }
            attachLabel(to: beelineCube, text: "BeelineComponent")
            anchor.addChild(beelineCube)

            // Boomerang component example.
            let boomerangCube = makeCube()
            boomerangCube.position = nextPosition()
            toggles[ObjectIdentifier(boomerangCube)] = { [weak boomerangCube] in
                guard let boomerangCube else { return }
                toggle(boomerangCube, component: BoomerangComponent(start: boomerangCube.position, end: boomerangCube.position + [0,0,0.3], speed: 0.2))
            }
            attachLabel(to: boomerangCube, text: "BoomerangComponent")
            anchor.addChild(boomerangCube)

            // Twinkle component example.
            let twinkleCube = makeCube()
            twinkleCube.position = nextPosition()
            toggles[ObjectIdentifier(twinkleCube)] = { [weak twinkleCube] in
                guard let twinkleCube else { return }
                toggle(twinkleCube, component: TwinkleComponent(interval: 0.5))
            }
            attachLabel(to: twinkleCube, text: "TwinkleComponent")
            anchor.addChild(twinkleCube)

            // RandomScale component example.
            let randomScaleCube = makeCube()
            randomScaleCube.position = nextPosition()
            toggles[ObjectIdentifier(randomScaleCube)] = { [weak randomScaleCube] in
                guard let randomScaleCube else { return }
                toggle(randomScaleCube, component: RandomScaleComponent(range: 0.02))
            }
            attachLabel(to: randomScaleCube, text: "RandomScaleComponent")
            anchor.addChild(randomScaleCube)

            // Wobble component example.
            let wobbleCube = makeCube()
            wobbleCube.position = nextPosition()
            toggles[ObjectIdentifier(wobbleCube)] = { [weak wobbleCube] in
                guard let wobbleCube else { return }
                toggle(wobbleCube, component: WobbleComponent(axis: [1,0,0], amplitude: .pi/8, speed: 3))
            }
            attachLabel(to: wobbleCube, text: "WobbleComponent")
            anchor.addChild(wobbleCube)

            // Align component example.
            let alignCube = makeCube()
            alignCube.position = nextPosition()
            toggles[ObjectIdentifier(alignCube)] = { [weak alignCube] in
                guard let alignCube else { return }
                toggle(alignCube, component: AlignComponent())
            }
            attachLabel(to: alignCube, text: "AlignComponent")
            anchor.addChild(alignCube)

            // ZigZag component example.
            let zigzagCube = makeCube()
            zigzagCube.position = nextPosition()
            toggles[ObjectIdentifier(zigzagCube)] = { [weak zigzagCube] in
                guard let zigzagCube else { return }
                toggle(zigzagCube, component: ZigZagComponent(axis: [1,0,0], speed: 0.2, length: 0.3))
            }
            attachLabel(to: zigzagCube, text: "ZigZagComponent")
            anchor.addChild(zigzagCube)

            // MoveX component example.
            let moveXCube = makeCube()
            moveXCube.position = nextPosition()
            moveXCube.model?.materials = [UnlitMaterial(color: .cyan.withAlphaComponent(0.3))]
            toggles[ObjectIdentifier(moveXCube)] = { [weak moveXCube] in
                guard let moveXCube else { return }
                toggle(moveXCube, component: MoveXComponent(speed: 0.01))
            }
            attachLabel(to: moveXCube, text: "MoveXComponent")
            anchor.addChild(moveXCube)

            // MoveY component example.
            let moveYCube = makeCube()
            moveYCube.position = nextPosition()
            moveYCube.model?.materials = [UnlitMaterial(color: .cyan.withAlphaComponent(0.3))]
            toggles[ObjectIdentifier(moveYCube)] = { [weak moveYCube] in
                guard let moveYCube else { return }
                toggle(moveYCube, component: MoveYComponent(speed: 0.01))
            }
            attachLabel(to: moveYCube, text: "MoveYComponent")
            anchor.addChild(moveYCube)

            // MoveZ component example.
            let moveZCube = makeCube()
            moveZCube.position = nextPosition()
            moveZCube.model?.materials = [UnlitMaterial(color: .cyan.withAlphaComponent(0.3))]
            toggles[ObjectIdentifier(moveZCube)] = { [weak moveZCube] in
                guard let moveZCube else { return }
                toggle(moveZCube, component: MoveZComponent(speed: 0.01))
            }
            attachLabel(to: moveZCube, text: "MoveZComponent")
            anchor.addChild(moveZCube)

            // PulseScale component example.
            let pulseScaleCube = makeCube()
            pulseScaleCube.position = nextPosition()
            toggles[ObjectIdentifier(pulseScaleCube)] = { [weak pulseScaleCube] in
                guard let pulseScaleCube else { return }
                toggle(pulseScaleCube, component: PulseScaleComponent(amplitude: 0.02, speed: 2))
            }
            attachLabel(to: pulseScaleCube, text: "PulseScaleComponent")
            anchor.addChild(pulseScaleCube)

            // ColorCycle component example.
            let colorCycleCube = makeCube()
            colorCycleCube.position = nextPosition()
            toggles[ObjectIdentifier(colorCycleCube)] = { [weak colorCycleCube] in
                guard let colorCycleCube else { return }
                toggle(colorCycleCube, component: ColorCycleComponent(speed: 0.5))
            }
            attachLabel(to: colorCycleCube, text: "ColorCycleComponent")
            anchor.addChild(colorCycleCube)

            // PingPongX component example.
            let pingPongXCube = makeCube()
            pingPongXCube.position = nextPosition()
            toggles[ObjectIdentifier(pingPongXCube)] = { [weak pingPongXCube] in
                guard let pingPongXCube else { return }
                toggle(pingPongXCube, component: PingPongXComponent(amplitude: 0.1, speed: 2, origin: pingPongXCube.position.x))
            }
            attachLabel(to: pingPongXCube, text: "PingPongXComponent")
            anchor.addChild(pingPongXCube)

            // PingPongY component example.
            let pingPongYCube = makeCube()
            pingPongYCube.position = nextPosition()
            toggles[ObjectIdentifier(pingPongYCube)] = { [weak pingPongYCube] in
                guard let pingPongYCube else { return }
                toggle(pingPongYCube, component: PingPongYComponent(amplitude: 0.1, speed: 2, origin: pingPongYCube.position.y))
            }
            attachLabel(to: pingPongYCube, text: "PingPongYComponent")
            anchor.addChild(pingPongYCube)

            // PingPongZ component example.
            let pingPongZCube = makeCube()
            pingPongZCube.position = nextPosition()
            toggles[ObjectIdentifier(pingPongZCube)] = { [weak pingPongZCube] in
                guard let pingPongZCube else { return }
                toggle(pingPongZCube, component: PingPongZComponent(amplitude: 0.1, speed: 2, origin: pingPongZCube.position.z))
            }
            attachLabel(to: pingPongZCube, text: "PingPongZComponent")
            anchor.addChild(pingPongZCube)

            // RollX component example.
            let rollXCube = makeCube()
            rollXCube.position = nextPosition()
            toggles[ObjectIdentifier(rollXCube)] = { [weak rollXCube] in
                guard let rollXCube else { return }
                toggle(rollXCube, component: RollXComponent(speed: .pi))
            }
            attachLabel(to: rollXCube, text: "RollXComponent")
            anchor.addChild(rollXCube)

            // RollZ component example.
            let rollZCube = makeCube()
            rollZCube.position = nextPosition()
            toggles[ObjectIdentifier(rollZCube)] = { [weak rollZCube] in
                guard let rollZCube else { return }
                toggle(rollZCube, component: RollZComponent(speed: .pi))
            }
            attachLabel(to: rollZCube, text: "RollZComponent")
            anchor.addChild(rollZCube)

            // FlashScale component example.
            let flashScaleCube = makeCube()
            flashScaleCube.position = nextPosition()
            toggles[ObjectIdentifier(flashScaleCube)] = { [weak flashScaleCube] in
                guard let flashScaleCube else { return }
                toggle(flashScaleCube, component: FlashScaleComponent(interval: 1))
            }
            attachLabel(to: flashScaleCube, text: "FlashScaleComponent")
            anchor.addChild(flashScaleCube)

            // DiagonalDrift component example.
            let diagonalDriftCube = makeCube()
            diagonalDriftCube.position = nextPosition()
            toggles[ObjectIdentifier(diagonalDriftCube)] = { [weak diagonalDriftCube] in
                guard let diagonalDriftCube else { return }
                toggle(diagonalDriftCube, component: DiagonalDriftComponent(velocity: [0.05, 0, 0.05]))
            }
            attachLabel(to: diagonalDriftCube, text: "DiagonalDriftComponent")
            anchor.addChild(diagonalDriftCube)

            // Rock component example.
            let rockCube = makeCube()
            rockCube.position = nextPosition()
            toggles[ObjectIdentifier(rockCube)] = { [weak rockCube] in
                guard let rockCube else { return }
                toggle(rockCube, component: RockComponent(amplitude: .pi/8, speed: 3))
            }
            attachLabel(to: rockCube, text: "RockComponent")
            anchor.addChild(rockCube)

            // Shimmer component example.
            let shimmerCube = makeCube()
            shimmerCube.position = nextPosition()
            toggles[ObjectIdentifier(shimmerCube)] = { [weak shimmerCube] in
                guard let shimmerCube else { return }
                toggle(shimmerCube, component: ShimmerComponent(speed: 3))
            }
            attachLabel(to: shimmerCube, text: "ShimmerComponent")
            anchor.addChild(shimmerCube)

            // SpiralMove component example.
            let spiralMoveCube = makeCube()
            spiralMoveCube.position = nextPosition()
            toggles[ObjectIdentifier(spiralMoveCube)] = { [weak spiralMoveCube] in
                guard let spiralMoveCube else { return }
                toggle(spiralMoveCube, component: SpiralMoveComponent(center: spiralMoveCube.position, radius: 0.2, speed: 0.2, angle: 0, heightSpeed: 0.05))
            }
            attachLabel(to: spiralMoveCube, text: "SpiralMoveComponent")
            anchor.addChild(spiralMoveCube)

            // TeleportRandom component example.
            let teleportRandomCube = makeCube()
            teleportRandomCube.position = nextPosition()
            toggles[ObjectIdentifier(teleportRandomCube)] = { [weak teleportRandomCube] in
                guard let teleportRandomCube else { return }
                toggle(teleportRandomCube, component: TeleportRandomComponent(interval: 2, range: 0.2))
            }
            attachLabel(to: teleportRandomCube, text: "TeleportRandomComponent")
            anchor.addChild(teleportRandomCube)

            // BlinkColor component example.
            let blinkColorCube = makeCube()
            blinkColorCube.position = nextPosition()
            toggles[ObjectIdentifier(blinkColorCube)] = { [weak blinkColorCube] in
                guard let blinkColorCube else { return }
                toggle(blinkColorCube, component: BlinkColorComponent(interval: 1, colorA: [1,0,0], colorB: [0,1,0]))
            }
            attachLabel(to: blinkColorCube, text: "BlinkColorComponent")
            anchor.addChild(blinkColorCube)

            // BounceTilt component example.
            let bounceTiltCube = makeCube()
            bounceTiltCube.position = nextPosition()
            toggles[ObjectIdentifier(bounceTiltCube)] = { [weak bounceTiltCube] in
                guard let bounceTiltCube else { return }
                toggle(bounceTiltCube, component: BounceTiltComponent(amplitude: 0.1, speed: 3, origin: bounceTiltCube.position))
            }
            attachLabel(to: bounceTiltCube, text: "BounceTiltComponent")
            anchor.addChild(bounceTiltCube)

            // SeekRotate component example.
            let seekRotateCube = makeCube()
            seekRotateCube.position = nextPosition()
            toggles[ObjectIdentifier(seekRotateCube)] = { [weak seekRotateCube] in
                guard let seekRotateCube else { return }
                toggle(seekRotateCube, component: SeekRotateComponent(target: .zero, moveSpeed: 0.1, rotateSpeed: .pi))
            }
            attachLabel(to: seekRotateCube, text: "SeekRotateComponent")
            anchor.addChild(seekRotateCube)

            // OrbitScale component example.
            let orbitScaleCube = makeCube()
            orbitScaleCube.position = nextPosition()
            toggles[ObjectIdentifier(orbitScaleCube)] = { [weak orbitScaleCube] in
                guard let orbitScaleCube else { return }
                toggle(orbitScaleCube, component: OrbitScaleComponent(center: orbitScaleCube.position, radius: 0.2, speed: 0.2, angle: 0, amplitude: 0.2, phase: 0))
            }
            attachLabel(to: orbitScaleCube, text: "OrbitScaleComponent")
            anchor.addChild(orbitScaleCube)

            // Sway component example.
            let swayCube = makeCube()
            swayCube.position = nextPosition()
            toggles[ObjectIdentifier(swayCube)] = { [weak swayCube] in
                guard let swayCube else { return }
                toggle(swayCube, component: SwayComponent(amplitudeX: 0.1, amplitudeZ: 0.1, speed: 2, phase: 0, origin: swayCube.position))
            }
            attachLabel(to: swayCube, text: "SwayComponent")
            anchor.addChild(swayCube)

            // DriftRotate component example.
            let driftRotateCube = makeCube()
            driftRotateCube.position = nextPosition()
            toggles[ObjectIdentifier(driftRotateCube)] = { [weak driftRotateCube] in
                guard let driftRotateCube else { return }
                toggle(driftRotateCube, component: DriftRotateComponent(velocity: [0.05, 0, 0], rotationSpeed: .pi))
            }
            attachLabel(to: driftRotateCube, text: "DriftRotateComponent")
            anchor.addChild(driftRotateCube)

            // BounceScale component example.
            let bounceScaleCube = makeCube()
            bounceScaleCube.position = nextPosition()
            toggles[ObjectIdentifier(bounceScaleCube)] = { [weak bounceScaleCube] in
                guard let bounceScaleCube else { return }
                toggle(bounceScaleCube, component: BounceScaleComponent(amplitude: 0.2, speed: 2, phase: 0))
            }
            attachLabel(to: bounceScaleCube, text: "BounceScaleComponent")
            anchor.addChild(bounceScaleCube)

            // FadeColor component example.
            let fadeColorCube = makeCube()
            fadeColorCube.position = nextPosition()
            toggles[ObjectIdentifier(fadeColorCube)] = { [weak fadeColorCube] in
                guard let fadeColorCube else { return }
                toggle(fadeColorCube, component: FadeColorComponent(colorA: [1,1,1], colorB: [0,0,1], speed: 2, phase: 0))
            }
            attachLabel(to: fadeColorCube, text: "FadeColorComponent")
            anchor.addChild(fadeColorCube)

            // PulseOpacity component example.
            let pulseOpacityCube = makeCube()
            pulseOpacityCube.position = nextPosition()
            toggles[ObjectIdentifier(pulseOpacityCube)] = { [weak pulseOpacityCube] in
                guard let pulseOpacityCube else { return }
                toggle(pulseOpacityCube, component: PulseOpacityComponent(baseAlpha: 1, amplitude: 0.5, speed: 2, phase: 0))
            }
            attachLabel(to: pulseOpacityCube, text: "PulseOpacityComponent")
            anchor.addChild(pulseOpacityCube)

            // StepMove component example.
            let stepMoveCube = makeCube()
            stepMoveCube.position = nextPosition()
            toggles[ObjectIdentifier(stepMoveCube)] = { [weak stepMoveCube] in
                guard let stepMoveCube else { return }
                toggle(stepMoveCube, component: StepMoveComponent(axis: [0,0,1], step: 0.05, interval: 0.5, timer: 0))
            }
            attachLabel(to: stepMoveCube, text: "StepMoveComponent")
            anchor.addChild(stepMoveCube)

            // ShakeRotation component example.
            let shakeRotationCube = makeCube()
            shakeRotationCube.position = nextPosition()
            toggles[ObjectIdentifier(shakeRotationCube)] = { [weak shakeRotationCube] in
                guard let shakeRotationCube else { return }
                toggle(shakeRotationCube, component: ShakeRotationComponent(amplitude: .pi/8, speed: 5, phase: 0))
            }
            attachLabel(to: shakeRotationCube, text: "ShakeRotationComponent")
            anchor.addChild(shakeRotationCube)

            // GrowFade component example.
            let growFadeCube = makeCube()
            growFadeCube.position = nextPosition()
            toggles[ObjectIdentifier(growFadeCube)] = { [weak growFadeCube] in
                guard let growFadeCube else { return }
                toggle(growFadeCube, component: GrowFadeComponent(growRate: 0.01, fadeRate: 0.1, alpha: 1))
            }
            attachLabel(to: growFadeCube, text: "GrowFadeComponent")
            anchor.addChild(growFadeCube)

            // PulseColorScale component example.
            let pulseColorScaleCube = makeCube()
            pulseColorScaleCube.position = nextPosition()
            toggles[ObjectIdentifier(pulseColorScaleCube)] = { [weak pulseColorScaleCube] in
                guard let pulseColorScaleCube else { return }
                toggle(pulseColorScaleCube, component: PulseColorScaleComponent(amplitude: 0.1, colorA: [1,0,0], colorB: [0,1,0], speed: 2, phase: 0))
            }
            attachLabel(to: pulseColorScaleCube, text: "PulseColorScaleComponent")
            anchor.addChild(pulseColorScaleCube)

            // DriftColor component example.
            let driftColorCube = makeCube()
            driftColorCube.position = nextPosition()
            toggles[ObjectIdentifier(driftColorCube)] = { [weak driftColorCube] in
                guard let driftColorCube else { return }
                toggle(driftColorCube, component: DriftColorComponent(velocity: [0.05,0,0], speed: 2, phase: 0))
            }
            attachLabel(to: driftColorCube, text: "DriftColorComponent")
            anchor.addChild(driftColorCube)

            // OrbitTilt component example.
            let orbitTiltCube = makeCube()
            orbitTiltCube.position = nextPosition()
            toggles[ObjectIdentifier(orbitTiltCube)] = { [weak orbitTiltCube] in
                guard let orbitTiltCube else { return }
                toggle(orbitTiltCube, component: OrbitTiltComponent(center: orbitTiltCube.position, radius: 0.2, speed: 2, angle: 0, tiltAmplitude: .pi/8))
            }
            attachLabel(to: orbitTiltCube, text: "OrbitTiltComponent")
            anchor.addChild(orbitTiltCube)

            // PulseRotation component example.
            let pulseRotationCube = makeCube()
            pulseRotationCube.position = nextPosition()
            toggles[ObjectIdentifier(pulseRotationCube)] = { [weak pulseRotationCube] in
                guard let pulseRotationCube else { return }
                toggle(pulseRotationCube, component: PulseRotationComponent(axis: [0,1,0], amplitude: .pi/4, speed: 2, phase: 0))
            }
            attachLabel(to: pulseRotationCube, text: "PulseRotationComponent")
            anchor.addChild(pulseRotationCube)

            // OrbitColor component example.
            let orbitColorCube = makeCube()
            orbitColorCube.position = nextPosition()
            toggles[ObjectIdentifier(orbitColorCube)] = { [weak orbitColorCube] in
                guard let orbitColorCube else { return }
                toggle(orbitColorCube, component: OrbitColorComponent(center: orbitColorCube.position, radius: 0.2, speed: 2, angle: 0, colorSpeed: 1, phase: 0))
            }
            attachLabel(to: orbitColorCube, text: "OrbitColorComponent")
            anchor.addChild(orbitColorCube)

            // SlideTilt component example.
            let slideTiltCube = makeCube()
            slideTiltCube.position = nextPosition()
            toggles[ObjectIdentifier(slideTiltCube)] = { [weak slideTiltCube] in
                guard let slideTiltCube else { return }
                toggle(slideTiltCube, component: SlideTiltComponent(axis: [1,0,0], speed: 0.2, length: 0.3, position: 0, tiltAmplitude: .pi/8, forward: true))
            }
            attachLabel(to: slideTiltCube, text: "SlideTiltComponent")
            anchor.addChild(slideTiltCube)

            // SpinScale component example.
            let spinScaleCube = makeCube()
            spinScaleCube.position = nextPosition()
            toggles[ObjectIdentifier(spinScaleCube)] = { [weak spinScaleCube] in
                guard let spinScaleCube else { return }
                toggle(spinScaleCube, component: SpinScaleComponent(axis: [0,1,0], spinSpeed: .pi, scaleRate: 0.01))
            }
            attachLabel(to: spinScaleCube, text: "SpinScaleComponent")
            anchor.addChild(spinScaleCube)

            // BobRotate component example.
            let bobRotateCube = makeCube()
            bobRotateCube.position = nextPosition()
            toggles[ObjectIdentifier(bobRotateCube)] = { [weak bobRotateCube] in
                guard let bobRotateCube else { return }
                toggle(bobRotateCube, component: BobRotateComponent(amplitude: 0.1, speed: 2, rotateSpeed: .pi, phase: 0, origin: bobRotateCube.position.y))
            }
            attachLabel(to: bobRotateCube, text: "BobRotateComponent")
            anchor.addChild(bobRotateCube)

            // TiltRandom component example.
            let tiltRandomCube = makeCube()
            tiltRandomCube.position = nextPosition()
            toggles[ObjectIdentifier(tiltRandomCube)] = { [weak tiltRandomCube] in
                guard let tiltRandomCube else { return }
                toggle(tiltRandomCube, component: TiltRandomComponent(amplitude: .pi/8, interval: 1, timer: 0))
            }
            attachLabel(to: tiltRandomCube, text: "TiltRandomComponent")
            anchor.addChild(tiltRandomCube)

            // ColorRise component example.
            let colorRiseCube = makeCube()
            colorRiseCube.position = nextPosition()
            toggles[ObjectIdentifier(colorRiseCube)] = { [weak colorRiseCube] in
                guard let colorRiseCube else { return }
                toggle(colorRiseCube, component: ColorRiseComponent(speed: 0.05, colorA: [0,0,1], colorB: [1,0,0], height: 0.5))
            }
            attachLabel(to: colorRiseCube, text: "ColorRiseComponent")
            anchor.addChild(colorRiseCube)

            // Jump component example.
            let jumpCube = makeCube()
            jumpCube.position = nextPosition()
            toggles[ObjectIdentifier(jumpCube)] = { [weak jumpCube] in
                guard let jumpCube else { return }
                toggle(jumpCube, component: JumpComponent(height: 0.2, speed: 4, phase: 0, origin: jumpCube.position.y))
            }
            attachLabel(to: jumpCube, text: "JumpComponent")
            anchor.addChild(jumpCube)

            // Nudge component example.
            let nudgeCube = makeCube()
            nudgeCube.position = nextPosition()
            toggles[ObjectIdentifier(nudgeCube)] = { [weak nudgeCube] in
                guard let nudgeCube else { return }
                toggle(nudgeCube, component: NudgeComponent(amplitude: 0.05))
            }
            attachLabel(to: nudgeCube, text: "NudgeComponent")
            anchor.addChild(nudgeCube)

            // RollY component example.
            let rollYCube = makeCube()
            rollYCube.position = nextPosition()
            toggles[ObjectIdentifier(rollYCube)] = { [weak rollYCube] in
                guard let rollYCube else { return }
                toggle(rollYCube, component: RollYComponent(speed: .pi))
            }
            attachLabel(to: rollYCube, text: "RollYComponent")
            anchor.addChild(rollYCube)

            // Glide component example.
            let glideCube = makeCube()
            glideCube.position = nextPosition()
            toggles[ObjectIdentifier(glideCube)] = { [weak glideCube] in
                guard let glideCube else { return }
                toggle(glideCube, component: GlideComponent(velocity: [0.05, 0, 0]))
            }
            attachLabel(to: glideCube, text: "GlideComponent")
            anchor.addChild(glideCube)

            // ToggleVisibility component example.
            let toggleCube = makeCube()
            toggleCube.position = nextPosition()
            toggles[ObjectIdentifier(toggleCube)] = { [weak toggleCube] in
                guard let toggleCube else { return }
                toggle(toggleCube, component: ToggleVisibilityComponent(interval: 1))
            }
            attachLabel(to: toggleCube, text: "ToggleVisibilityComponent")
            anchor.addChild(toggleCube)

            // BounceX component example.
            let bounceXCube = makeCube()
            bounceXCube.position = nextPosition()
            toggles[ObjectIdentifier(bounceXCube)] = { [weak bounceXCube] in
                guard let bounceXCube else { return }
                toggle(bounceXCube, component: BounceXComponent(amplitude: 0.1, speed: 2, phase: 0, origin: bounceXCube.position))
            }
            attachLabel(to: bounceXCube, text: "BounceXComponent")
            anchor.addChild(bounceXCube)

            // BounceZ component example.
            let bounceZCube = makeCube()
            bounceZCube.position = nextPosition()
            toggles[ObjectIdentifier(bounceZCube)] = { [weak bounceZCube] in
                guard let bounceZCube else { return }
                toggle(bounceZCube, component: BounceZComponent(amplitude: 0.1, speed: 2, phase: 0, origin: bounceZCube.position))
            }
            attachLabel(to: bounceZCube, text: "BounceZComponent")
            anchor.addChild(bounceZCube)

            // SpinColor component example.
            let spinColorCube = makeCube()
            spinColorCube.position = nextPosition()
            toggles[ObjectIdentifier(spinColorCube)] = { [weak spinColorCube] in
                guard let spinColorCube else { return }
                toggle(spinColorCube, component: SpinColorComponent(spinSpeed: .pi, colorSpeed: 2))
            }
            attachLabel(to: spinColorCube, text: "SpinColorComponent")
            anchor.addChild(spinColorCube)

            // ScaleX component example.
            let scaleXCube = makeCube()
            scaleXCube.position = nextPosition()
            scaleXCube.model?.materials = [UnlitMaterial(color: .white.withAlphaComponent(0.1))]
            scaleXCube.components.set(GlowComponent(intensity: 0.5))
            toggles[ObjectIdentifier(scaleXCube)] = { [weak scaleXCube] in
                guard let scaleXCube else { return }
                toggle(scaleXCube, component: ScaleXComponent(rate: 0.1))
            }
            attachLabel(to: scaleXCube, text: "ScaleXComponent")
            anchor.addChild(scaleXCube)

            // ScaleY component example.
            let scaleYCube = makeCube()
            scaleYCube.position = nextPosition()
            scaleYCube.model?.materials = [UnlitMaterial(color: .white.withAlphaComponent(0.1))]
            toggles[ObjectIdentifier(scaleYCube)] = { [weak scaleYCube] in
                guard let scaleYCube else { return }
                toggle(scaleYCube, component: ScaleYComponent(rate: 0.1))
            }
            scaleYCube.components.set(GlowComponent(intensity: 0.5))
            attachLabel(to: scaleYCube, text: "ScaleYComponent")
            anchor.addChild(scaleYCube)

            // ScaleZ component example.
            let scaleZCube = makeCube()
            scaleZCube.position = nextPosition()
            scaleZCube.model?.materials = [UnlitMaterial(color: .white.withAlphaComponent(0.1))]
            scaleZCube.components.set(GlowComponent(intensity: 0.5))
            toggles[ObjectIdentifier(scaleZCube)] = { [weak scaleZCube] in
                guard let scaleZCube else { return }
                toggle(scaleZCube, component: ScaleZComponent(rate: 0.1))
            }
            attachLabel(to: scaleZCube, text: "ScaleZComponent")
            anchor.addChild(scaleZCube)

            // TiltX component example.
            let tiltXCube = makeCube()
            tiltXCube.position = nextPosition()
            toggles[ObjectIdentifier(tiltXCube)] = { [weak tiltXCube] in
                guard let tiltXCube else { return }
                toggle(tiltXCube, component: TiltXComponent(amplitude: .pi/8, speed: 2, phase: 0))
            }
            attachLabel(to: tiltXCube, text: "TiltXComponent")
            anchor.addChild(tiltXCube)

            // TiltY component example.
            let tiltYCube = makeCube()
            tiltYCube.position = nextPosition()
            toggles[ObjectIdentifier(tiltYCube)] = { [weak tiltYCube] in
                guard let tiltYCube else { return }
                toggle(tiltYCube, component: TiltYComponent(amplitude: .pi/8, speed: 2, phase: 0))
            }
            attachLabel(to: tiltYCube, text: "TiltYComponent")
            anchor.addChild(tiltYCube)

            // TiltZ component example.
            let tiltZCube = makeCube()
            tiltZCube.position = nextPosition()
            toggles[ObjectIdentifier(tiltZCube)] = { [weak tiltZCube] in
                guard let tiltZCube else { return }
                toggle(tiltZCube, component: TiltZComponent(amplitude: .pi/8, speed: 2, phase: 0))
            }
            attachLabel(to: tiltZCube, text: "TiltZComponent")
            anchor.addChild(tiltZCube)

            // JumpX component example.
            let jumpXCube = makeCube()
            jumpXCube.position = nextPosition()
            toggles[ObjectIdentifier(jumpXCube)] = { [weak jumpXCube] in
                guard let jumpXCube else { return }
                toggle(jumpXCube, component: JumpXComponent(height: 0.2, speed: 4, phase: 0, origin: jumpXCube.position.x))
            }
            attachLabel(to: jumpXCube, text: "JumpXComponent")
            anchor.addChild(jumpXCube)

            // JumpZ component example.
            let jumpZCube = makeCube()
            jumpZCube.position = nextPosition()
            toggles[ObjectIdentifier(jumpZCube)] = { [weak jumpZCube] in
                guard let jumpZCube else { return }
                toggle(jumpZCube, component: JumpZComponent(height: 0.2, speed: 4, phase: 0, origin: jumpZCube.position.z))
            }
            attachLabel(to: jumpZCube, text: "JumpZComponent")
            anchor.addChild(jumpZCube)

            // SlideY component example.
            let slideYCube = makeCube()
            slideYCube.position = nextPosition()
            toggles[ObjectIdentifier(slideYCube)] = { [weak slideYCube] in
                guard let slideYCube else { return }
                toggle(slideYCube, component: SlideYComponent(speed: 0.2, length: 0.3, position: 0, forward: true))
            }
            attachLabel(to: slideYCube, text: "SlideYComponent")
            anchor.addChild(slideYCube)

            // SlideZ component example.
            let slideZCube = makeCube()
            slideZCube.position = nextPosition()
            toggles[ObjectIdentifier(slideZCube)] = { [weak slideZCube] in
                guard let slideZCube else { return }
                toggle(slideZCube, component: SlideZComponent(speed: 0.2, length: 0.3, position: 0, forward: true))
            }
            attachLabel(to: slideZCube, text: "SlideZComponent")
            anchor.addChild(slideZCube)

            // PulseWidth component example.
            let pulseWidthCube = makeCube()
            pulseWidthCube.position = nextPosition()
            toggles[ObjectIdentifier(pulseWidthCube)] = { [weak pulseWidthCube] in
                guard let pulseWidthCube else { return }
                toggle(pulseWidthCube, component: PulseWidthComponent(amplitude: 0.2, speed: 2, phase: 0))
            }
            attachLabel(to: pulseWidthCube, text: "PulseWidthComponent")
            anchor.addChild(pulseWidthCube)

            // PulseHeight component example.
            let pulseHeightCube = makeCube()
            pulseHeightCube.position = nextPosition()
            toggles[ObjectIdentifier(pulseHeightCube)] = { [weak pulseHeightCube] in
                guard let pulseHeightCube else { return }
                toggle(pulseHeightCube, component: PulseHeightComponent(amplitude: 0.2, speed: 2, phase: 0))
            }
            attachLabel(to: pulseHeightCube, text: "PulseHeightComponent")
            anchor.addChild(pulseHeightCube)

            // PulseDepth component example.
            let pulseDepthCube = makeCube()
            pulseDepthCube.position = nextPosition()
            toggles[ObjectIdentifier(pulseDepthCube)] = { [weak pulseDepthCube] in
                guard let pulseDepthCube else { return }
                toggle(pulseDepthCube, component: PulseDepthComponent(amplitude: 0.2, speed: 2, phase: 0))
            }
            attachLabel(to: pulseDepthCube, text: "PulseDepthComponent")
            anchor.addChild(pulseDepthCube)

            // OrbitX component example.
            let orbitXCube = makeCube()
            orbitXCube.position = nextPosition()
            toggles[ObjectIdentifier(orbitXCube)] = { [weak orbitXCube] in
                guard let orbitXCube else { return }
                toggle(orbitXCube, component: OrbitXComponent(center: orbitXCube.position, radius: 0.2, speed: 2, angle: 0))
            }
            attachLabel(to: orbitXCube, text: "OrbitXComponent")
            anchor.addChild(orbitXCube)

            // HitHighlight component example.
            let hitCube = makeCube()
            hitCube.position = nextPosition()
            hitCube.components.set(CollisionComponent(shapes: [.generateBox(size: [10, 0.1, 10])]))
            toggles[ObjectIdentifier(hitCube)] = { [weak hitCube] in
                guard let hitCube else { return }
                toggle(hitCube, component: HitHighlightComponent())
            }
            attachLabel(to: hitCube, text: "HitHighlightComponent")
            anchor.addChild(hitCube)

            // ProximityDetector component example.
            let proximityCube = makeCube()
            proximityCube.position = nextPosition()
            toggles[ObjectIdentifier(proximityCube)] = { [weak proximityCube] in
                guard let proximityCube else { return }
                toggle(proximityCube, component: ProximityDetectorComponent(radius: 0.4))
            }
            attachLabel(to: proximityCube, text: "ProximityDetectorComponent")
            anchor.addChild(proximityCube)

            // BoundaryEnforcer component example.
            let boundaryCube = makeCube()
            boundaryCube.position = nextPosition()
            boundaryCube.components.set(MoveComponent(velocity: [0.2,0,0]))
            toggles[ObjectIdentifier(boundaryCube)] = { [weak boundaryCube] in
                guard let boundaryCube else { return }
                toggle(boundaryCube, component: BoundaryEnforcerComponent(minBounds: [-1,-1,-1], maxBounds: [1,1,-0.5]))
            }
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

