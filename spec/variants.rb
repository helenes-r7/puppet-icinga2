class IcingaPuppet

  def self.variants
    {
      'Debian wheezy' => {
        :osfamily                  => 'Debian',
        :operatingsystem           => 'Debian',
        :operatingsystemrelease    => '7.8',
        :operatingsystemmajrelease => '7',
        :lsbdistcodename           => 'wheezy',
        :lsbdistid                 => 'debian',
        :path                      => '/dummy',
      },
      'Ubuntu trusty' => {
        :osfamily                  => 'Debian',
        :operatingsystem           => 'Ubuntu',
        :operatingsystemrelease    => '14.04',
        :operatingsystemmajrelease => '14.04',
        :lsbdistcodename           => 'trusty',
        :lsbdistid                 => 'ubuntu',
        :path                      => '/dummy',
      },
      'RedHat 6' => {
        :osfamily                  => 'RedHat',
        :operatingsystem           => 'RedHat',
        :operatingsystemrelease    => '6.6',
        :operatingsystemmajrelease => '6',
        #:lsbdistcodename          => '',
        #:lsbdistid                => 'ubuntu',
        :path                      => '/dummy',
      },
    }
  end

end
