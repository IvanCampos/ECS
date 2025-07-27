import RealityKit
import simd

class ZigZagSystem: System {
    private static let query = EntityQuery(where: .has(ZigZagComponent.self))

    required init(scene: Scene) { }

    func update(context: SceneUpdateContext) {
        let dt = Float(context.deltaTime)
        for entity in context.entities(matching: Self.query, updatingSystemWhen: .rendering) {
            if var zigzag = entity.components[ZigZagComponent.self] {
                let dir: Float = zigzag.forward ? 1 : -1
                zigzag.position += zigzag.speed * dt * dir
                if abs(zigzag.position) >= zigzag.length {
                    zigzag.forward.toggle()
                }
                entity.position += zigzag.axis * zigzag.speed * dt * dir
                entity.components.set(zigzag)
            }
        }
    }
}
