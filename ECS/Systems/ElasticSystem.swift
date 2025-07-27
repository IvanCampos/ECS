import RealityKit

class ElasticSystem: System {
    private static let query = EntityQuery(where: .has(ElasticComponent.self))

    required init(scene: Scene) { }

    func update(context: SceneUpdateContext) {
        let dt = Float(context.deltaTime)
        for entity in context.entities(matching: Self.query, updatingSystemWhen: .rendering) {
            if var elastic = entity.components[ElasticComponent.self] {
                elastic.phase += elastic.speed * dt
                let scale = 1 + sin(elastic.phase) * elastic.amplitude
                entity.scale = SIMD3<Float>(repeating: scale)
                entity.components.set(elastic)
            }
        }
    }
}
