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

##  Developer Resources
[Understanding the modular architecture of RealityKit](https://developer.apple.com/documentation/visionos/understanding-the-realitykit-modular-architecture)  
[Implementing systems for entities in a scene](https://developer.apple.com/documentation/RealityKit/implementing-systems-for-entities-in-a-scene)  

## Deep Research (AI) Reports
[Entity Component System (ECS) in RealityKit for visionOS](https://chatgpt.com/s/dr_68a8da6a96288191bfa24722eb63f3d3)  
