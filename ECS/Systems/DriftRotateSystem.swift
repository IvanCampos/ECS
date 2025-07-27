import RealityKit
import simd

class DriftRotateSystem: System {
    private static let query = EntityQuery(where: .has(DriftRotateComponent.self))

    required init(scene: Scene) { }

    func update(context: SceneUpdateContext) {
        let dt = Float(context.deltaTime)
        for entity in context.entities(matching: Self.query, updatingSystemWhen: .rendering) {
            if let comp = entity.components[DriftRotateComponent.self] {
                entity.position += comp.velocity * dt
                let q = simd_quatf(angle: comp.rotationSpeed * dt, axis: [0, 1, 0])
                entity.orientation = simd_normalize(q * entity.orientation)
            }
        }
    }
}
