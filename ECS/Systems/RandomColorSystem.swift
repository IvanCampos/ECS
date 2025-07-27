import RealityKit
import SwiftUI

class RandomColorSystem: System {
    private static let query = EntityQuery(where: .has(RandomColorComponent.self) && .has(ModelComponent.self))

    required init(scene: Scene) { }

    func update(context: SceneUpdateContext) {
        for entity in context.entities(matching: Self.query, updatingSystemWhen: .rendering) {
            if var comp = entity.components[RandomColorComponent.self], var model = entity.components[ModelComponent.self] {
                comp.timer += context.deltaTime
                if comp.timer >= comp.interval {
                    comp.timer = 0
                    let color = UIColor(
                        red: CGFloat.random(in: 0...1),
                        green: CGFloat.random(in: 0...1),
                        blue: CGFloat.random(in: 0...1),
                        alpha: 1
                    )
                    model.materials = [SimpleMaterial(color: color, isMetallic: false)]
                }
                entity.components.set(model)
                entity.components.set(comp)
            }
        }
    }
}
