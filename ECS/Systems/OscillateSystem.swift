import RealityKit
import simd

class OscillateSystem: System {
    private static let query = EntityQuery(where: .has(OscillateComponent.self))

    required init(scene: Scene) { }

    func update(context: SceneUpdateContext) {
        let dt = Float(context.deltaTime)
        for entity in context.entities(matching: Self.query, updatingSystemWhen: .rendering) {
            if var osc = entity.components[OscillateComponent.self] {
                osc.phase += osc.speed * dt
                let offset = osc.axis * (sin(osc.phase) * osc.amplitude)
                entity.position += offset * dt
                entity.components.set(osc)
            }
        }
    }
}
