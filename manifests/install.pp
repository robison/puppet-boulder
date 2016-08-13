# boulder::install.pp
class boulder::install {

  $boulder_reqs = $boulder::boulder_reqs
  $package      = $boulder::package
  $version      = $boulder::version
  $release      = $boulder::release

  package {

    $package:
      ensure  => "${version}-${release}",
      require => $boulder_reqs;

  }

}