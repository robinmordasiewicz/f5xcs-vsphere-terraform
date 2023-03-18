#cloud-config
users:
  - name: "vesop"
    passwd: ""
    groups:
      - "sudo"

coreos:
  update:
    reboot-strategy: "off"

write_files:
  - path: /etc/vpm/config.yaml
    permissions: 0644
    owner: root
    content: |
      Kubernetes:
        EtcdUseTLS: true
        Server: vip
      Vpm:
        ClusterName: ${clustername}
        ClusterType: ce
        Config: /etc/vpm/config.yaml
        Hostname: ${hostname}
        Latitude: ${latitude}
        Longitude: ${longitude}
        MauriceEndpoint: "https://register.ves.volterra.io"
        MauricePrivateEndpoint: "https://register-tls.ves.volterra.io"
        Proxy: {}
        Token: ${token}

  - path: /etc/vpm/certified-hardware.yaml
    permissions: 0644
    owner: root
    content: |
      active: kvm-voltstack-combo
      certifiedHardware:
        kvm-voltstack-combo:
          Vpm:
            PrivateNIC: eth0
          outsideNic:
          - eth0
      primaryOutsideNic: eth0

runcmd:
  - [ sh, -c, test -e /usr/bin/fsextend  && /usr/bin/fsextend || true ]

hostname: ${hostname}
