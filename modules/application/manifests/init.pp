class application {
  file {
    ["/var/$application_name",
    "/var/$application_name/shared",
    "/var/$application_name/shared/config"]:
      ensure => directory,
      owner => vagrant,
      group => vagrant,
      mode => 775
  }
  file {
    "/var/$application_name/shared/config/database.yml":
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
