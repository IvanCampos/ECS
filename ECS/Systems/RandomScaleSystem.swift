import RealityKit

class RandomScaleSystem: System {
    private static let query = EntityQuery(where: .has(RandomScaleComponent.self))

    required init(scene: Scene) { }

    func update(context: SceneUpdateContext) {
        for entity in context.entities(matching: Self.query, updatingSystemWhen: .rendering) {
            if let comp = entity.components[RandomScaleComponent.self] {
                let factor = 1 + Float.random(in: -comp.range...comp.range)
                entity.scale = SIMD3<Float>(repeating: factor)
            }
        }
    }
}
