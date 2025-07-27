import RealityKit
import simd

class GlideSystem: System {
    private static let query = EntityQuery(where: .has(GlideComponent.self))

    required init(scene: Scene) { }

    func update(context: SceneUpdateContext) {
        let dt = Float(context.deltaTime)
        for entity in context.entities(matching: Self.query, updatingSystemWhen: .rendering) {
            if let glide = entity.components[GlideComponent.self] {
                entity.position += glide.velocity * dt
            }
        }
    }
}
