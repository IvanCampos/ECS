import RealityKit
import simd

class OrbitTiltSystem: System {
    private static let query = EntityQuery(where: .has(OrbitTiltComponent.self))

    required init(scene: Scene) { }

    func update(context: SceneUpdateContext) {
        let dt = Float(context.deltaTime)
        for entity in context.entities(matching: Self.query, updatingSystemWhen: .rendering) {
            if var comp = entity.components[OrbitTiltComponent.self] {
                comp.angle += comp.speed * dt
                entity.position.x = comp.center.x + cos(comp.angle) * comp.radius
                entity.position.z = comp.center.z + sin(comp.angle) * comp.radius
                let angle = sin(comp.angle) * comp.tiltAmplitude
                let q = simd_quatf(angle: angle, axis: [0, 0, 1])
                entity.orientation = simd_normalize(q)
                entity.components.set(comp)
            }
        }
    }
}
