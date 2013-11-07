Facter.add('mdadmversion') do
  mdadm = Facter.value(:mdadm)
  setcode do
    unless mdadm.nil?
      # `mdadm --version` sends it's output to stderr
      Facter::Util::Resolution.exec("#{mdadm} --version 2>&1")
    end 
  end
end
