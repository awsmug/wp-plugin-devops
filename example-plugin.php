<?php
/*
Plugin Name: Example Plugin
Plugin URI: https://awesome.ug
Description: We are testing devops
Version: 1.0
Author: Sven Wagener
Author URI: https://awesome-ug
Min WP Version: 4.6
Max WP Version: 4.8.1
*/

function hello_world() {
	echo "Hello World";
}

add_action( 'wp_footer', 'hello_world' );