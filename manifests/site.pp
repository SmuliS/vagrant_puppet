Exec {
  path => "/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"
}

$application_name = "extranet"

include apache2
include application
include passenger

