import Compute
import Metal
import os

enum HelloWorldDemo: Demo {
    static let source = #"""
        #include <metal_stdlib>
        #include <metal_logging>

        using namespace metal;

        kernel void hello_world() {
            os_log_default.log("Hello world (from Metal!)");
        }
    """#

    static func main() async throws {
        let device = MTLCreateSystemDefaultDevice()!
        let logger = Logger()
        logger.log("Hello world (from Swift!)")
        let compute = try Computer(device: device, logger: logger)
        let library = ShaderLibrary.source(source, enableLogging: true)
        let helloWorld = try compute.makePipeline(function: library.hello_world)
        try compute.run(pipeline: helloWorld, width: 1)
    }
}
