# Entity Component System



https://github.com/user-attachments/assets/4157e76d-e3a4-4f8e-90a1-154af8d5f121



| ENTITY | COMPONENT | SYSTEM |
|--------|-----------|--------|
| Lightweight identifier | Describes one aspect of an entity | Applies behavior across multiple entities with particular components |
| Can be composed at run-time by added/removing components | Render or give entity behavior by attaching components | Operate on sets of components |
| Any object in a RealityKit scene must be a subclass of Entity | Nearly all Entity state is stored here | Process contiguous component data and avoid per-entity method calls |
| **Containers** that do not do anything by themselves | Modular data structure that holds state for one aspect of an entity | Encapsulates behavior that run on every frame |
| ModelEntity for 3D Models is essentially an Entity with certain properties already attached | Identify which systems should act on an entity and maintain per-entity state | System’s update(context:) method runs once per frame for every active scene |
| Can only hold **one** copy of each component type | Just data that conforms to Component protocol | Contains logic that reads and writes component data, updating entities based on the current state of the scene |
| Must be added to a RealityView or an anchor to be rendered | A component added to an entity makes the entity eligible to be processed by systems that depend on that component | Instead of writing methods on every entity, systems operate on sets of entities matching a query; thus, avoiding duplicate logic and improving performance |
| Since they are containers, a complex object can be created by assembling multiple child entities, each with its own components and animations | | To implement: conform the System protocol and implement two methods: init(scene:) and update(context:) where you perform per-frame updates |
| To query entities, create a QueryPredicate with your criteria and pass it to an EntityQuery | | Should be lightweight; avoid performing heavy operations in update(context:) because it runs **every frame** |
| | | Registered using registerSystem(); can be ordered if system depends on another system’s results using dependencies:[] |

