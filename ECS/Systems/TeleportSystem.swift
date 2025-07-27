import RealityKit
import simd

class TeleportSystem: System {
    private static let query = EntityQuery(where: .has(TeleportComponent.self))

    required init(scene: Scene) { }

    func update(context: SceneUpdateContext) {
        for entity in context.entities(matching: Self.query, updatingSystemWhen: .rendering) {
            if var comp = entity.components[TeleportComponent.self] {
                comp.timer += context.deltaTime
                if comp.timer >= comp.interval {
                    comp.timer = 0
                    let offset = SIMD3<Float>(
                        Float.random(in: -comp.range...comp.range),
                        Float.random(in: -comp.range...comp.range),
                        Float.random(in: -comp.range...comp.range)
                    )
                    entity.position += offset
                }
                entity.components.set(comp)
            }
        }
    }
}
