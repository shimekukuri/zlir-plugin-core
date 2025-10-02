const std = @import("std");

const vii = @import("vii");
const vectorAlignedSlice = vii.conversions.VectorAlignedSlice;

pub const TokenType = enum { IDENTIFIER, KEYWORD, LITERAL_INT, LITERAL_FLOAT, LITERAL_STRING, LITERAL_CHAR, OPERATOR, SEPARATOR, COMMENT, WHITESPACE, EOF, ERROR };
pub const TokenTypeArr = x: {
    break :x 0;
};

pub const Token = struct {
    TokenType: TokenType,
    fileName: []const u8,
    location: []const u8,
    row: u32,
    col: u32,
};

pub fn createTokenizerType(comptime _run: fn (vectorAlignedSlice(u8), *usize) Token, options: struct {
    fileSlice: []const u8 = "",
}) type {
    return struct {
        fileSlice: []const u8,
        position: usize,

        pub fn init() @This() {
            return .{ .fileSlice = options.fileSlice, .position = 0 };
        }

        pub fn run(self: *@This()) Token {
            return _run(self.fileSlice, &self.position);
        }

        fn scan() void {}
    };
}
