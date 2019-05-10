const Builder = @import("std").build.Builder;

pub fn build(b: *Builder) void {
    const mode = b.standardReleaseOptions();
    const exe = b.addExecutable("gtk-zig-test", "src/main.zig");
    exe.setBuildMode(mode);

    //-lgtk-3 -lgdk-3 -lpangocairo-1.0 -lpango-1.0 -latk-1.0 -lcairo-gobject -lcairo -lgdk_pixbuf-2.0 -lgio-2.0 -lgobject-2.0 -lglib-2.0

    // TODO: call pkg-build
    const to_link = [][]const u8{
        "c",
        "gtk-3",
        "gdk-3",
        "pangocairo-1.0",
        "pango-1.0",
        "atk-1.0",
        //"cairo-object",
        "cairo",
        "gdk_pixbuf-2.0",
        "gio-2.0",
        "gobject-2.0",
        "glib-2.0",
    };

    for (to_link) |lib| {
        exe.linkSystemLibrary(lib);
    }

    const run_cmd = exe.run();

    const run_step = b.step("run", "Run the app");
    run_step.dependOn(&run_cmd.step);

    b.default_step.dependOn(&exe.step);
    b.installArtifact(exe);
}
