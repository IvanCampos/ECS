import RealityKit
import simd

class ProximityDetectorSystem: System {
    private static let query = EntityQuery(where: .has(ProximityDetectorComponent.self))
    private static let targets = EntityQuery(where: .has(ModelComponent.self))

    required init(scene: RealityKit.Scene) { }

    func update(context: SceneUpdateContext) {
        for entity in context.entities(matching: Self.query, updatingSystemWhen: .rendering) {
            if var comp = entity.components[ProximityDetectorComponent.self] {
                var triggered = false
                for other in context.entities(matching: Self.targets, updatingSystemWhen: .rendering) {
                    if other.id == entity.id { continue }
                    if distance(entity.position, other.position) < comp.radius {
                        triggered = true
                        break
                    }
                }
                comp.isTriggered = triggered
                entity.components.set(comp)
            }
        }
    }
}
