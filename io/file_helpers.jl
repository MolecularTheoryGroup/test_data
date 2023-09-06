
# Test that the sanitize_filename function returns the input filename when it does not contain any special characters or reserved words.
function test_sanitize_filename_no_special_chars()
    filename = "hello_world"
    expected = "hello_world"
    actual = sanitize_filename(filename)
    @test actual == expected
end

# Test if the sanitize_filename function correctly sanitizes a filename with special characters that are not in the blacklist
function test_sanitize_filename_special_characters_not_in_blacklist()
    filename = "hello_world!@#\$%^&()_+=-{}[];,.~`"
    expected = "hello_world!@#\$%^&()_+=-{}[];,.~`"
    actual = sanitize_filename(filename)
    @test actual == expected
end

# The objective of this test is to verify that the sanitize_filename function correctly removes trailing spaces from the filename.
function test_sanitize_filename_trailing_spaces()
    filename = "file   "
    expected = "file"
    actual = sanitize_filename(filename)
    @test actual == expected
end

# The objective of this test is to verify that the sanitize_filename function correctly sanitizes a filename that consists only of dots.
function test_sanitize_filename_with_only_dots()
    filename = "........"
    expected = "__"
    actual = sanitize_filename(filename)
    @test actual == expected
end

# Test that the sanitize_filename function correctly sanitizes a filename with length less than or equal to 255 characters.
function test_sanitize_filename_short()
    filename = "hello_world.txt"
    expected = "hello_world.txt"
    actual = sanitize_filename(filename)
    @test actual == expected
end

# The objective of this test is to verify that the sanitize_filename function correctly sanitizes a filename that contains special characters from the blacklist.
function test_sanitize_filename_special_characters()
    filename = "file\\name/with:invalid*characters?\"<>|.txt"
    expected = "filenamewithinvalidcharacters.txt"
    actual = sanitize_filename(filename)
    @test actual == expected
end

# The objective of this test is to verify that the sanitize_filename function correctly sanitizes filenames that contain reserved words on Windows.
function test_sanitize_filename_reserved_words()
    filename = "CON.txt"
    expected = "__CON.txt"
    actual = sanitize_filename(filename)
    @test actual == expected

    filename = "COM1.jpg"
    expected = "__COM1.jpg"
    actual = sanitize_filename(filename)
    @test actual == expected

    filename = "LPT9.docx"
    expected = "__LPT9.docx"
    actual = sanitize_filename(filename)
    @test actual == expected
end

# The objective of this test is to verify that the sanitize_filename function correctly sanitizes a filename that consists only of spaces.
function test_sanitize_filename_spaces()
    filename = "     "
    expected = "__"
    actual = sanitize_filename(filename)
    @test actual == expected
end

# Test the behavior of the sanitize_filename function when given a filename with a length greater than 255 characters and no extension.
function test_sanitize_filename_long_filename_no_extension()
    filename = repeat("a", 300)
    expected = repeat("a", 255)
    @test sanitize_filename(filename) == expected
end

# Test if the sanitize_filename function correctly sanitizes a filename with a length greater than 255 characters and an extension longer than 254 characters
function test_sanitize_long_filename()
    filename = repeat("a", 300) * ".txt"
    expected = repeat("a", 251) * ".txt"
    @test sanitize_filename(filename) == expected
end

# Test the behavior of the sanitize_filename function when given a filename with non-ASCII characters.
function test_sanitize_filename_non_ascii()
    filename = "héllö_世界.txt"
    expected = "héllö_世界.txt"
    actual = sanitize_filename(filename)
    @test actual == expected
end

# The objective of this test is to verify that the sanitize_filename function correctly sanitizes a filename with mixed case characters.
function test_sanitize_filename_mixed_case()
    filename = "HeLlOwOrLd"
    expected = "HeLlOwOrLd"
    actual = sanitize_filename(filename)
    @test actual == expected

    filename = "HeLlOwOrLd.txt"
    expected = "HeLlOwOrLd.txt"
    actual = sanitize_filename(filename)
    @test actual == expected

    filename = "HeLlOwOrLd.txt."
    expected = "HeLlOwOrLd.txt"
    actual = sanitize_filename(filename)
    @test actual == expected

    filename = "HeLlOwOrLd."
    expected = "HeLlOwOrLd"
    actual = sanitize_filename(filename)
    @test actual == expected
end

# Test the behavior of the sanitize_filename function when given a non-string input.
function test_sanitize_filename_non_string_input()
    input = 123
    @test_throws MethodError sanitize_filename(input)
end

# Test the behavior of the sanitize_filename function when given a filename input that contains a null character.
function sanitize_filename_with_null_character_input()
    filename = "file\0name.txt"
    expected_output = "filename.txt"
    output = sanitize_filename(filename)
    @test output == expected_output
end

# Test the behavior of the sanitize_filename function when the input filename contains only reserved words.
function test_sanitize_filename_reserved_words()
    filename = "CON"
    expected = "__CON"
    actual = sanitize_filename(filename)
    @test actual == expected

    filename = "COM1"
    expected = "__COM1"
    actual = sanitize_filename(filename)
    @test actual == expected

    filename = "LPT9"
    expected = "__LPT9"
    actual = sanitize_filename(filename)
    @test actual == expected
end

# Test the behavior of the sanitize_filename function when given a filename with control characters.
function test_sanitize_filename_control_characters()
    # Test that sanitize_filename removes all characters with ASCII values lower than 32
    @test sanitize_filename("file\0name") == "filename"
    @test sanitize_filename("file\nname") == "filename"
    @test sanitize_filename("file\tname") == "filename"
    @test sanitize_filename("file\rname") == "filename"
    @test sanitize_filename("file\x1fname") == "filename"
end

# Test the behavior of the sanitize_filename function when given an empty string.
function test_sanitize_filename_empty_string()
    filename = ""
    expected = "__"
    actual = sanitize_filename(filename)
    @test actual == expected
end

# Test the behavior of the sanitize_filename function when given a filename a trailing ". ".
function test_sanitize_filename_trailing_dot_space()
    filename = "file. "
    expected = "file"
    actual = sanitize_filename(filename)
    @test actual == expected
end

# Now call each test function
test_sanitize_filename_no_special_chars()
test_sanitize_filename_special_characters_not_in_blacklist()
test_sanitize_filename_trailing_spaces()
test_sanitize_filename_with_only_dots()
test_sanitize_filename_short()
test_sanitize_filename_special_characters()
test_sanitize_filename_reserved_words()
test_sanitize_filename_spaces()
test_sanitize_filename_long_filename_no_extension()
test_sanitize_long_filename()
test_sanitize_filename_non_ascii()
test_sanitize_filename_mixed_case()
test_sanitize_filename_non_string_input()
test_sanitize_filename_reserved_words()
test_sanitize_filename_control_characters()
test_sanitize_filename_empty_string()
test_sanitize_filename_trailing_dot_space()
