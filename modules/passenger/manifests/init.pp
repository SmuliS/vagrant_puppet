class passenger {
  exec {
    "gem install passenger -v=3.0.19":
      user => root,
      group => root,
      alias => "install_passenger",
      before => [File["passenger_conf"],Exec["passenger_apache_module"]],
      unless => "ls /usr/local/lib/ruby/gems/1.9.1/gems/passenger-3.0.19/"
  }
  exec {
    "sudo passenger-install-apache2-module --auto":
      user => root,
      group => root,
      timeout => 600,
      path => "/bin:/usr/bin:/usr/local/apache2/bin",
      alias => "passenger_apache_module",
      before => File["passenger_conf"],
      unless => "ls /usr/local/lib/ruby/gems/1.9.1/gems/passenger-3.0.19/ext/apache2/mod_passenger.so"
  }
  file {
    "/etc/apache2/mods-available/passenger.conf":
      mode => 644,
      owner => root,
      group => root,
      alias => "passenger_conf",
      notify => Service["apache2"],
      source => "puppet:///modules/passenger/passenger.conf"
}
  file {
  "/etc/apache2/mods-available/passenger.load":
    mode => 644,
    owner => root,
    group => root,
    alias => "passenger_load",
    notify => Service["apache2"],
    source => "puppet:///modules/passenger/passenger.load"
}

  exec {
    "sudo a2enmod passenger":
      user => root,
      group => root,
      timeout => 600,
      path => "/bin:/usr/bin:/usr/local/apache2/bin",
      alias => "enable_passenger_configuration",
      require => [File["passenger_conf"],File["passenger_load"],Exec["passenger_apache_module"]],
}
}
