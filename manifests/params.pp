# == Class: mdadm::params
#
# This class should be considered private.
#
class mdadm::params {
  # mdadm class default params
  $config_file_manage = true
  $config_file_options = {}
  $service_force       = false
  $service_ensure      = 'running'
  $service_enable      = true
  $raid_check_manage   = true
  $raid_check_options  = {}

  # internal only
  $mdadm_package       = 'mdadm'
  $raid_check_path     = '/etc/sysconfig/raid-check'

  case $::osfamily {
    'redhat': {
      case $::operatingsystemmajrelease {
        '7': {
          $raid_check_template = "${module_name}/redhat/raid-check.el7.erb"
          $raid_check_default_options = {
            'ENABLED'       => 'yes',
            'CHECK'         => 'check',
            'NICE'          => 'low',
            'CHECK_DEVS'    => '',
            'REPAIR_DEVS'   => '',
            'SKIP_DEVS'     => '',
            'MAXCONCURRENT' => '',
          }
        }
        '6': {
          $raid_check_template = "${module_name}/redhat/raid-check.el6.erb"
          # note that 'NICE' is el6.x only
          $raid_check_default_options = {
            'ENABLED'       => 'yes',
            'CHECK'         => 'check',
            'NICE'          => 'low',
            'CHECK_DEVS'    => '',
            'REPAIR_DEVS'   => '',
            'SKIP_DEVS'     => '',
            'MAXCONCURRENT' => '',
          }
        }
        '5': {
          $raid_check_template = "${module_name}/redhat/raid-check.el5.erb"
          $raid_check_default_options = {
            'ENABLED'     => 'yes',
            'CHECK'       => 'check',
            'CHECK_DEVS'  => '',
            'REPAIR_DEVS' => '',
            'SKIP_DEVS'   => '',
          }
        }
        default: {
          $platform = "${::operatingsystem} ${::operatingsystemmajrelease}"
          fail("Module ${module_name} is not supported on ${platform}")
        }
      }
    }
    default: {
      fail("Module ${module_name} is not supported on ${::operatingsystem}")
    }
  }
}
