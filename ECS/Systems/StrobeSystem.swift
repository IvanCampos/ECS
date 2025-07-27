import RealityKit
import SwiftUI

class StrobeSystem: System {
    private static let query = EntityQuery(where: .has(StrobeComponent.self) && .has(ModelComponent.self))

    required init(scene: Scene) { }

    func update(context: SceneUpdateContext) {
        for entity in context.entities(matching: Self.query, updatingSystemWhen: .rendering) {
            if var strobe = entity.components[StrobeComponent.self], var model = entity.components[ModelComponent.self] {
                strobe.timer += context.deltaTime
                if strobe.timer >= strobe.interval {
                    strobe.timer = 0
                    strobe.useA.toggle()
                }
                let color = strobe.useA ? strobe.colorA : strobe.colorB
                let mat = SimpleMaterial(color: UIColor(color), isMetallic: false)
                model.materials = [mat]
                entity.components.set(model)
                entity.components.set(strobe)
            }
        }
    }
}
