class application {
  file {
    ["/var/application",
    "/var/application/shared",
    "/var/application/shared/config"]:
      ensure => directory,
      owner => vagrant,
      group => vagrant,
      mode => 775
  }
  file {
    "/var/application/shared/config/database.yml":
      ensure => present,
      owner => vagrant,
      group => vagrant,
      mode => 600,
      source => "puppet:///modules/application/database.yml"
  }
  package {
    "bundler":
      provider => gem
  }

}
