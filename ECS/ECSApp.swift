//
//  ECSApp.swift
//  ECS
//
//  Created by IVAN CAMPOS on 7/26/25.
//

import SwiftUI
import RealityKit

@main
struct ECSApp: App {
    
    @State private var appModel = AppModel()
    
    init() {
        MyComponent.registerComponent()
        MySystem.registerSystem()

        MoveComponent.registerComponent()
        MoveSystem.registerSystem()

        ScaleComponent.registerComponent()
        ScaleSystem.registerSystem()

        RotateComponent.registerComponent()
        RotateSystem.registerSystem()

        PulseComponent.registerComponent()
        PulseSystem.registerSystem()

        BlinkComponent.registerComponent()
        BlinkSystem.registerSystem()

        BobComponent.registerComponent()
        BobSystem.registerSystem()

        WanderComponent.registerComponent()
        WanderSystem.registerSystem()

        LifetimeComponent.registerComponent()
        LifetimeSystem.registerSystem()

        GravityComponent.registerComponent()
        GravitySystem.registerSystem()

        ColorComponent.registerComponent()
        ColorSystem.registerSystem()

        FadeComponent.registerComponent()
        FadeSystem.registerSystem()

        OrbitComponent.registerComponent()
        OrbitSystem.registerSystem()

        JitterComponent.registerComponent()
        JitterSystem.registerSystem()

        DriftComponent.registerComponent()
        DriftSystem.registerSystem()

        ElasticComponent.registerComponent()
        ElasticSystem.registerSystem()

        MagnetComponent.registerComponent()
        MagnetSystem.registerSystem()

        RepelComponent.registerComponent()
        RepelSystem.registerSystem()

        StrobeComponent.registerComponent()
        StrobeSystem.registerSystem()

        FlashColorComponent.registerComponent()
        FlashColorSystem.registerSystem()

        GlowComponent.registerComponent()
        GlowSystem.registerSystem()

        SpinComponent.registerComponent()
        SpinSystem.registerSystem()

        TiltComponent.registerComponent()
        TiltSystem.registerSystem()

        PathMoveComponent.registerComponent()
        PathMoveSystem.registerSystem()

        ShrinkComponent.registerComponent()
        ShrinkSystem.registerSystem()

        GrowComponent.registerComponent()
        GrowSystem.registerSystem()

        ExpireComponent.registerComponent()
        ExpireSystem.registerSystem()

        OscillateComponent.registerComponent()
        OscillateSystem.registerSystem()

        SlideComponent.registerComponent()
        SlideSystem.registerSystem()

        VibrateComponent.registerComponent()
        VibrateSystem.registerSystem()

        ShakeComponent.registerComponent()
        ShakeSystem.registerSystem()

        BounceComponent.registerComponent()
        BounceSystem.registerSystem()

        TwistComponent.registerComponent()
        TwistSystem.registerSystem()

        FlipComponent.registerComponent()
        FlipSystem.registerSystem()

        HoverComponent.registerComponent()
        HoverSystem.registerSystem()

        SeekComponent.registerComponent()
        SeekSystem.registerSystem()

        StretchComponent.registerComponent()
        StretchSystem.registerSystem()

        RandomColorComponent.registerComponent()
        RandomColorSystem.registerSystem()

        TeleportComponent.registerComponent()
        TeleportSystem.registerSystem()

        TransparencyComponent.registerComponent()
        TransparencySystem.registerSystem()

        SpiralComponent.registerComponent()
        SpiralSystem.registerSystem()

        PulseColorComponent.registerComponent()
        PulseColorSystem.registerSystem()

        FlickerComponent.registerComponent()
        FlickerSystem.registerSystem()

        SnapComponent.registerComponent()
        SnapSystem.registerSystem()

        BeelineComponent.registerComponent()
        BeelineSystem.registerSystem()

        BoomerangComponent.registerComponent()
        BoomerangSystem.registerSystem()

        TwinkleComponent.registerComponent()
        TwinkleSystem.registerSystem()

        RandomScaleComponent.registerComponent()
        RandomScaleSystem.registerSystem()

        WobbleComponent.registerComponent()
        WobbleSystem.registerSystem()

        AlignComponent.registerComponent()
        AlignSystem.registerSystem()

        ZigZagComponent.registerComponent()
        ZigZagSystem.registerSystem()

        MoveXComponent.registerComponent()
        MoveXSystem.registerSystem()

        MoveYComponent.registerComponent()
        MoveYSystem.registerSystem()

        MoveZComponent.registerComponent()
        MoveZSystem.registerSystem()

        PulseScaleComponent.registerComponent()
        PulseScaleSystem.registerSystem()

        ColorCycleComponent.registerComponent()
        ColorCycleSystem.registerSystem()

        PingPongXComponent.registerComponent()
        PingPongXSystem.registerSystem()

        PingPongYComponent.registerComponent()
        PingPongYSystem.registerSystem()

        PingPongZComponent.registerComponent()
        PingPongZSystem.registerSystem()

        RollXComponent.registerComponent()
        RollXSystem.registerSystem()

        RollZComponent.registerComponent()
        RollZSystem.registerSystem()

        FlashScaleComponent.registerComponent()
        FlashScaleSystem.registerSystem()

        DiagonalDriftComponent.registerComponent()
        DiagonalDriftSystem.registerSystem()

        RockComponent.registerComponent()
        RockSystem.registerSystem()

        ShimmerComponent.registerComponent()
        ShimmerSystem.registerSystem()

        SpiralMoveComponent.registerComponent()
        SpiralMoveSystem.registerSystem()

        TeleportRandomComponent.registerComponent()
        TeleportRandomSystem.registerSystem()

        BlinkColorComponent.registerComponent()
        BlinkColorSystem.registerSystem()

        BounceTiltComponent.registerComponent()
        BounceTiltSystem.registerSystem()

        SeekRotateComponent.registerComponent()
        SeekRotateSystem.registerSystem()

        OrbitScaleComponent.registerComponent()
        OrbitScaleSystem.registerSystem()

        SwayComponent.registerComponent()
        SwaySystem.registerSystem()

        DriftRotateComponent.registerComponent()
        DriftRotateSystem.registerSystem()

        BounceScaleComponent.registerComponent()
        BounceScaleSystem.registerSystem()

        FadeColorComponent.registerComponent()
        FadeColorSystem.registerSystem()

        PulseOpacityComponent.registerComponent()
        PulseOpacitySystem.registerSystem()

        StepMoveComponent.registerComponent()
        StepMoveSystem.registerSystem()

        ShakeRotationComponent.registerComponent()
        ShakeRotationSystem.registerSystem()

        GrowFadeComponent.registerComponent()
        GrowFadeSystem.registerSystem()

        PulseColorScaleComponent.registerComponent()
        PulseColorScaleSystem.registerSystem()

        DriftColorComponent.registerComponent()
        DriftColorSystem.registerSystem()

        OrbitTiltComponent.registerComponent()
        OrbitTiltSystem.registerSystem()

        PulseRotationComponent.registerComponent()
        PulseRotationSystem.registerSystem()

        OrbitColorComponent.registerComponent()
        OrbitColorSystem.registerSystem()

        SlideTiltComponent.registerComponent()
        SlideTiltSystem.registerSystem()

        SpinScaleComponent.registerComponent()
        SpinScaleSystem.registerSystem()

        BobRotateComponent.registerComponent()
        BobRotateSystem.registerSystem()

        TiltRandomComponent.registerComponent()
        TiltRandomSystem.registerSystem()

        ColorRiseComponent.registerComponent()
        ColorRiseSystem.registerSystem()

        JumpComponent.registerComponent()
        JumpSystem.registerSystem()

        NudgeComponent.registerComponent()
        NudgeSystem.registerSystem()

        RollYComponent.registerComponent()
        RollYSystem.registerSystem()

        GlideComponent.registerComponent()
        GlideSystem.registerSystem()

        ToggleVisibilityComponent.registerComponent()
        ToggleVisibilitySystem.registerSystem()

        BounceXComponent.registerComponent()
        BounceXSystem.registerSystem()

        BounceZComponent.registerComponent()
        BounceZSystem.registerSystem()

        SpinColorComponent.registerComponent()
        SpinColorSystem.registerSystem()

        ScaleXComponent.registerComponent()
        ScaleXSystem.registerSystem()

        ScaleYComponent.registerComponent()
        ScaleYSystem.registerSystem()

        ScaleZComponent.registerComponent()
        ScaleZSystem.registerSystem()

        TiltXComponent.registerComponent()
        TiltXSystem.registerSystem()

        TiltYComponent.registerComponent()
        TiltYSystem.registerSystem()

        TiltZComponent.registerComponent()
        TiltZSystem.registerSystem()

        JumpXComponent.registerComponent()
        JumpXSystem.registerSystem()

        JumpZComponent.registerComponent()
        JumpZSystem.registerSystem()

        SlideYComponent.registerComponent()
        SlideYSystem.registerSystem()

        SlideZComponent.registerComponent()
        SlideZSystem.registerSystem()

        PulseWidthComponent.registerComponent()
        PulseWidthSystem.registerSystem()

        PulseHeightComponent.registerComponent()
        PulseHeightSystem.registerSystem()

        PulseDepthComponent.registerComponent()
        PulseDepthSystem.registerSystem()

        OrbitXComponent.registerComponent()
        OrbitXSystem.registerSystem()

        HitHighlightComponent.registerComponent()
        HitHighlightSystem.registerSystem()

        ProximityDetectorComponent.registerComponent()
        ProximityDetectorSystem.registerSystem()

        BoundaryEnforcerComponent.registerComponent()
        BoundaryEnforcerSystem.registerSystem()
    }
    
    var body: some SwiftUI.Scene {
        WindowGroup {
            ContentView()
                .environment(appModel)
        }
        
        ImmersiveSpace(id: appModel.immersiveSpaceID) {
            ImmersiveView()
                .environment(appModel)
                .onAppear {
                    appModel.immersiveSpaceState = .open
                }
                .onDisappear {
                    appModel.immersiveSpaceState = .closed
                }
        }
        .immersionStyle(selection: .constant(.mixed), in: .mixed)
    }
}
