# Set variables #

$user_name = "vagrant"
$application_name = "extranet"
$git_url = ""
$database_name = "extranet_production"
$database_username = "username"
$database_password = "password"

# Don't mind #

Exec {
  path => "/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"
}


include apache2
include application
include postgresql
include passenger
include capistrano

class { 'postgresql::server':
    config_hash => {
        'ip_mask_allow_all_users' => '0.0.0.0/0',
        'listen_addresses' => '*',
        'postgres_password' => 'password',
    },
}

postgresql::db{ database_name:
  user          => $database_username,
  password      => $database_password,
  grant         => 'all',
}

