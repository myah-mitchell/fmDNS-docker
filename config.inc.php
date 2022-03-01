<?php

/**
 * Contains configuration details for facileManager
 *
 * @package facileManager
 *
 */

/** facileManager server */
define('FMHOST', getenv('FACILE_MANAGER_HOST') ?: 'localhost/');

/** Account number */
define('AUTHKEY', getenv('FACILE_MANAGER_AUTHKEY') ?: 'default');

/** Server unique serial number */
define('SERIALNO', getenv('FACILE_CLIENT_SERIAL_NUMBER') ?: rand(100000000, 9999999999));

define('HOST', getenv('FACILE_CLIENT_URL') ?: '');

?>
