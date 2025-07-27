import RealityKit
import simd

class OrbitXSystem: System {
    private static let query = EntityQuery(where: .has(OrbitXComponent.self))

    required init(scene: Scene) { }

    func update(context: SceneUpdateContext) {
        let dt = Float(context.deltaTime)
        for entity in context.entities(matching: Self.query, updatingSystemWhen: .rendering) {
            if var comp = entity.components[OrbitXComponent.self] {
                comp.angle += comp.speed * dt
                let c = cos(comp.angle)
                let s = sin(comp.angle)
                entity.position = comp.center + [0, c * comp.radius, s * comp.radius]
                entity.components.set(comp)
            }
        }
    }
}
