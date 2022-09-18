const fetch = @import("fetch.zig");
const std = @import("std");

const deps = [_]fetch.Dependency{
    .{
        .name = "zig-imgui",
        .vcs = .{
            .git = .{
                .url = "https://github.com/SpexGuy/Zig-ImGui",
                .commit = "0a2cfca89de2ef1ff5a346c6e2c29e8b3347d2e3",
                .recursive = true,
            },
        },
    },
    .{
        .name = "zig-sfml-wrapper",
        .vcs = .{
            .git = .{
                .url = "https://github.com/Guigui220D/zig-sfml-wrapper",
                .commit = "10785bdc1169d7ed0857f34d1bdab708eddfd21a",
            },
        },
    },
};

pub fn build(builder: *std.build.Builder) !void {
    fetch.addOption(builder, bool, "build-example", "builds example of imgui with sfml");
    try fetch.fetchAndBuild(builder, "vendor", &deps, "compile.zig");
}
