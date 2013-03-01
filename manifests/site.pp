Exec {
  path => "/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"
}

$application_name = "extranet"

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

postgresql::db{ '$application_name':
  user          => 'db_user',
  password      => 'db_password',
  grant         => 'all',
}

