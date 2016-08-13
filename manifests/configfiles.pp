define boulder::configfiles (

  $cfgdir    = $boulder::cfgdir,
  $package   = $boulder::package,
  $svcgrp    = $boulder::svcgrp,
  $svcusr    = $boulder::svcusr

  ) {

  file {

    "${cfgdir}/config/${name}.json":
      ensure  => file,
      require => File[$cfgdir],
      content => template("${package}/config/${name}.json.erb"),
      backup  => false,
      notify  => Service["${name}"],
      owner   => $svcusr,
      group   => $svcgrp,
      mode    => '0660';

    }

}