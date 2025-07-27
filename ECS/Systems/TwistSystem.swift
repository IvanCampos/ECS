import RealityKit
import simd

class TwistSystem: System {
    private static let query = EntityQuery(where: .has(TwistComponent.self))

    required init(scene: Scene) { }

    func update(context: SceneUpdateContext) {
        let dt = Float(context.deltaTime)
        for entity in context.entities(matching: Self.query, updatingSystemWhen: .rendering) {
            if let twist = entity.components[TwistComponent.self] {
                let q = simd_quatf(angle: twist.speed * dt, axis: twist.axis)
                entity.orientation = simd_normalize(q * entity.orientation)
            }
        }
    }
}
