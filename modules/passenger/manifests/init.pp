class passenger {
  exec {
    "/usr/local/bin/gem install passenger -v=3.0.19":
      user => root,
      group => root,
      alias => "install_passenger",
      before => [File["passenger_conf"],Exec[passenger_apache_module]],
      unless => "ls /usr/local/lib/ruby/gems/1.9.3/gems/passenger-3.0.19/"
  }
  exec {
    "/usr/local/bin/passenger-install-apache2-module --auto":
      user => root,
      group => root,
      path => "/bin:/usr/bin:/usr/local/apache2/bin",
      alias => "passenger_apache_module",
      unless => "ls /usr/local/lib/ruby/gem/1.9.3/gems/passenger-3.0.19/ext/apache2/mod_passenger.so"
  }
  file {
    "/etc/apache2/conf.d/passenger.conf":
      mode => 644,
      owner => root,
      group => root,
      alias => "passenger_conf",
      notify => "Service[apache2]",
      source => "puppet:///modules/passenger/passenger.conf"
}
}
