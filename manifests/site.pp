Exec {
  path => "/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin/bin"
}

include apache2
include postgresql

class { 'postgresql::server':
    config_hash => {
        'ip_mask_deny_postgres_user' => '0.0.0.0/32',
        'ip_mask_allow_all_users' => '0.0.0.0/0',
        'listen_addresses' => '*',
        'postgres_password' => 'postgres',
    },
}

postgresql::db{ 'application_db':
  user          => 'application_db',
  password      => 'application_db',
  grant         => 'all',
}

