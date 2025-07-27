import RealityKit
import simd

class OrbitSystem: System {
    private static let query = EntityQuery(where: .has(OrbitComponent.self))

    required init(scene: Scene) { }

    func update(context: SceneUpdateContext) {
        let dt = Float(context.deltaTime)
        for entity in context.entities(matching: Self.query, updatingSystemWhen: .rendering) {
            if let orbit = entity.components[OrbitComponent.self] {
                let offset = entity.position - orbit.center
                let q = simd_quatf(angle: orbit.speed * dt, axis: orbit.axis)
                entity.position = orbit.center + q.act(offset)
            }
        }
    }
}
