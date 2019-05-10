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

    const include_dirs = [][]const u8{
        "/usr/include/gtk-3.0",
        "/usr/include/at-spi2-atk/2.0",
        "/usr/include/at-spi-2.0",
        "/usr/include/dbus-1.0",
        "/usr/lib/dbus-1.0/include",

        "/usr/include/gio-unix-2.0",
        "/usr/include/cairo",
        "/usr/include/harfbuzz",
        "/usr/include/pango-1.0",
        "/usr/include/fribidi",
        "/usr/include/atk-1.0",
        "/usr/include/pixman-1",
        "/usr/include/freetype2",
        "/usr/include/libdrm",
        "/usr/include/libpng16",
        "/usr/include/gdk-pixbuf-2.0",
        "/usr/include/libmount",
        "/usr/include/blkid",
        "/usr/include/uuid",

        "/usr/include/glib-2.0",
        "/usr/lib/glib-2.0/include",
    };

    for (include_dirs) |dir| {
        exe.addIncludeDir(dir);
    }

    const run_cmd = exe.run();

    const run_step = b.step("run", "Run the app");
    run_step.dependOn(&run_cmd.step);

    b.default_step.dependOn(&exe.step);
    b.installArtifact(exe);
}
