# boulder::params.pp
class boulder::params {

  $boulder_reqs                       = undef
  $package                            = 'boulder'
  $version                            = '1.0.0'
  $release                            = '159aeca'

  $bindir                             = '/opt/boulder/bin'
  $cfgdir                             = '/etc/boulder'
  $datadir                            = '/etc/boulder'
  $logdir                             = '/var/log/boulder'
  $svcdir                             = '/service'

  $svcusr                             = 'boulder'
  $svcgrp                             = 'boulder'

  $rabbitmq_username                  = 'boulder'
  $rabbitmq_password                  = 'thisisatestpassword'
  $rabbitmq_server                    = 'localhost'
  $rabbitmq_port                      = '5672'
  $rabbitmq_vhost                     = 'boulder'

  $db_server                          = 'boulder-db'
  $db_port                            = '3306'
  $db_name                            = 'boulder_sa'

  $certs                              = undef
  $certs_source                       = undef

  $services                           = [ 'boulder-wfe',
                                          'boulder-ra',
                                          'boulder-sa',
                                          'boulder-ca',
                                          'boulder-va',
                                          'boulder-publisher',
                                          'ocsp-updater',
                                          'ocsp-responder' ]

  $boulder_sa_db_password             = undef
  $cert_checker_db_password           = undef
  $importer_db_password               = undef
  $mailer_db_password                 = undef
  $ocsp_updater_db_password           = undef
  $ocsp_responder_db_password         = undef
  $policy_db_password                 = undef
  $purger_db_password                 = undef
  $revoker_db_password                = undef


  $secrets                            = { boulder_sa_dburl => {
                                            isurl    => true,
                                            username => 'sa',
                                            params   => 'readTimeout=14s&writeTimeout=14s' },
                                          ocsp_updater_dburl => {
                                            isurl    => true,
                                            username => 'ocsp_update',
                                            params   => 'readTimeout=800ms&writeTimeout=800ms' },
                                          ocsp_responder_dburl => {
                                            isurl    => true,
                                            username => 'ocsp_resp',
                                            params   => 'readTimeout=800ms&writeTimeout=800ms' },
                                          cert_checker_dburl => {
                                            isurl    => true,
                                            username => 'cert_checker' },
                                          revoker_dburl => {
                                            isurl    => true,
                                            username => 'revoker' },
                                          purger_dburl => {
                                            isurl    => true,
                                            username => 'purger' },
                                          mailer_dburl => {
                                            isurl    => true,
                                            username => 'mailer' },
                                          amqp_url => {
                                            isurl    => true,
                                            username => 'boulder' },
                                          smtp_password => {
                                            isurl    => false,
                                            password => 'thisisatestpassword' }
                                        }

  $pkcs11                             = false
  $pkcs11module                       = undef
  $pkcs11pin                          = undef
  $pkcs11cardlabel                    = undef
  $pkcs11tokenlabel                   = undef
  $pkcs11privkeylabel                 = undef

  $issuercert                         = undef
  $issuerprivkey                      = undef
  $intermediate_ca_bundle             = undef

  $smtp_server                        = 'localhost'
  $smtp_username                      = 'root@localhost'
  $smtp_from_address                  = 'Cert Expiration Bot <noreply@example.com>'

  $dns_resolver                       = 'localhost:53'

  $cname                              = 'ca.example.com'
  $ct_server                          = 'localhost'
  $ct_server_port                     = '4500'

  $user_notice                        = 'Do What Thou Wilt'

}