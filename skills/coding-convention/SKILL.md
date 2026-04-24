---
name: coding-convention
description: >
  Megaads team coding conventions and standards for PHP, HTML/CSS/JS, Database, and Git workflow.
  Use this skill whenever writing, reviewing, or fixing code for any Megaads project. Triggers include:
  creating new PHP classes, controllers, models, or functions; writing HTML/CSS/JS code; designing
  database tables or migrations; making git commits or working with branches; reviewing or refactoring
  existing code; generating boilerplate or scaffold code. Also trigger when the user mentions "conventions",
  "coding standards", "code review", "megaads", "naming conventions", "format code", "git commit message",
  "database schema", or asks to check if code follows team rules. Use this skill even when the user just
  asks you to write code for a Megaads project without explicitly mentioning conventions — the conventions
  should be applied automatically.
---

# Megaads Coding Conventions

This skill contains the official coding conventions for the Megaads development team. These conventions
apply to **all projects** and cover four domains: PHP, HTML/CSS/JS, Database, and Git workflow.

Your job is to **always follow these conventions** when writing new code, and to **identify and fix violations**
when reviewing existing code. Think of these conventions as the team's shared language — consistency across
the codebase makes everyone more productive.

## How to Use This Skill

**When generating code:** Apply all relevant conventions automatically. You don't need to explain every
rule you're following — just write clean code that conforms. If a user's request would conflict with a
convention, mention it briefly and suggest the convention-compliant approach.

**When reviewing code:** Check the code against the relevant conventions below. Report violations grouped
by severity — things that could cause bugs first (wrong data types, missing required columns), then
formatting/naming issues. For each violation, show what's wrong and suggest the fix. When providing
a corrected version of the code, make sure the corrected code itself fully follows all conventions too
(this is easy to miss — double-check the corrected code before presenting it).

**When unsure which conventions apply:** Read the appropriate reference file in `references/` for the
full details. The summaries below cover the most important rules; the reference files have the complete
set with examples.

---

## PHP Conventions

### Folders
- Follow the framework's standard naming where applicable
- Use `kebab-case` or `UpperCamelCase` for folder names
- Folder names should be nouns, never abbreviated just because they're long

### Resource Files (images, media, css, js)
- Filenames in lowercase `kebab-case`
- Use underscore `_` for supplementary attributes: `close-button_hover_big.png` (not `close-button-hover-big.png`)

### Classes
- Class names and filenames use `UpperCamelCase`
- Class name must match the filename exactly
- Class names are nouns
- Follow the framework's controller naming convention (e.g., `OrderController.php` → `class OrderController`)

### Functions
- Function names use `lowerCamelCase`
- Function names are **verbs** (they describe actions)
- All parameters on a single line, with 1 space between each
- Document every function with PHPDoc comments (`@param`, `@return`)
- Keep functions under **30 lines** — if longer, break into smaller functions
- Keep classes under **200 lines**

### String Quoting — Single Quotes Only

This is one of the most common mistakes. In PHP code, always use single quotes `'` for strings. Never use double quotes `"`. This applies everywhere: variable assignments, array keys, function arguments, conditions, method calls.

```php
// Wrong — double quotes
$str = "hello world";
$element = $arr["key"];
Order::where("status", "active");

// Correct — single quotes
$str = 'hello world';
$element = $arr['key'];
Order::where('status', 'active');
```

When you need to include a variable in a string, use concatenation with `.` instead of double-quote interpolation:
```php
// Wrong
$msg = "hello $name";

// Correct
$msg = 'hello ' . $name;
```

### The Single Entry / Single Exit Pattern

Every function should have exactly one `return` statement, placed at the very end. Use a `$retval` variable to collect the result. This makes the function's flow predictable and easier to debug.

```php
// Wrong — multiple return statements
private function getUser($id, $columns)
{
    if ($id > 0) {
        return $userService->get($id, $columns);
    } else {
        return new User();
    }
}

// Correct — single return with $retval
private function getUser($id, $columns)
{
    $retval = null;
    if ($id > 0) {
        $retval = $userService->get($id, $columns);
    } else {
        $retval = new User();
    }
    return $retval;
}
```

This pattern applies in all cases — even when it feels more natural to return early. The consistency matters because it makes code reviews faster and reduces bugs from forgotten cleanup logic.

When reviewing code: if you see multiple `return` statements in a function, flag it and show how to refactor using `$retval`.

### Other Formatting Rules
- 1 tab = 4 spaces
- Use `$item` / `$element` for loop variables in `foreach`, not the collection's singular form
- Conditions with 3+ clauses: break each clause onto its own line
- Arrays with 3+ elements: break each element onto its own line
- Method chains with 3+ calls: break each call onto its own line
- 1 space after `:`, `=>`, `>`, `<`, `=`, `{`
- 1 space between parameter list and opening brace
- 1 space between control keywords (`if`, `else`, `switch`) and opening parenthesis

For full details and code examples, read `references/php-conventions.md`.

---

## HTML / CSS / JavaScript Conventions

### HTML
- Always write complete opening and closing tags
- New line for every block, list, or table element; indent child elements
- Use double quotes `"` for attribute values (note: this is the opposite of PHP — HTML uses double quotes, PHP uses single quotes)
- Attribute order: `id`, `class`, `style`, then other attributes
- 2+ attributes → break each onto its own line
- Attribute values with multiple parts: use 1 space to separate (e.g., `data-out="user.id + ',' + user.name"`)
- Omit protocol (`http:`, `https:`) in resource URLs — use `//` instead

