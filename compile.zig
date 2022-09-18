const std = @import("std");
const imgui_build = @import("vendor/zig-imgui/zig-imgui/imgui_build.zig");
pub fn build(b: *std.build.Builder) void {
    // Standard release options allow the person running `zig build` to select
    // between Debug, ReleaseSafe, ReleaseFast, and ReleaseSmall.
    const mode = b.standardReleaseOptions();
    const target = b.standardTargetOptions(.{});
    const lib = b.addStaticLibrary("zig-imgui-sfml", "src/zig-imgui-sfml.zig");
    lib.setBuildMode(mode);
    lib.setTarget(target);
    lib.linkLibC();
    link(lib);
    lib.install();

    var build_example = b.option(bool, "build-example", "builds example of imgui with sfml") orelse false;
    if (build_example) {
        const example = b.addExecutable("zig-imgui-sfml-example", "example/example.zig");
        example.setBuildMode(mode);
        example.setTarget(target);
        example.linkLibC();
        link(example);
        example.install();
    }

    const main_tests = b.addTest("src/main.zig");
    main_tests.setBuildMode(mode);

    const test_step = b.step("test", "Run library tests");
    test_step.dependOn(&main_tests.step);
}

pub fn link(libExeObj: *std.build.LibExeObjStep) void {
    const libraries_to_link = [_][]const u8{ "csfml-graphics", "csfml-system", "csfml-window" };
    for (libraries_to_link) |v| {
        libExeObj.linkSystemLibrary(v);
    }
    imgui_build.link(libExeObj);
}
