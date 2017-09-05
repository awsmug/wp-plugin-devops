<?php
/*
Plugin Name: Example Plugin
Plugin URI: https://your-url-here.com
Description: Your Plugin description
Version: 1.0.0
Author: Your Name
Author URI: https://your-plugin-url-here.com
Min WP Version: 4.6
Max WP Version: 4.8.1
*/

function my_example_function() {
	echo "<div class=\"notice notice-success is-dismissible\">This is my Example Plugin!</div>";
}

add_action( 'admin_notices', 'my_example_function' );