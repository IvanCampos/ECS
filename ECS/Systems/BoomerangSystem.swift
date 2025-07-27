import RealityKit
import simd

class BoomerangSystem: System {
    private static let query = EntityQuery(where: .has(BoomerangComponent.self))

    required init(scene: Scene) { }

    func update(context: SceneUpdateContext) {
        let dt = Float(context.deltaTime)
        for entity in context.entities(matching: Self.query, updatingSystemWhen: .rendering) {
            if var comp = entity.components[BoomerangComponent.self] {
                let target = comp.forward ? comp.end : comp.start
                let dir = normalize(target - entity.position)
                entity.position += dir * comp.speed * dt
                if distance(entity.position, target) < 0.01 {
                    comp.forward.toggle()
                }
                entity.components.set(comp)
            }
        }
    }
}
