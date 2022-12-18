const std = @import("std");
const capy = @import("capy");
const rn = std.rand.DefaultPrng;
const bprint = std.fmt.bufPrint;

// This is required for your app to build to WebAssembly and other particular architectures
pub usingnamespace capy.cross_platform;

var lab_key = capy.Label(.{ .text = "" });

pub fn main() !void {
    try capy.backend.init();

    var window = try capy.Window.init();

    try window.set(capy.Column(.{ .expand = .Fill, .spacing = 10 }, .{ &lab_key, capy.Button(.{ .label = "Generate", .onclick = update_label }) }));

    window.setTitle("Zig W95 OEM Keygen");
    window.resize(320, 120);
    window.show();

    capy.runEventLoop();
}

pub fn update_label(button_: *anyopaque) !void {
    const button = @ptrCast(*capy.Button_Impl, @alignCast(@alignOf(capy.Button_Impl), button_));
    _ = button.getLabel();
    var key = try generate_w95_key();
    lab_key.setText(&key);
}

pub fn generate_w95_key() ![23:0]u8 {
    var str: [23:0]u8 = undefined;
    var time = @intCast(u64, std.time.timestamp());
    var rng = rn.init(time);

    const day: u32 = rng.random().intRangeAtMost(u32, 0, 366);
    const year: u32 = rng.random().intRangeAtMost(u32, 95, 102) % 100;
    const unchk: u32 = rng.random().intRangeAtMost(u32, 0, 99999);

    var mod7: [5]u8 = undefined;
    var sum: u32 = undefined;
    var mod7int: u32 = 0;

    while (true) {
        sum = 0;
        for (mod7) |*n| {
            n.* = rng.random().intRangeAtMost(u8, 0, 9);
            sum += @intCast(u32, n.*);
        }

        if (sum % 7 == 0) {
            break;
        }
    }

    for (mod7) |n| {
        mod7int *= 10;
        mod7int += n;
    }

    _ = try bprint(&str, "{d:0>3}{d:0>2}-{s}-00{d:0>5}-{d:0>5}", .{ day, year, "OEM", mod7int, unchk });
    str[23] = 0;

    return str;
}