### CSS
- 1 space after `:` in property declarations
- 1 space before `{` in rule declarations
- Use hex colors (`#000`) or `rgba()` — use 3-char hex when possible
- Always end declarations with `;`
- Use shorthand properties when possible (`padding: 0 1em 2em` instead of individual sides)
- IDs only for unique elements (header, footer, modal) — use classes for everything else
- Separate selectors with newlines
- Use single quotes `'` in selectors and attribute values
- No quotes around `url()` values

### CSS Class Naming (BEM-inspired)
- Class names are nouns, use `-` to separate words
- `--` for modifiers: `.button--primary`
- `is-` prefix for state classes used in JS/HTML interaction: `.is-active`
- `js-` prefix for JS-only classes: `.js-toggle`
- `l-` prefix for layout classes: `.l-header`

### JavaScript
- Variable names in `lowerCamelCase`
- Constants in `CONSTANT_VALUE`
- Always end statements with `;`
- Always declare `var` / `let` before using a variable
- Function naming: same rules as PHP (`lowerCamelCase`, verbs)
- Document functions and classes with JSDoc comments
- **Single entry, single exit** principle — same as PHP, use a `retval` variable and one `return` at the end

```javascript
// Wrong
function getUser(code, columns) {
    if (id > 0) {
        return user[code];
    }
    return new User();
}

// Correct
function getUser(code, columns) {
    var retval = null;
    if (id > 0) {
        retval = user[code];
    } else {
        retval = new User();
    }
    return retval;
}
```

- Max 30 lines per function

### UX Standards
- Minimize user actions (clicks, mouse movement)
- SEO-friendly: only one `<h1>` tag, proper meta tags (title, description, keywords)
- Checkbox labels must be clickable (wrap checkbox in `<label>` or use `for` attribute)
- Search triggers on Enter key press
- Auto-focus the first input field when opening/loading forms
- Show empty list messages when no data
- Use `cursor: pointer` for clickable elements
- Consistent single language throughout the page

For full details and code examples, read `references/html-js-css-conventions.md`.

---

## Database Conventions

### Tables
- Engine: **InnoDB** (always specify explicitly: `ENGINE=InnoDB`)
- Encoding: **UTF-8 Unicode** — always specify: `DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci`
- Table names: **singular nouns** in `snake_case` — never abbreviate. Use `product` not `products`, `order` not `orders`
- Relationship/join tables: use `table1_n_table2` format (e.g., `product_n_warehouse`, `product_n_category`)

### Columns
- Column names: singular nouns in `snake_case` — never abbreviate
- Date columns: use `DATETIME` type
- Boolean columns: use `TINYINT(1)`
- Status columns: use `ENUM` with values mapped as: `PENDING` (0), `ACTIVE` (1), `BLOCK` (2)

### Avoiding TEXT — Use VARCHAR with Explicit Length

The team convention is to avoid `TEXT` type whenever possible. Instead, use `VARCHAR` with an explicit length that fits the expected data. This makes the schema self-documenting and helps catch oversized inputs early.

```sql
-- Wrong: lazy use of TEXT
description TEXT,

-- Correct: explicit length based on actual needs
description VARCHAR(2000),
short_description VARCHAR(500),
name VARCHAR(255),
```

Only use `TEXT` when you genuinely need unbounded content (e.g., rich-text editor content, raw HTML). For fields like product descriptions, addresses, or notes, `VARCHAR` with a generous but defined length is almost always sufficient.

### Required Columns (every table must have these)
- `id` — primary key, auto increment
- `created_at` / `create_time` — `DATETIME`, default `CURRENT_TIMESTAMP`
- `updated_at` / `update_time` — `DATETIME`, default `CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP`

### Example Migration

```sql
CREATE TABLE IF NOT EXISTS `product` (
    `id` INT AUTO_INCREMENT PRIMARY KEY,
    `name` VARCHAR(255) NOT NULL,
    `description` VARCHAR(2000),
    `price` DECIMAL(10, 2) NOT NULL,
    `status` ENUM('PENDING', 'ACTIVE', 'BLOCK') NOT NULL DEFAULT 'PENDING',
    `featured_image` VARCHAR(500),
    `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `updated_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
```

For full details, read `references/database-conventions.md`.

---

## Git Flow & Commit Conventions

### Branch Structure
- `master` / `main` — stable production-ready releases
- `hotfix/*` — urgent fixes directly on main
- `release/*` — pre-release branch for customer builds
- `develop` — main development branch (internal testing)
- `feature/*` — individual feature branches

### Commit Message Format

Every commit message starts with a **type prefix** followed by a colon and a space, then a clear description. The prefix tells the team what kind of change this is at a glance.

| Prefix | When to use | Example |
|--------|-------------|---------|
| `Feature:` | Adding new functionality | `Feature: Add user authentication system` |
| `Fix:` | Bug fixes | `Fix: Resolve issue with form validation` |
| `Optimize:` | Performance improvements | `Optimize: Improve image loading performance` |
| `Config:` | Configuration changes | `Config: Update webpack configuration` |
| `UI:` | User interface changes | `UI: Update button styles on homepage` |
| `Doc:` | Documentation updates | `Doc: Update README with setup instructions` |

When writing commit messages for the user, always use these exact prefixes. The prefix is case-sensitive — capitalize only the first letter.

### Commit Rules
- Review every line and file before committing — only commit what's necessary
- **Never** commit secrets, API keys, or sensitive data
- **Never** commit production configs — use `.example` files instead (e.g., `Config.example`, `.env.example`)

For full details, read `references/git-conventions.md`.
