<?php
	$target = getenv('TARGET', true) ?: 'World';
	echo sprintf("Hello %s! Greeting from php dev", $target);
      
?>

