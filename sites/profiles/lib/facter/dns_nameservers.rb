require 'facter/util/file_read'

Facter.add('dns_nameservers') do
  setcode do
    nameservers = []
    Facter::Util::FileRead.read('/etc/resolv.conf').each_line do |line|
      if line =~ %r{^nameserver\s+(\S+).*$}
        nameservers = nameservers << $1
      end
    end
    nameservers
  end
end

