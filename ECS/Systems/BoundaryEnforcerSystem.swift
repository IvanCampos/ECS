import RealityKit
import simd

class BoundaryEnforcerSystem: System {
    private static let query = EntityQuery(where: .has(BoundaryEnforcerComponent.self))

    required init(scene: RealityKit.Scene) { }

    func update(context: SceneUpdateContext) {
        for entity in context.entities(matching: Self.query, updatingSystemWhen: .rendering) {
            if let boundary = entity.components[BoundaryEnforcerComponent.self] {
                var pos = entity.position
                pos.x = min(max(pos.x, boundary.minBounds.x), boundary.maxBounds.x)
                pos.y = min(max(pos.y, boundary.minBounds.y), boundary.maxBounds.y)
                pos.z = min(max(pos.z, boundary.minBounds.z), boundary.maxBounds.z)
                entity.position = pos
            }
        }
    }
}
