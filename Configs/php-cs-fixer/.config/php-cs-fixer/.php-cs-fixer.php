<?php

use PhpCsFixer\Config;
use PhpCsFixer\Finder;

$finder = Finder::create()
  ->in(__DIR__)
  ->exclude([
    'vendor',
    'node_modules',
    'storage',
    'bootstrap/cache',
    'resources/views',
  ])
  ->name('*.php');

return (new Config())
  ->setRiskyAllowed(true)
  ->setIndent('  ') // 2 spaces
  ->setLineEnding("\n")
  ->setRules([

    /*
     |--------------------------------------------------------------------------
     | Base
     |--------------------------------------------------------------------------
     */

    '@PSR12' => true,

    /*
     |--------------------------------------------------------------------------
     | From settings.json (HIGHEST PRIORITY)
     |--------------------------------------------------------------------------
     */

    // K&R braces
    'braces' => [
      'position_after_functions_and_oop_constructs' => 'same',
      'position_after_control_structures' => 'same',
      'position_after_anonymous_constructs' => 'same',
    ],

    // Lowercase constants
    'constant_case' => ['case' => 'lower'], // was lower

    // Space after cast
    'cast_spaces' => ['space' => 'single'],

    // Concatenation spacing (your XML says 0 spacing)
    'concat_space' => ['spacing' => 'one'],

    // No spaces inside parentheses
    'no_spaces_inside_parenthesis' => true,

    // Space before control structure parentheses
    'single_space_around_construct' => true,

    // Spread operator spacing
    'method_argument_space' => [
      'on_multiline' => 'ensure_fully_multiline',
    ],

    // Trailing comma in multiline
    'trailing_comma_in_multiline' => [
      'elements' => ['arrays', 'arguments', 'parameters'],
    ],

    // Align assignments (closest possible)
    'binary_operator_spaces' => [
      'default' => 'single_space',
      'operators' => [
        '=' => 'align_single_space_minimal',
        '=>' => 'align_single_space_minimal',
      ],
    ],

    // EOF newline
    'single_blank_line_at_eof' => true,

    /*
     |--------------------------------------------------------------------------
     | From rules.xml (LOWER PRIORITY)
     |--------------------------------------------------------------------------
     */

    // Remove trailing whitespace
    'no_trailing_whitespace' => true,

    // Remove extra blank lines
    'no_extra_blank_lines' => [
      'tokens' => ['extra'],
    ],

    // Function spacing
    'blank_line_before_statement' => [
      'statements' => ['return'],
    ],

    // Object operator spacing
    'object_operator_without_whitespace' => true,

    // Operator spacing
    'binary_operator_spaces' => true,

    // Multiline indentation
    'array_indentation' => true,
    'indentation_type' => true,

    // Switch indentation
    'switch_case_space' => true,
  ])
  ->setCacheFile(getenv('HOME') . '/.cache/php-cs-fixer.cache')
  ->setFinder($finder);
