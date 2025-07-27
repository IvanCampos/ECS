import RealityKit
import simd

class TiltRandomSystem: System {
    private static let query = EntityQuery(where: .has(TiltRandomComponent.self))

    required init(scene: Scene) { }

    func update(context: SceneUpdateContext) {
        let dt = Float(context.deltaTime)
        for entity in context.entities(matching: Self.query, updatingSystemWhen: .rendering) {
            if var comp = entity.components[TiltRandomComponent.self] {
                comp.timer += dt
                if comp.timer >= comp.interval {
                    comp.timer = 0
                    let angle = Float.random(in: -comp.amplitude...comp.amplitude)
                    let q = simd_quatf(angle: angle, axis: [0, 0, 1])
                    entity.orientation = q
                }
                entity.components.set(comp)
            }
        }
    }
}
