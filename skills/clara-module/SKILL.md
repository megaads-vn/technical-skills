---
name: clara-module
description: Use this skill whenever working on the Shopot project — a Laravel 5.x application using the Clara module management library (by Megaads). Triggers include: creating, installing, enabling, disabling, or removing Clara modules in Shopot; registering module actions, views, or variables; setting up new features as modules; working with module assets, configurations, or the module.json file; debugging module loading issues; or any mention of "shopot", "clara", "module:make", "module:install", "Module::action", "Module::view", "Module::onAction", "Module::onView", or modular Laravel architecture in the Shopot codebase. Always use this skill when the user is building or managing features in the Shopot project.
---

# Shopot — Laravel 5.x + Clara Module Manager

Shopot is built on Laravel 5.x and uses Clara (by Megaads) for modular feature management. Modules live in `app/Modules/` and are self-contained units with their own controllers, models, views, routes, assets, and config.

**Stack**: Laravel 5.x · Clara · PHP >= 7.0

---

## Installation & Setup

### 1. Install via Composer
```bash
composer require megaads/clara
```

### 2. Register in `config/app.php`
```php
// providers array
Megaads\Clara\Providers\ModuleServiceProvider::class,

// aliases array
'Module' => Megaads\Clara\Facades\ModuleFacade::class,
```

### 3. Configure autoloading in `composer.json`
```json
{
    "autoload": {
        "psr-4": {
            "App\\": "app/",
            "Modules\\": "app/Modules"
        }
    },
    "extra": {
        "merge-plugin": {
            "include": [
                "app/Modules/*/module.json"
            ]
        }
    }
}
```

Then run: `composer dump-autoload`

### 4. Publish Clara config
```bash
php artisan vendor:publish --provider="Megaads\Clara\Providers\ModuleServiceProvider"
```

---

## Module Management Commands

```bash
# Create a new module (UpperCamelCase name)
php artisan module:make <ModuleName>

# Install module by name (searches app repository in config/clara.php)
php artisan module:install <ModuleName>

# Install all modules listed in module.json
php artisan module:install

# Install from a zip file or URL
php artisan module:install <ModuleZipFilePath|URL>

# Enable / Disable
php artisan module:enable <ModuleName>
php artisan module:disable <ModuleName>

# Remove
php artisan module:remove <ModuleName>
php artisan module:remove-all

# Asset symlinks
php artisan module:asset:link <ModuleName>
php artisan module:asset:link --all
```

### Naming Convention
- Module name: `UpperCamelCase` → e.g. `FacebookComment`

---

## Module Folder Structure

```
app/Modules/ModuleName/
├── Config/
│   └── app.php
├── Controllers/
│   └── Controller.php
├── Helpers/
│   └── helper.php
├── Middlewares/
│   └── ExampleMiddleware.php
├── Models/
├── Resources/
│   ├── Views/
│   └── Assets/          ← symlinked to public/modules/{module-namespace}/
├── Routes/
│   └── routes.php
├── Kernel.php
├── module.json          ← merged into root composer.json
└── start.php            ← loaded on every request; register actions/views here
```

**Key files:**
- `module.json`: Composer-compatible config, merged into project's `composer.json`
- `start.php`: Bootstraps the module — register actions, views, hooks here

---

## Module Actions (Event System)

Actions are Clara's event/hook system. Fire an action from anywhere, handle it in any module.

### Fire an action
```php
// PHP
Module::action('action_name', [$params]);

// Blade
@action('action_name', [$params])
```

### Handle an action
```php
// Closure handler
Module::onAction('action_name', function ($params) {
    // do something
}, $priority);

// Controller handler
Module::onAction('action_name', 'Modules\Example\Controllers\HomeController@action', $priority);
```

### Built-in Clara actions
| Action | Fired when |
|---|---|
| `module_made` | A module is created |
| `module_loaded` | A module is loaded |
| `module_enabled` | A module is enabled |
| `module_disabled` | A module is disabled |
| `module_removed` | A module is removed |
| `module_removed_all` | All modules are removed |

---

## Module Views (Slot System)

Views let modules inject content into named "slots" defined in other modules or layouts.

### Register a view slot (define where content can be injected)
```php
// PHP — pass params, a string placeholder, or a closure
Module::view('view_name', $params);
Module::view('view_name', 'Placeholder text', $isMultiLayer);
Module::view('view_name', function() {
    return 'Placeholder';
}, $isMultiLayer);

// Blade
@view('view_name', $params)
```

### Handle a view slot (inject content into a slot)
```php
// Closure
Module::onView('view_name', function ($params) {
    return view('{module-namespace}:home.index');
}, $priority);

// Controller
Module::onView('view_name', 'Modules\ExampleModule\Controllers\HomeController@index', $priority);
```

---

## Module Variables

Variables allow modules to expose filterable values to other modules.

### Register a variable
```php
// PHP
$value = Module::variable('handle', $default, $priority);

// Blade
@variable('variable_name', 'handle', $default)
```

### Handle / filter a variable
```php
Module::onVariable('handle', function ($params) {
    return $modifiedValue;
}, $priority, $numOfParams);
```

---

## Module Assets

Assets in `Resources/Assets/` are symlinked to `public/modules/{module-namespace}/` on install/enable.

```php
// PHP
<script src="<?= Module::asset('{module-namespace}/js/app.js') ?>"></script>

// Blade
<script src="@asset('{module-namespace}/js/app.js')"></script>
```

---

## Module Configuration

Config files live in `{ModuleName}/Config/`. Access them with the `{module-namespace}::` prefix:

```php
Config::get('{module-namespace}::app.message', 'default value');
```

---

## Utility Methods

```php
Module::all();                          // Get all modules
Module::this();                         // Get the current module
Module::option('option.name');          // Get a module option
Module::option('option.name', 'value'); // Set a module option
```

---

## Common Patterns & Tips

### Registering routes in start.php
```php
// app/Modules/MyModule/start.php
Module::onAction('module_loaded', function() {
    require __DIR__ . '/Routes/routes.php';
});
```

### Cross-module communication pattern
```php
// Module A fires an event
Module::action('user_registered', ['user' => $user]);

// Module B listens and reacts
Module::onAction('user_registered', function ($params) {
    $user = $params['user'];
    // send welcome email, etc.
}, 10);
```

### Priority: lower number = higher priority (runs first)

### Checking if a module exists / is active
```php
$modules = Module::all();
// Returns array of module objects with status info
```

### Module view namespace for Blade
When a module registers a view, reference it as:
```php
view('{module-namespace}::folder.template')
// e.g. view('facebook-comment::home.index')
```
