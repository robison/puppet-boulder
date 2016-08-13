# boulder service.pp
class boulder::service {

  $package = $boulder::package
  $version = $boulder::version
  $release = $boulder::release
  $bindir  = $boulder::bindir
  $cfgdir  = $boulder::cfgdir
  $datadir = $boulder::datadir
  $svcdir  = $boulder::svcdir
  $svcusr  = $boulder::svcusr
  $svcgrp  = $boulder::svcgrp

  boulder::servicefiles { $services: }

}
