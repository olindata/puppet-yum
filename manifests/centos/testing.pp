class yum::centos::testing {
  case $yum::centos_testing_include_pkgs {
    '' : {
      fail('Please configure $yum::centos_testing_include_pkgs as we run the testing repo with highest repository')
    }
  }
  file {
    '/etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-testing' :
      source => "puppet:///modules/yum/rpm-gpg/additional/RPM-GPG-KEY-CentOS-testing",
      owner => root,
      group => 0,
      mode => '600' ;
  }
  yum::managed_yumrepo {
    'centos5-testing' :
      descr => 'CentOS-$releasever - Testing',
      baseurl => 'http://dev.centos.org/centos/$releasever/testing/$basearch',
      enabled => 1,
      gpgcheck => 1,
      gpgkey => 'http://dev.centos.org/centos/RPM-GPG-KEY-CentOS-testing',
      priority => 1,
      includepkgs => $yum::centos_testing_include_pkgs,
      exclude => $yum::centos_testing_exclude_pkgs,
  }
}
