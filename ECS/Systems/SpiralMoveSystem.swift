import RealityKit
import simd

class SpiralMoveSystem: System {
    private static let query = EntityQuery(where: .has(SpiralMoveComponent.self))

    required init(scene: Scene) { }

    func update(context: SceneUpdateContext) {
        let dt = Float(context.deltaTime)
        for entity in context.entities(matching: Self.query, updatingSystemWhen: .rendering) {
            if var comp = entity.components[SpiralMoveComponent.self] {
                comp.angle += comp.speed * dt
                entity.position.x = comp.center.x + cos(comp.angle) * comp.radius
                entity.position.z = comp.center.z + sin(comp.angle) * comp.radius
                entity.position.y += comp.heightSpeed * dt
                entity.components.set(comp)
            }
        }
    }
}
