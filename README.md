# wergstation

This repo is used to configure a workstation with chef.

## packer

This repo includes a sub-directory "packer" which is not typical of most cookbooks. Inside, it allows building of vagrant boxen for testing purposes (namely Xubuntu desktop images).

This presupposes ISOs are downloaded in your "Downloads" directory (I recommend using a torrent). If not, change the value for "iso_dir" in xubuntu.json.

To build images (assuming virtualbox and packer are installed):

```bash
cd packer
packer build xubuntu-trusty.json
```

It's a little unclear if the Xubuntu Desktop image can accept a preseed, so, for now, still have to manually click through the install process and remember to create the default user as "vagrant" with the wonderful password, "vagrant".

After a reboot, packer will need ssh installed before it can take back over, running post-install scripts and building a vagrant box. To accomplish this, log is as the vagrant user ("vagrant" with password "vagrant" as chosen above), open a terminal and install ssh server:

```bash
sudo apt-get install -y openssh-server
```

Now, packer will announce it is "Connected to SSH!" and continue onward, ultimately creating a vagrant box in the "packer/output-vagrant" directory, which is the default box_url in the .kitchen.yml file used by test-kitchen.

## unlicense

I dedicate any and all copyright interest in this software to the
public domain. I make this dedication for the benefit of the public at
large. I intend this
dedication to be an overt act of relinquishment in perpetuity of all
present and future rights to this software under copyright law.

## authors

Carlton Stedman
