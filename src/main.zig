const std = @import("std");

const c = @cImport({
    @cInclude("gtk/gtk.h");
});

// we can try to not use export fn main and instead run with
// std.os.args, but i'd rather do this instead.

export fn main(argc_val: c_int, argv_val: [*c][*c]u8) i32 {
    // deconsting argc and argv or else zig's compiler will yell about
    // the gtk_init call the deconst.
    var argc = argc_val;
    var argv = argv_val;

    // heavy reliance on c pointers for this to work
    var window: [*c]c.GtkWidget = undefined;

    c.gtk_init(&argc, &argv);

    // note that c.GTK_WINDOW_TOPLEVEL won't work due to it becoming a
    // comptime_int instead of a member of the enum. we have to reference it
    // by the enum itself first.
    window = c.gtk_window_new(c.GtkWindowType.GTK_WINDOW_TOPLEVEL);

    _ = c.gtk_widget_show(window);
    _ = c.gtk_main();

    return 0;
}
