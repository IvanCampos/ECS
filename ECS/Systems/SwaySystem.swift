import RealityKit
import simd

class SwaySystem: System {
    private static let query = EntityQuery(where: .has(SwayComponent.self))

    required init(scene: Scene) { }

    func update(context: SceneUpdateContext) {
        let dt = Float(context.deltaTime)
        for entity in context.entities(matching: Self.query, updatingSystemWhen: .rendering) {
            if var comp = entity.components[SwayComponent.self] {
                comp.phase += comp.speed * dt
                entity.position.x = comp.origin.x + sin(comp.phase) * comp.amplitudeX
                entity.position.z = comp.origin.z + sin(comp.phase) * comp.amplitudeZ
                entity.components.set(comp)
            }
        }
    }
}
