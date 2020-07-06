<?php

require_once('vendor/class-tgm-plugin-activation.php');

function register_required_plugins()
{
    $plugins = array(
      array(
        'name'      => 'SVG Support',
        'slug'      => 'svg-support',
        'required'  => true,
      ),
    );

    $config = array(
      'id'           => 'custom-theme',
      'default_path' => '',
      'menu'         => 'tgmpa-install-plugins',
      'parent_slug'  => 'themes.php',
      'capability'   => 'edit_theme_options',
      'has_notices'  => true,
      'dismissable'  => true,
      'dismiss_msg'  => '',
      'is_automatic' => false,
      'message'      => '',
    );

    tgmpa($plugins, $config);
}
add_action('tgmpa_register', 'register_required_plugins');

function add_assets()
{
    wp_enqueue_style('bundle-custom-styles', get_stylesheet_directory_uri(). '/assets/css/bundle.css');
    wp_enqueue_script('bundle-custom-scripts', get_stylesheet_directory_uri(). '/assets/js/bundle.js', array('jquery'), '', true);
}
add_action('wp_enqueue_scripts', 'add_assets');

function setup_theme_features()
{
    $defaults = array(
        'default-color'          => '#e8e8e8',
        'default-image'          => '',
        'default-repeat'         => 'no-repeat',
        'default-position-x'     => 'center',
        'default-position-y'     => 'center',
        'default-size'           => 'cover',
        'default-attachment'     => 'fixed',
    );
    add_theme_support('custom-background', $defaults);

    add_theme_support('align-wide');
    add_theme_support('editor-styles');
    add_theme_support('html5', array( 'comment-list', 'comment-form', 'search-form', 'gallery', 'caption' ));
    add_theme_support('responsive-embeds');
    add_theme_support('title-tag');
    add_theme_support('wp-block-styles');
    add_theme_support('post-thumbnails');
    add_image_size('category-thumbnail', 800, 600, true);

    register_nav_menu('top', 'Top menu');
}

add_action('after_setup_theme', 'setup_theme_features');
