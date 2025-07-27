import RealityKit
import simd

class BobRotateSystem: System {
    private static let query = EntityQuery(where: .has(BobRotateComponent.self))

    required init(scene: Scene) { }

    func update(context: SceneUpdateContext) {
        let dt = Float(context.deltaTime)
        for entity in context.entities(matching: Self.query, updatingSystemWhen: .rendering) {
            if var comp = entity.components[BobRotateComponent.self] {
                comp.phase += comp.speed * dt
                entity.position.y = comp.origin + sin(comp.phase) * comp.amplitude
                let q = simd_quatf(angle: comp.rotateSpeed * dt, axis: [0, 1, 0])
                entity.orientation = simd_normalize(q * entity.orientation)
                entity.components.set(comp)
            }
        }
    }
}
