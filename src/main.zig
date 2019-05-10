const std = @import("std");

const c = @cImport({
    @cInclude("gtk/gtk.h");
});

// we can try to not use export fn main and instead run with
// std.os.args, but i'd rather do this instead.

export fn main(argc: usize, argv: [*c][255]u8) i32 {
    var window: [*c]c.GtkWidget = undefined;

    c.gtk_init(&argc, &argv);

    window = c.gtk_window_new(c.GTK_WINDOW_TOPLEVEL);
    _ = c.gtk_widget_show(window);
    _ = c.gtk_main();
    return 0;
}
