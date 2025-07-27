import RealityKit
import simd

class BounceTiltSystem: System {
    private static let query = EntityQuery(where: .has(BounceTiltComponent.self))

    required init(scene: Scene) { }

    func update(context: SceneUpdateContext) {
        let dt = Float(context.deltaTime)
        for entity in context.entities(matching: Self.query, updatingSystemWhen: .rendering) {
            if var comp = entity.components[BounceTiltComponent.self] {
                comp.phase += comp.speed * dt
                let offset = sin(comp.phase) * comp.amplitude
                entity.position.y = comp.origin.y + offset
                let q = simd_quatf(angle: offset, axis: [0,0,1])
                entity.orientation = simd_normalize(q * entity.orientation)
                entity.components.set(comp)
            }
        }
    }
}
