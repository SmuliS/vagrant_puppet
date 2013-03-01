class apache2 {
  package {
    "apache2":
      ensure => present,
      before => File["/etc/apache2/apache2.conf"]
  }
  service {
    "apache2":
      ensure => true,
      enable => true
  } 
  file {
    "/etc/apache2/apache2.conf":
      source => "puppet:///modules/apache2/apache2.conf",
      mode => 644,
      owner => root,
      group => root;
    "/etc/apache2/sites-available/application.conf":
      owner => root,
      content => template("apache2/application.conf.erb"),
      group => root,
      notify => Service["apache2"],
      require => Package["apache2"];
  }
  exec {
  "sudo a2ensite application.conf":
    require => File["/etc/apache2/apache2.conf"],

  }
  
}
