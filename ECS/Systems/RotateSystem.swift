import RealityKit
import simd

class RotateSystem: System {
    private static let query = EntityQuery(where: .has(RotateComponent.self))

    required init(scene: Scene) { }

    func update(context: SceneUpdateContext) {
        let dt = Float(context.deltaTime)
        for entity in context.entities(matching: Self.query, updatingSystemWhen: .rendering) {
            if var rotate = entity.components[RotateComponent.self] {
                let angle = rotate.speed * dt
                let q = simd_quatf(angle: angle, axis: rotate.axis)
                entity.orientation = simd_normalize(q * entity.orientation)
            }
        }
    }
}
