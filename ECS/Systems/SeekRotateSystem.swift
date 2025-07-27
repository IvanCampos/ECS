import RealityKit
import simd

class SeekRotateSystem: System {
    private static let query = EntityQuery(where: .has(SeekRotateComponent.self))

    required init(scene: Scene) { }

    func update(context: SceneUpdateContext) {
        let dt = Float(context.deltaTime)
        for entity in context.entities(matching: Self.query, updatingSystemWhen: .rendering) {
            if let comp = entity.components[SeekRotateComponent.self] {
                let dir = normalize(comp.target - entity.position)
                entity.position += dir * comp.moveSpeed * dt
                let q = simd_quatf(angle: comp.rotateSpeed * dt, axis: [0,1,0])
                entity.orientation = simd_normalize(q * entity.orientation)
            }
        }
    }
}
