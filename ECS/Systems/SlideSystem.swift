import RealityKit
import simd

class SlideSystem: System {
    private static let query = EntityQuery(where: .has(SlideComponent.self))

    required init(scene: Scene) { }

    func update(context: SceneUpdateContext) {
        let dt = Float(context.deltaTime)
        for entity in context.entities(matching: Self.query, updatingSystemWhen: .rendering) {
            if var slide = entity.components[SlideComponent.self] {
                let dir: Float = slide.forward ? 1 : -1
                slide.position += slide.speed * dt * dir
                if slide.position >= slide.length {
                    slide.position = slide.length
                    slide.forward = false
                } else if slide.position <= 0 {
                    slide.position = 0
                    slide.forward = true
                }
                entity.position += slide.axis * slide.speed * dt * dir
                entity.components.set(slide)
            }
        }
    }
}