## System/Component Pairs
### Color and Visual Effects
| Component | System |
| --- | --- |
| [BlinkComponent](https://github.com/IvanCampos/ECS/blob/main/ECS/Components/BlinkComponent.swift) | [BlinkSystem](https://github.com/IvanCampos/ECS/blob/main/ECS/Systems/BlinkSystem.swift) |
| [BlinkColorComponent](https://github.com/IvanCampos/ECS/blob/main/ECS/Components/BlinkColorComponent.swift) | [BlinkColorSystem](https://github.com/IvanCampos/ECS/blob/main/ECS/Systems/BlinkColorSystem.swift) |
| [ColorComponent](https://github.com/IvanCampos/ECS/blob/main/ECS/Components/ColorComponent.swift) | [ColorSystem](https://github.com/IvanCampos/ECS/blob/main/ECS/Systems/ColorSystem.swift) |
| [ColorCycleComponent](https://github.com/IvanCampos/ECS/blob/main/ECS/Components/ColorCycleComponent.swift) | [ColorCycleSystem](https://github.com/IvanCampos/ECS/blob/main/ECS/Systems/ColorCycleSystem.swift) |
| [ColorRiseComponent](https://github.com/IvanCampos/ECS/blob/main/ECS/Components/ColorRiseComponent.swift) | [ColorRiseSystem](https://github.com/IvanCampos/ECS/blob/main/ECS/Systems/ColorRiseSystem.swift) |
| [DriftColorComponent](https://github.com/IvanCampos/ECS/blob/main/ECS/Components/DriftColorComponent.swift) | [DriftColorSystem](https://github.com/IvanCampos/ECS/blob/main/ECS/Systems/DriftColorSystem.swift) |
| [FadeComponent](https://github.com/IvanCampos/ECS/blob/main/ECS/Components/FadeComponent.swift) | [FadeSystem](https://github.com/IvanCampos/ECS/blob/main/ECS/Systems/FadeSystem.swift) |
| [FadeColorComponent](https://github.com/IvanCampos/ECS/blob/main/ECS/Components/FadeColorComponent.swift) | [FadeColorSystem](https://github.com/IvanCampos/ECS/blob/main/ECS/Systems/FadeColorSystem.swift) |
| [FlashColorComponent](https://github.com/IvanCampos/ECS/blob/main/ECS/Components/FlashColorComponent.swift) | [FlashColorSystem](https://github.com/IvanCampos/ECS/blob/main/ECS/Systems/FlashColorSystem.swift) |
| [FlashScaleComponent](https://github.com/IvanCampos/ECS/blob/main/ECS/Components/FlashScaleComponent.swift) | [FlashScaleSystem](https://github.com/IvanCampos/ECS/blob/main/ECS/Systems/FlashScaleSystem.swift) |
| [FlickerComponent](https://github.com/IvanCampos/ECS/blob/main/ECS/Components/FlickerComponent.swift) | [FlickerSystem](https://github.com/IvanCampos/ECS/blob/main/ECS/Systems/FlickerSystem.swift) |
| [GlowComponent](https://github.com/IvanCampos/ECS/blob/main/ECS/Components/GlowComponent.swift) | [GlowSystem](https://github.com/IvanCampos/ECS/blob/main/ECS/Systems/GlowSystem.swift) |
| [GrowFadeComponent](https://github.com/IvanCampos/ECS/blob/main/ECS/Components/GrowFadeComponent.swift) | [GrowFadeSystem](https://github.com/IvanCampos/ECS/blob/main/ECS/Systems/GrowFadeSystem.swift) |
| [OrbitColorComponent](https://github.com/IvanCampos/ECS/blob/main/ECS/Components/OrbitColorComponent.swift) | [OrbitColorSystem](https://github.com/IvanCampos/ECS/blob/main/ECS/Systems/OrbitColorSystem.swift) |
| [PulseComponent](https://github.com/IvanCampos/ECS/blob/main/ECS/Components/PulseComponent.swift) | [PulseSystem](https://github.com/IvanCampos/ECS/blob/main/ECS/Systems/PulseSystem.swift) |
| [PulseColorComponent](https://github.com/IvanCampos/ECS/blob/main/ECS/Components/PulseColorComponent.swift) | [PulseColorSystem](https://github.com/IvanCampos/ECS/blob/main/ECS/Systems/PulseColorSystem.swift) |
| [PulseColorScaleComponent](https://github.com/IvanCampos/ECS/blob/main/ECS/Components/PulseColorScaleComponent.swift) | [PulseColorScaleSystem](https://github.com/IvanCampos/ECS/blob/main/ECS/Systems/PulseColorScaleSystem.swift) |
| [PulseDepthComponent](https://github.com/IvanCampos/ECS/blob/main/ECS/Components/PulseDepthComponent.swift) | [PulseDepthSystem](https://github.com/IvanCampos/ECS/blob/main/ECS/Systems/PulseDepthSystem.swift) |
| [PulseHeightComponent](https://github.com/IvanCampos/ECS/blob/main/ECS/Components/PulseHeightComponent.swift) | [PulseHeightSystem](https://github.com/IvanCampos/ECS/blob/main/ECS/Systems/PulseHeightSystem.swift) |
| [PulseOpacityComponent](https://github.com/IvanCampos/ECS/blob/main/ECS/Components/PulseOpacityComponent.swift) | [PulseOpacitySystem](https://github.com/IvanCampos/ECS/blob/main/ECS/Systems/PulseOpacitySystem.swift) |
| [PulseRotationComponent](https://github.com/IvanCampos/ECS/blob/main/ECS/Components/PulseRotationComponent.swift) | [PulseRotationSystem](https://github.com/IvanCampos/ECS/blob/main/ECS/Systems/PulseRotationSystem.swift) |
| [PulseScaleComponent](https://github.com/IvanCampos/ECS/blob/main/ECS/Components/PulseScaleComponent.swift) | [PulseScaleSystem](https://github.com/IvanCampos/ECS/blob/main/ECS/Systems/PulseScaleSystem.swift) |
| [PulseWidthComponent](https://github.com/IvanCampos/ECS/blob/main/ECS/Components/PulseWidthComponent.swift) | [PulseWidthSystem](https://github.com/IvanCampos/ECS/blob/main/ECS/Systems/PulseWidthSystem.swift) |
| [RandomColorComponent](https://github.com/IvanCampos/ECS/blob/main/ECS/Components/RandomColorComponent.swift) | [RandomColorSystem](https://github.com/IvanCampos/ECS/blob/main/ECS/Systems/RandomColorSystem.swift) |
| [ShimmerComponent](https://github.com/IvanCampos/ECS/blob/main/ECS/Components/ShimmerComponent.swift) | [ShimmerSystem](https://github.com/IvanCampos/ECS/blob/main/ECS/Systems/ShimmerSystem.swift) |
| [SpinColorComponent](https://github.com/IvanCampos/ECS/blob/main/ECS/Components/SpinColorComponent.swift) | [SpinColorSystem](https://github.com/IvanCampos/ECS/blob/main/ECS/Systems/SpinColorSystem.swift) |
| [StrobeComponent](https://github.com/IvanCampos/ECS/blob/main/ECS/Components/StrobeComponent.swift) | [StrobeSystem](https://github.com/IvanCampos/ECS/blob/main/ECS/Systems/StrobeSystem.swift) |
| [TwinkleComponent](https://github.com/IvanCampos/ECS/blob/main/ECS/Components/TwinkleComponent.swift) | [TwinkleSystem](https://github.com/IvanCampos/ECS/blob/main/ECS/Systems/TwinkleSystem.swift) |

### Forces and Interaction
| Component | System |
| --- | --- |
| [GravityComponent](https://github.com/IvanCampos/ECS/blob/main/ECS/Components/GravityComponent.swift) | [GravitySystem](https://github.com/IvanCampos/ECS/blob/main/ECS/Systems/GravitySystem.swift) |
| [MagnetComponent](https://github.com/IvanCampos/ECS/blob/main/ECS/Components/MagnetComponent.swift) | [MagnetSystem](https://github.com/IvanCampos/ECS/blob/main/ECS/Systems/MagnetSystem.swift) |
| [ProximityDetectorComponent](https://github.com/IvanCampos/ECS/blob/main/ECS/Components/ProximityDetectorComponent.swift) | [ProximityDetectorSystem](https://github.com/IvanCampos/ECS/blob/main/ECS/Systems/ProximityDetectorSystem.swift) |
| [RepelComponent](https://github.com/IvanCampos/ECS/blob/main/ECS/Components/RepelComponent.swift) | [RepelSystem](https://github.com/IvanCampos/ECS/blob/main/ECS/Systems/RepelSystem.swift) |

### Lifecycle
| Component | System |
| --- | --- |
| [ExpireComponent](https://github.com/IvanCampos/ECS/blob/main/ECS/Components/ExpireComponent.swift) | [ExpireSystem](https://github.com/IvanCampos/ECS/blob/main/ECS/Systems/ExpireSystem.swift) |
| [LifetimeComponent](https://github.com/IvanCampos/ECS/blob/main/ECS/Components/LifetimeComponent.swift) | [LifetimeSystem](https://github.com/IvanCampos/ECS/blob/main/ECS/Systems/LifetimeSystem.swift) |

### Movement
| Component | System |
| --- | --- |
| [BeelineComponent](https://github.com/IvanCampos/ECS/blob/main/ECS/Components/BeelineComponent.swift) | [BeelineSystem](https://github.com/IvanCampos/ECS/blob/main/ECS/Systems/BeelineSystem.swift) |
| [BobComponent](https://github.com/IvanCampos/ECS/blob/main/ECS/Components/BobComponent.swift) | [BobSystem](https://github.com/IvanCampos/ECS/blob/main/ECS/Systems/BobSystem.swift) |
| [BoomerangComponent](https://github.com/IvanCampos/ECS/blob/main/ECS/Components/BoomerangComponent.swift) | [BoomerangSystem](https://github.com/IvanCampos/ECS/blob/main/ECS/Systems/BoomerangSystem.swift) |
| [BounceComponent](https://github.com/IvanCampos/ECS/blob/main/ECS/Components/BounceComponent.swift) | [BounceSystem](https://github.com/IvanCampos/ECS/blob/main/ECS/Systems/BounceSystem.swift) |
| [BounceXComponent](https://github.com/IvanCampos/ECS/blob/main/ECS/Components/BounceXComponent.swift) | [BounceXSystem](https://github.com/IvanCampos/ECS/blob/main/ECS/Systems/BounceXSystem.swift) |
| [BounceZComponent](https://github.com/IvanCampos/ECS/blob/main/ECS/Components/BounceZComponent.swift) | [BounceZSystem](https://github.com/IvanCampos/ECS/blob/main/ECS/Systems/BounceZSystem.swift) |
| [DiagonalDriftComponent](https://github.com/IvanCampos/ECS/blob/main/ECS/Components/DiagonalDriftComponent.swift) | [DiagonalDriftSystem](https://github.com/IvanCampos/ECS/blob/main/ECS/Systems/DiagonalDriftSystem.swift) |
| [DriftComponent](https://github.com/IvanCampos/ECS/blob/main/ECS/Components/DriftComponent.swift) | [DriftSystem](https://github.com/IvanCampos/ECS/blob/main/ECS/Systems/DriftSystem.swift) |
| [GlideComponent](https://github.com/IvanCampos/ECS/blob/main/ECS/Components/GlideComponent.swift) | [GlideSystem](https://github.com/IvanCampos/ECS/blob/main/ECS/Systems/GlideSystem.swift) |
| [JitterComponent](https://github.com/IvanCampos/ECS/blob/main/ECS/Components/JitterComponent.swift) | [JitterSystem](https://github.com/IvanCampos/ECS/blob/main/ECS/Systems/JitterSystem.swift) |
| [JumpComponent](https://github.com/IvanCampos/ECS/blob/main/ECS/Components/JumpComponent.swift) | [JumpSystem](https://github.com/IvanCampos/ECS/blob/main/ECS/Systems/JumpSystem.swift) |
| [JumpXComponent](https://github.com/IvanCampos/ECS/blob/main/ECS/Components/JumpXComponent.swift) | [JumpXSystem](https://github.com/IvanCampos/ECS/blob/main/ECS/Systems/JumpXSystem.swift) |
| [JumpZComponent](https://github.com/IvanCampos/ECS/blob/main/ECS/Components/JumpZComponent.swift) | [JumpZSystem](https://github.com/IvanCampos/ECS/blob/main/ECS/Systems/JumpZSystem.swift) |
| [MoveComponent](https://github.com/IvanCampos/ECS/blob/main/ECS/Components/MoveComponent.swift) | [MoveSystem](https://github.com/IvanCampos/ECS/blob/main/ECS/Systems/MoveSystem.swift) |
| [MoveXComponent](https://github.com/IvanCampos/ECS/blob/main/ECS/Components/MoveXComponent.swift) | [MoveXSystem](https://github.com/IvanCampos/ECS/blob/main/ECS/Systems/MoveXSystem.swift) |
| [MoveYComponent](https://github.com/IvanCampos/ECS/blob/main/ECS/Components/MoveYComponent.swift) | [MoveYSystem](https://github.com/IvanCampos/ECS/blob/main/ECS/Systems/MoveYSystem.swift) |
| [MoveZComponent](https://github.com/IvanCampos/ECS/blob/main/ECS/Components/MoveZComponent.swift) | [MoveZSystem](https://github.com/IvanCampos/ECS/blob/main/ECS/Systems/MoveZSystem.swift) |
| [PathMoveComponent](https://github.com/IvanCampos/ECS/blob/main/ECS/Components/PathMoveComponent.swift) | [PathMoveSystem](https://github.com/IvanCampos/ECS/blob/main/ECS/Systems/PathMoveSystem.swift) |
| [ShakeComponent](https://github.com/IvanCampos/ECS/blob/main/ECS/Components/ShakeComponent.swift) | [ShakeSystem](https://github.com/IvanCampos/ECS/blob/main/ECS/Systems/ShakeSystem.swift) |
| [ShakeRotationComponent](https://github.com/IvanCampos/ECS/blob/main/ECS/Components/ShakeRotationComponent.swift) | [ShakeRotationSystem](https://github.com/IvanCampos/ECS/blob/main/ECS/Systems/ShakeRotationSystem.swift) |
| [SlideComponent](https://github.com/IvanCampos/ECS/blob/main/ECS/Components/SlideComponent.swift) | [SlideSystem](https://github.com/IvanCampos/ECS/blob/main/ECS/Systems/SlideSystem.swift) |
| [SlideYComponent](https://github.com/IvanCampos/ECS/blob/main/ECS/Components/SlideYComponent.swift) | [SlideYSystem](https://github.com/IvanCampos/ECS/blob/main/ECS/Systems/SlideYSystem.swift) |
| [SlideZComponent](https://github.com/IvanCampos/ECS/blob/main/ECS/Components/SlideZComponent.swift) | [SlideZSystem](https://github.com/IvanCampos/ECS/blob/main/ECS/Systems/SlideZSystem.swift) |
| [SpiralComponent](https://github.com/IvanCampos/ECS/blob/main/ECS/Components/SpiralComponent.swift) | [SpiralSystem](https://github.com/IvanCampos/ECS/blob/main/ECS/Systems/SpiralSystem.swift) |
| [SpiralMoveComponent](https://github.com/IvanCampos/ECS/blob/main/ECS/Components/SpiralMoveComponent.swift) | [SpiralMoveSystem](https://github.com/IvanCampos/ECS/blob/main/ECS/Systems/SpiralMoveSystem.swift) |
| [StepMoveComponent](https://github.com/IvanCampos/ECS/blob/main/ECS/Components/StepMoveComponent.swift) | [StepMoveSystem](https://github.com/IvanCampos/ECS/blob/main/ECS/Systems/StepMoveSystem.swift) |
| [TeleportComponent](https://github.com/IvanCampos/ECS/blob/main/ECS/Components/TeleportComponent.swift) | [TeleportSystem](https://github.com/IvanCampos/ECS/blob/main/ECS/Systems/TeleportSystem.swift) |
| [TeleportRandomComponent](https://github.com/IvanCampos/ECS/blob/main/ECS/Components/TeleportRandomComponent.swift) | [TeleportRandomSystem](https://github.com/IvanCampos/ECS/blob/main/ECS/Systems/TeleportRandomSystem.swift) |
| [WanderComponent](https://github.com/IvanCampos/ECS/blob/main/ECS/Components/WanderComponent.swift) | [WanderSystem](https://github.com/IvanCampos/ECS/blob/main/ECS/Systems/WanderSystem.swift) |
| [ZigZagComponent](https://github.com/IvanCampos/ECS/blob/main/ECS/Components/ZigZagComponent.swift) | [ZigZagSystem](https://github.com/IvanCampos/ECS/blob/main/ECS/Systems/ZigZagSystem.swift) |

### Other
| Component | System |
| --- | --- |
| [AlignComponent](https://github.com/IvanCampos/ECS/blob/main/ECS/Components/AlignComponent.swift) | [AlignSystem](https://github.com/IvanCampos/ECS/blob/main/ECS/Systems/AlignSystem.swift) |
| [BoundaryEnforcerComponent](https://github.com/IvanCampos/ECS/blob/main/ECS/Components/BoundaryEnforcerComponent.swift) | [BoundaryEnforcerSystem](https://github.com/IvanCampos/ECS/blob/main/ECS/Systems/BoundaryEnforcerSystem.swift) |
| [ElasticComponent](https://github.com/IvanCampos/ECS/blob/main/ECS/Components/ElasticComponent.swift) | [ElasticSystem](https://github.com/IvanCampos/ECS/blob/main/ECS/Systems/ElasticSystem.swift) |
| [FlipComponent](https://github.com/IvanCampos/ECS/blob/main/ECS/Components/FlipComponent.swift) | [FlipSystem](https://github.com/IvanCampos/ECS/blob/main/ECS/Systems/FlipSystem.swift) |
| [HitHighlightComponent](https://github.com/IvanCampos/ECS/blob/main/ECS/Components/HitHighlightComponent.swift) | [HitHighlightSystem](https://github.com/IvanCampos/ECS/blob/main/ECS/Systems/HitHighlightSystem.swift) |
| [HoverComponent](https://github.com/IvanCampos/ECS/blob/main/ECS/Components/HoverComponent.swift) | [HoverSystem](https://github.com/IvanCampos/ECS/blob/main/ECS/Systems/HoverSystem.swift) |
| [MyComponent](https://github.com/IvanCampos/ECS/blob/main/ECS/Components/MyComponent.swift) | [MySystem](https://github.com/IvanCampos/ECS/blob/main/ECS/Systems/MySystem.swift) |
| [NudgeComponent](https://github.com/IvanCampos/ECS/blob/main/ECS/Components/NudgeComponent.swift) | [NudgeSystem](https://github.com/IvanCampos/ECS/blob/main/ECS/Systems/NudgeSystem.swift) |
| [OscillateComponent](https://github.com/IvanCampos/ECS/blob/main/ECS/Components/OscillateComponent.swift) | [OscillateSystem](https://github.com/IvanCampos/ECS/blob/main/ECS/Systems/OscillateSystem.swift) |
| [PingPongXComponent](https://github.com/IvanCampos/ECS/blob/main/ECS/Components/PingPongXComponent.swift) | [PingPongXSystem](https://github.com/IvanCampos/ECS/blob/main/ECS/Systems/PingPongXSystem.swift) |
| [PingPongYComponent](https://github.com/IvanCampos/ECS/blob/main/ECS/Components/PingPongYComponent.swift) | [PingPongYSystem](https://github.com/IvanCampos/ECS/blob/main/ECS/Systems/PingPongYSystem.swift) |
| [PingPongZComponent](https://github.com/IvanCampos/ECS/blob/main/ECS/Components/PingPongZComponent.swift) | [PingPongZSystem](https://github.com/IvanCampos/ECS/blob/main/ECS/Systems/PingPongZSystem.swift) |
| [RockComponent](https://github.com/IvanCampos/ECS/blob/main/ECS/Components/RockComponent.swift) | [RockSystem](https://github.com/IvanCampos/ECS/blob/main/ECS/Systems/RockSystem.swift) |
| [SeekComponent](https://github.com/IvanCampos/ECS/blob/main/ECS/Components/SeekComponent.swift) | [SeekSystem](https://github.com/IvanCampos/ECS/blob/main/ECS/Systems/SeekSystem.swift) |
| [SnapComponent](https://github.com/IvanCampos/ECS/blob/main/ECS/Components/SnapComponent.swift) | [SnapSystem](https://github.com/IvanCampos/ECS/blob/main/ECS/Systems/SnapSystem.swift) |
| [SwayComponent](https://github.com/IvanCampos/ECS/blob/main/ECS/Components/SwayComponent.swift) | [SwaySystem](https://github.com/IvanCampos/ECS/blob/main/ECS/Systems/SwaySystem.swift) |
| [TransparencyComponent](https://github.com/IvanCampos/ECS/blob/main/ECS/Components/TransparencyComponent.swift) | [TransparencySystem](https://github.com/IvanCampos/ECS/blob/main/ECS/Systems/TransparencySystem.swift) |
| [VibrateComponent](https://github.com/IvanCampos/ECS/blob/main/ECS/Components/VibrateComponent.swift) | [VibrateSystem](https://github.com/IvanCampos/ECS/blob/main/ECS/Systems/VibrateSystem.swift) |
| [WobbleComponent](https://github.com/IvanCampos/ECS/blob/main/ECS/Components/WobbleComponent.swift) | [WobbleSystem](https://github.com/IvanCampos/ECS/blob/main/ECS/Systems/WobbleSystem.swift) |

### Rotation and Orientation
| Component | System |
| --- | --- |
| [BobRotateComponent](https://github.com/IvanCampos/ECS/blob/main/ECS/Components/BobRotateComponent.swift) | [BobRotateSystem](https://github.com/IvanCampos/ECS/blob/main/ECS/Systems/BobRotateSystem.swift) |
| [BounceTiltComponent](https://github.com/IvanCampos/ECS/blob/main/ECS/Components/BounceTiltComponent.swift) | [BounceTiltSystem](https://github.com/IvanCampos/ECS/blob/main/ECS/Systems/BounceTiltSystem.swift) |
| [DriftRotateComponent](https://github.com/IvanCampos/ECS/blob/main/ECS/Components/DriftRotateComponent.swift) | [DriftRotateSystem](https://github.com/IvanCampos/ECS/blob/main/ECS/Systems/DriftRotateSystem.swift) |
| [OrbitComponent](https://github.com/IvanCampos/ECS/blob/main/ECS/Components/OrbitComponent.swift) | [OrbitSystem](https://github.com/IvanCampos/ECS/blob/main/ECS/Systems/OrbitSystem.swift) |
| [OrbitTiltComponent](https://github.com/IvanCampos/ECS/blob/main/ECS/Components/OrbitTiltComponent.swift) | [OrbitTiltSystem](https://github.com/IvanCampos/ECS/blob/main/ECS/Systems/OrbitTiltSystem.swift) |
| [OrbitXComponent](https://github.com/IvanCampos/ECS/blob/main/ECS/Components/OrbitXComponent.swift) | [OrbitXSystem](https://github.com/IvanCampos/ECS/blob/main/ECS/Systems/OrbitXSystem.swift) |
| [RollXComponent](https://github.com/IvanCampos/ECS/blob/main/ECS/Components/RollXComponent.swift) | [RollXSystem](https://github.com/IvanCampos/ECS/blob/main/ECS/Systems/RollXSystem.swift) |
| [RollYComponent](https://github.com/IvanCampos/ECS/blob/main/ECS/Components/RollYComponent.swift) | [RollYSystem](https://github.com/IvanCampos/ECS/blob/main/ECS/Systems/RollYSystem.swift) |
| [RollZComponent](https://github.com/IvanCampos/ECS/blob/main/ECS/Components/RollZComponent.swift) | [RollZSystem](https://github.com/IvanCampos/ECS/blob/main/ECS/Systems/RollZSystem.swift) |
| [RotateComponent](https://github.com/IvanCampos/ECS/blob/main/ECS/Components/RotateComponent.swift) | [RotateSystem](https://github.com/IvanCampos/ECS/blob/main/ECS/Systems/RotateSystem.swift) |
| [SeekRotateComponent](https://github.com/IvanCampos/ECS/blob/main/ECS/Components/SeekRotateComponent.swift) | [SeekRotateSystem](https://github.com/IvanCampos/ECS/blob/main/ECS/Systems/SeekRotateSystem.swift) |
| [SlideTiltComponent](https://github.com/IvanCampos/ECS/blob/main/ECS/Components/SlideTiltComponent.swift) | [SlideTiltSystem](https://github.com/IvanCampos/ECS/blob/main/ECS/Systems/SlideTiltSystem.swift) |
| [SpinComponent](https://github.com/IvanCampos/ECS/blob/main/ECS/Components/SpinComponent.swift) | [SpinSystem](https://github.com/IvanCampos/ECS/blob/main/ECS/Systems/SpinSystem.swift) |
| [TiltComponent](https://github.com/IvanCampos/ECS/blob/main/ECS/Components/TiltComponent.swift) | [TiltSystem](https://github.com/IvanCampos/ECS/blob/main/ECS/Systems/TiltSystem.swift) |
| [TiltRandomComponent](https://github.com/IvanCampos/ECS/blob/main/ECS/Components/TiltRandomComponent.swift) | [TiltRandomSystem](https://github.com/IvanCampos/ECS/blob/main/ECS/Systems/TiltRandomSystem.swift) |
| [TiltXComponent](https://github.com/IvanCampos/ECS/blob/main/ECS/Components/TiltXComponent.swift) | [TiltXSystem](https://github.com/IvanCampos/ECS/blob/main/ECS/Systems/TiltXSystem.swift) |
| [TiltYComponent](https://github.com/IvanCampos/ECS/blob/main/ECS/Components/TiltYComponent.swift) | [TiltYSystem](https://github.com/IvanCampos/ECS/blob/main/ECS/Systems/TiltYSystem.swift) |
| [TiltZComponent](https://github.com/IvanCampos/ECS/blob/main/ECS/Components/TiltZComponent.swift) | [TiltZSystem](https://github.com/IvanCampos/ECS/blob/main/ECS/Systems/TiltZSystem.swift) |
| [TwistComponent](https://github.com/IvanCampos/ECS/blob/main/ECS/Components/TwistComponent.swift) | [TwistSystem](https://github.com/IvanCampos/ECS/blob/main/ECS/Systems/TwistSystem.swift) |

### Scaling
| Component | System |
| --- | --- |
| [BounceScaleComponent](https://github.com/IvanCampos/ECS/blob/main/ECS/Components/BounceScaleComponent.swift) | [BounceScaleSystem](https://github.com/IvanCampos/ECS/blob/main/ECS/Systems/BounceScaleSystem.swift) |
| [GrowComponent](https://github.com/IvanCampos/ECS/blob/main/ECS/Components/GrowComponent.swift) | [GrowSystem](https://github.com/IvanCampos/ECS/blob/main/ECS/Systems/GrowSystem.swift) |
| [OrbitScaleComponent](https://github.com/IvanCampos/ECS/blob/main/ECS/Components/OrbitScaleComponent.swift) | [OrbitScaleSystem](https://github.com/IvanCampos/ECS/blob/main/ECS/Systems/OrbitScaleSystem.swift) |
| [RandomScaleComponent](https://github.com/IvanCampos/ECS/blob/main/ECS/Components/RandomScaleComponent.swift) | [RandomScaleSystem](https://github.com/IvanCampos/ECS/blob/main/ECS/Systems/RandomScaleSystem.swift) |
| [ScaleComponent](https://github.com/IvanCampos/ECS/blob/main/ECS/Components/ScaleComponent.swift) | [ScaleSystem](https://github.com/IvanCampos/ECS/blob/main/ECS/Systems/ScaleSystem.swift) |
| [ScaleXComponent](https://github.com/IvanCampos/ECS/blob/main/ECS/Components/ScaleXComponent.swift) | [ScaleXSystem](https://github.com/IvanCampos/ECS/blob/main/ECS/Systems/ScaleXSystem.swift) |
| [ScaleYComponent](https://github.com/IvanCampos/ECS/blob/main/ECS/Components/ScaleYComponent.swift) | [ScaleYSystem](https://github.com/IvanCampos/ECS/blob/main/ECS/Systems/ScaleYSystem.swift) |
| [ScaleZComponent](https://github.com/IvanCampos/ECS/blob/main/ECS/Components/ScaleZComponent.swift) | [ScaleZSystem](https://github.com/IvanCampos/ECS/blob/main/ECS/Systems/ScaleZSystem.swift) |
| [ShrinkComponent](https://github.com/IvanCampos/ECS/blob/main/ECS/Components/ShrinkComponent.swift) | [ShrinkSystem](https://github.com/IvanCampos/ECS/blob/main/ECS/Systems/ShrinkSystem.swift) |
| [SpinScaleComponent](https://github.com/IvanCampos/ECS/blob/main/ECS/Components/SpinScaleComponent.swift) | [SpinScaleSystem](https://github.com/IvanCampos/ECS/blob/main/ECS/Systems/SpinScaleSystem.swift) |
| [StretchComponent](https://github.com/IvanCampos/ECS/blob/main/ECS/Components/StretchComponent.swift) | [StretchSystem](https://github.com/IvanCampos/ECS/blob/main/ECS/Systems/StretchSystem.swift) |

### Visibility
| Component | System |
| --- | --- |
| [ToggleVisibilityComponent](https://github.com/IvanCampos/ECS/blob/main/ECS/Components/ToggleVisibilityComponent.swift) | [ToggleVisibilitySystem](https://github.com/IvanCampos/ECS/blob/main/ECS/Systems/ToggleVisibilitySystem.swift) |


### Game Mechanics
| Component | System |
| --- | --- |
| [HealthComponent](https://github.com/IvanCampos/ECS/blob/main/ECS/Components/HealthComponent.swift) | [HealthSystem](https://github.com/IvanCampos/ECS/blob/main/ECS/Systems/HealthSystem.swift) |
| [DamageComponent](https://github.com/IvanCampos/ECS/blob/main/ECS/Components/DamageComponent.swift) | [DamageSystem](https://github.com/IvanCampos/ECS/blob/main/ECS/Systems/DamageSystem.swift) |
| [ScoreComponent](https://github.com/IvanCampos/ECS/blob/main/ECS/Components/ScoreComponent.swift) | [ScoreSystem](https://github.com/IvanCampos/ECS/blob/main/ECS/Systems/ScoreSystem.swift) |
| [CollectibleComponent](https://github.com/IvanCampos/ECS/blob/main/ECS/Components/CollectibleComponent.swift) | [CollectibleSystem](https://github.com/IvanCampos/ECS/blob/main/ECS/Systems/CollectibleSystem.swift) |
| [RespawnComponent](https://github.com/IvanCampos/ECS/blob/main/ECS/Components/RespawnComponent.swift) | [RespawnSystem](https://github.com/IvanCampos/ECS/blob/main/ECS/Systems/RespawnSystem.swift) |
| [AmmoComponent](https://github.com/IvanCampos/ECS/blob/main/ECS/Components/AmmoComponent.swift) | [AmmoSystem](https://github.com/IvanCampos/ECS/blob/main/ECS/Systems/AmmoSystem.swift) |
| [FireRateComponent](https://github.com/IvanCampos/ECS/blob/main/ECS/Components/FireRateComponent.swift) | [FireRateSystem](https://github.com/IvanCampos/ECS/blob/main/ECS/Systems/FireRateSystem.swift) |
| [StaminaComponent](https://github.com/IvanCampos/ECS/blob/main/ECS/Components/StaminaComponent.swift) | [StaminaSystem](https://github.com/IvanCampos/ECS/blob/main/ECS/Systems/StaminaSystem.swift) |
| [AIBehaviorComponent](https://github.com/IvanCampos/ECS/blob/main/ECS/Components/AIBehaviorComponent.swift) | [AIBehaviorSystem](https://github.com/IvanCampos/ECS/blob/main/ECS/Systems/AIBehaviorSystem.swift) |
| [PathFollowComponent](https://github.com/IvanCampos/ECS/blob/main/ECS/Components/PathFollowComponent.swift) | [PathFollowSystem](https://github.com/IvanCampos/ECS/blob/main/ECS/Systems/PathFollowSystem.swift) |
| [EnemySpawnComponent](https://github.com/IvanCampos/ECS/blob/main/ECS/Components/EnemySpawnComponent.swift) | [EnemySpawnSystem](https://github.com/IvanCampos/ECS/blob/main/ECS/Systems/EnemySpawnSystem.swift) |
| [PickupComponent](https://github.com/IvanCampos/ECS/blob/main/ECS/Components/PickupComponent.swift) | [PickupSystem](https://github.com/IvanCampos/ECS/blob/main/ECS/Systems/PickupSystem.swift) |
| [QuestComponent](https://github.com/IvanCampos/ECS/blob/main/ECS/Components/QuestComponent.swift) | [QuestSystem](https://github.com/IvanCampos/ECS/blob/main/ECS/Systems/QuestSystem.swift) |
| [DialogComponent](https://github.com/IvanCampos/ECS/blob/main/ECS/Components/DialogComponent.swift) | [DialogSystem](https://github.com/IvanCampos/ECS/blob/main/ECS/Systems/DialogSystem.swift) |
| [InputComponent](https://github.com/IvanCampos/ECS/blob/main/ECS/Components/InputComponent.swift) | [InputSystem](https://github.com/IvanCampos/ECS/blob/main/ECS/Systems/InputSystem.swift) |
| [WeaponComponent](https://github.com/IvanCampos/ECS/blob/main/ECS/Components/WeaponComponent.swift) | [WeaponSystem](https://github.com/IvanCampos/ECS/blob/main/ECS/Systems/WeaponSystem.swift) |
| [ShieldComponent](https://github.com/IvanCampos/ECS/blob/main/ECS/Components/ShieldComponent.swift) | [ShieldSystem](https://github.com/IvanCampos/ECS/blob/main/ECS/Systems/ShieldSystem.swift) |
| [DamageOverTimeComponent](https://github.com/IvanCampos/ECS/blob/main/ECS/Components/DamageOverTimeComponent.swift) | [DamageOverTimeSystem](https://github.com/IvanCampos/ECS/blob/main/ECS/Systems/DamageOverTimeSystem.swift) |
| [HealComponent](https://github.com/IvanCampos/ECS/blob/main/ECS/Components/HealComponent.swift) | [HealSystem](https://github.com/IvanCampos/ECS/blob/main/ECS/Systems/HealSystem.swift) |
| [StatusEffectComponent](https://github.com/IvanCampos/ECS/blob/main/ECS/Components/StatusEffectComponent.swift) | [StatusEffectSystem](https://github.com/IvanCampos/ECS/blob/main/ECS/Systems/StatusEffectSystem.swift) |
| [LevelComponent](https://github.com/IvanCampos/ECS/blob/main/ECS/Components/LevelComponent.swift) | [LevelSystem](https://github.com/IvanCampos/ECS/blob/main/ECS/Systems/LevelSystem.swift) |
| [ExperienceComponent](https://github.com/IvanCampos/ECS/blob/main/ECS/Components/ExperienceComponent.swift) | [ExperienceSystem](https://github.com/IvanCampos/ECS/blob/main/ECS/Systems/ExperienceSystem.swift) |
| [CooldownComponent](https://github.com/IvanCampos/ECS/blob/main/ECS/Components/CooldownComponent.swift) | [CooldownSystem](https://github.com/IvanCampos/ECS/blob/main/ECS/Systems/CooldownSystem.swift) |
| [InventoryComponent](https://github.com/IvanCampos/ECS/blob/main/ECS/Components/InventoryComponent.swift) | [InventorySystem](https://github.com/IvanCampos/ECS/blob/main/ECS/Systems/InventorySystem.swift) |
| [InteractionComponent](https://github.com/IvanCampos/ECS/blob/main/ECS/Components/InteractionComponent.swift) | [InteractionSystem](https://github.com/IvanCampos/ECS/blob/main/ECS/Systems/InteractionSystem.swift) |
##  Developer Resources
[Understanding the modular architecture of RealityKit](https://developer.apple.com/documentation/visionos/understanding-the-realitykit-modular-architecture)  
[Implementing systems for entities in a scene](https://developer.apple.com/documentation/RealityKit/implementing-systems-for-entities-in-a-scene)  

## Deep Research (AI) Reports
[Entity Component System (ECS) in RealityKit for visionOS](https://chatgpt.com/s/dr_68a8da6a96288191bfa24722eb63f3d3)  
