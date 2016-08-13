define boulder::servicefiles (

  $logdir    = $boulder::logdir,
  $package   = $boulder::package,
  $svcdir    = $boulder::svcdir,
  $svcusr    = $boulder::svcusr,
  $svcgrp    = $boulder::svcgrp

  ) {

  file {

  "${svcdir}/${name}":
    ensure  => directory,
    ignore  => [ 'supervise', 'run' ],
    require => File[$svcdir],
    recurse => true,
    purge   => true,
    backup  => false,
    owner   => $svcusr,
    group   => $svcgrp;

  "${svcdir}/${name}/log":
    ensure  => directory,
    ignore  => [ 'supervise', 'run' ],
    require => File["${svcdir}/${name}"],
    recurse => true,
    purge   => true,
    backup  => false,
    owner   => $svcusr,
    group   => $svcgrp;

  "${svcdir}/${name}/run":
    ensure  => file,
    require => File["${svcdir}/${name}"],
    content => template("${package}/service/run.erb"),
    backup  => false,
    owner   => $svcusr,
    group   => $svcgrp,
    mode    => '0775';

  "${svcdir}/${name}/log/run":
    ensure  => file,
    require => File["${svcdir}/${name}/log"],
    content => template("${package}/service/log/run.erb"),
    backup  => false,
    owner   => $svcusr,
    group   => $svcgrp,
    mode    => '0775';

  "${logdir}/${name}":
    ensure  => directory,
    require => File["${logdir}"],
    backup  => false,
    owner   => $svcusr,
    group   => $svcgrp;


  "/service/${name}":
    ensure    => link,
    target    => "${svcdir}/${name}",
    require   => [ File["${svcdir}/${name}/run"],
                   File["${svcdir}/${name}/log/run"] ];
  }

  service {

    $name:
      require   => File["/service/${name}"],
      enable    => true,
      path      => "/service/${name}",
      provider  => daemontools;
  }

}