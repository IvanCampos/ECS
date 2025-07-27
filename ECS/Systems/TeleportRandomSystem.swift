import RealityKit
import simd

class TeleportRandomSystem: System {
    private static let query = EntityQuery(where: .has(TeleportRandomComponent.self))

    required init(scene: Scene) { }

    func update(context: SceneUpdateContext) {
        let dt = Float(context.deltaTime)
        for entity in context.entities(matching: Self.query, updatingSystemWhen: .rendering) {
            if var comp = entity.components[TeleportRandomComponent.self] {
                comp.timer += dt
                if comp.timer >= comp.interval {
                    comp.timer = 0
                    let x = Float.random(in: -comp.range...comp.range)
                    let y = Float.random(in: -comp.range...comp.range)
                    let z = Float.random(in: -comp.range...comp.range)
                    entity.position += [x, y, z]
                }
                entity.components.set(comp)
            }
        }
    }
}
