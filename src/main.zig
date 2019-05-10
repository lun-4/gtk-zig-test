const std = @import("std");

const c = @cImport({
    @cInclude("gtk/gtk.h");
});

pub fn main() anyerror!void {
    std.debug.warn("test");
}
