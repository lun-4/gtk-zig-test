const std = @import("std");

const c = @cImport({
    @cInclude("gtk/gtk.h");
});

// we can try to not use export fn main and instead run with
// std.os.args, but i'd rather do this instead.

export fn main(argc_val: c_int, argv_val: [*c][*c]u8) i32 {
    var argc = argc_val;
    var argv = argv_val;

    //std.debug.warn("argc type: {}\n", @typeName(@typeOf(argc)));
    //std.debug.warn("argv type: {}\n", @typeName(@typeOf(argv)));

    var window: [*c]c.GtkWidget = undefined;

    c.gtk_init(&argc, &argv);

    window = c.gtk_window_new(c.GtkWindowType.GTK_WINDOW_TOPLEVEL);

    _ = c.gtk_widget_show(window);
    _ = c.gtk_main();
    return 0;
}
