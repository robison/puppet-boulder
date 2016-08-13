define boulder::certfiles (

  $certs_source = $boulder::certs_source,
  $cfgdir       = $boulder::cfgdir,
  $package      = $boulder::package,
  $svcgrp       = $boulder::svcgrp,
  $svcusr       = $boulder::svcusr

  ) {

  file {

    "${cfgdir}/certs/${name}.pem":
      ensure  => file,
      require => File[$cfgdir],
      source  => "${certs_source}/${name}.pem",
      backup  => false,
      owner   => $svcusr,
      group   => $svcgrp,
      mode    => '0444';

    }

}