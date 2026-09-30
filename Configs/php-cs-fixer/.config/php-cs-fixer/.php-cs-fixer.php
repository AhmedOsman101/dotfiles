<?php

declare(strict_types=1);

use PhpCsFixer\Config;
use PhpCsFixer\Finder;

// 💡 by default, Fixer looks for `*.php` files excluding `./vendor/` - here, you can groom this config
$finder = new Finder()
  // 💡 root folder to check
  ->in(__DIR__)
  ->exclude(["vendor", "node_modules", "storage", "bootstrap/cache", "resources/views"])
  ->name("*.php");

return new Config()
  ->setRiskyAllowed(true)
  ->setIndent("  ") // 2 spaces
  ->setLineEnding("\n")
  ->setRules([
    /*
     |--------------------------------------------------------------------------
     | Base
     |--------------------------------------------------------------------------
     */

    "@PSR12" => true,
    "@auto" => true,
    "@auto:risky" => true,
    "@PhpCsFixer" => true,
    "@PhpCsFixer:risky" => true,

    /*
     |--------------------------------------------------------------------------
     | From settings.json (HIGHEST PRIORITY)
     |--------------------------------------------------------------------------
     */

    // K&R braces
    "curly_braces_position" => [
      "functions_opening_brace" => "same_line",
      "classes_opening_brace" => "same_line",
      "anonymous_functions_opening_brace" => "same_line",
      "anonymous_classes_opening_brace" => "same_line",
      "control_structures_opening_brace" => "same_line",
    ],

    "control_structure_continuation_position" => [
      "position" => "same_line",
    ],

    // Lowercase constants
    "constant_case" => ["case" => "lower"], // was lower

    // Space after cast
    "cast_spaces" => ["space" => "single"],

    // Concatenation spacing (your XML says 0 spacing)
    "concat_space" => ["spacing" => "one"],

    // No spaces inside parentheses
    "no_spaces_inside_parenthesis" => true,

    // Space before control structure parentheses
    "single_space_around_construct" => true,

    // Spread operator spacing
    "method_argument_space" => [
      "on_multiline" => "ensure_fully_multiline",
    ],

    // Trailing comma in multiline
    "trailing_comma_in_multiline" => [
      "elements" => ["arrays", "arguments", "parameters"],
    ],

    // Align assignments (closest possible)
    "binary_operator_spaces" => [
      "default" => "single_space",
      "operators" => [
        "=" => "align_single_space_minimal",
        "=>" => "align_single_space_minimal",
      ],
    ],

    // EOF newline
    "single_blank_line_at_eof" => true,

    /*
      |--------------------------------------------------------------------------
      | From rules.xml (LOWER PRIORITY)
      |--------------------------------------------------------------------------
      */

    // Remove trailing whitespace
    "no_trailing_whitespace" => true,

    // Remove extra blank lines
    "no_extra_blank_lines" => [
      "tokens" => ["extra"],
    ],

    // Function spacing
    "blank_line_before_statement" => [
      "statements" => ["return"],
    ],

    // Object operator spacing
    "object_operator_without_whitespace" => true,

    // Multiline indentation
    "array_indentation" => true,
    "indentation_type" => true,

    // Switch indentation
    "switch_case_space" => true,

    // Import compiler-optimized functions with a use function statement.
    "global_namespace_import" => [
      "import_classes" => true,
      "import_constants" => true,
      "import_functions" => true,
    ],

    // // Add a leading backslash to compiler-optimized global functions
    // 'native_function_invocation' => [
    //   'include' => ['@compiler_optimized'],
    //   'scope' => 'namespaced',
    //   'strict' => false, // Set to false to only add backslashes, not remove them
    // ],
  ])
  ->setCacheFile(getenv("HOME") . "/.cache/php-cs-fixer.cache")
  ->setFinder($finder);
