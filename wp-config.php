<?php

// ==============================
// Composer autoloader if present
// ==============================
if (file_exists(__DIR__ . '/wp-content/vendor/autoload.php')) {
    define('USE_COMPOSER_AUTOLOADER', true);
    require_once __DIR__ . '/wp-content/vendor/autoload.php';
}

// ===================================================
// Load database info and local development parameters
// ===================================================
if (file_exists(__DIR__ . '/local-config.php')) {
    include(__DIR__ . '/local-config.php');
}

// ===================================================
// Initialize DevAnime defaults
// ===================================================
if (class_exists('\VincentRagosta\WPConfig')) {
    new \VincentRagosta\WPConfig(__DIR__);
}

// ================================================
// You almost certainly do not want to change these
// ================================================
define('DB_CHARSET', 'utf8mb4');
define('DB_COLLATE', '');

// ==============================================================
// Salts, for security
// Grab these from: https://api.wordpress.org/secret-key/1.1/salt
// ==============================================================
//{salts}//

// ==============================================================
// Table prefix
// Change this if you have multiple installs in the same database
// Changing default to 'sit_' to enhance security
// ==============================================================
$table_prefix = 'sit_';

// ================================
// Language
// Leave blank for American English
// ================================
define('WPLANG', '');

// ===================
// Bootstrap WordPress
// ===================
if (! defined('ABSPATH')) {
    define('ABSPATH', dirname(__FILE__) . '/wp/');
}
require_once(ABSPATH . 'wp-settings.php');
