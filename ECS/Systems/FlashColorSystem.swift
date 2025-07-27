import RealityKit
import SwiftUI

class FlashColorSystem: System {
    private static let query = EntityQuery(where: .has(FlashColorComponent.self) && .has(ModelComponent.self))

    required init(scene: Scene) { }

    func update(context: SceneUpdateContext) {
        for entity in context.entities(matching: Self.query, updatingSystemWhen: .rendering) {
            if var flash = entity.components[FlashColorComponent.self], var model = entity.components[ModelComponent.self] {
                flash.timer += context.deltaTime
                if flash.timer >= flash.interval {
                    flash.timer = 0
                    let color = Color(red: .random(in: 0...1), green: .random(in: 0...1), blue: .random(in: 0...1))
                    let mat = SimpleMaterial(color: UIColor(color), isMetallic: false)
                    model.materials = [mat]
                }
                entity.components.set(model)
                entity.components.set(flash)
            }
        }
    }
}
