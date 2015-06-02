{% if grains['os'] == 'Ubuntu' %}

dataloop_repo:
  pkgrepo.managed:
    - name: deb  https://download.dataloop.io/deb stable main
    - humanname: dataloop
    - file: /etc/apt/sources.list.d/dataloop.list
    - key_url: https://download.dataloop.io/pubkey.gpg
    - gpgcheck: 1
    - gpgkey: file:///etc/pki/rpm-gpg/RPM-GPG-KEY-dataloop

{% elif grains['os_family'] == 'RedHat' %}

/etc/pki/rpm-gpg/RPM-GPG-KEY-dataloop:
  file.managed:
    - source: https://download.dataloop.io/pubkey.gpg
    - source_hash: md5=aa2193d72e0f45908c9c0bcca42e3da4
    - require_in:
      - pkgrepo: dataloop_repo

dataloop_repo:
  pkgrepo.managed:
    - name: dataloop
    - humanname: dataloop
    - baseurl: https://download.dataloop.io/packages/stable/rpm/$basearch/
    - gpgcheck: 1
    - gpgkey: file:///etc/pki/rpm-gpg/RPM-GPG-KEY-dataloop

{% endif %}

dataloop_install:
  pkg.installed:
    - name: dataloop-agent 
    - refresh: True
    # - skip_verify: True
 
/etc/dataloop/agent.yaml:
  file.managed:
    - source: salt://dataloop-agent/dataloop-agent.yaml.j2
    - template: jinja
    - context:
      dataloop_api_key: XXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXXXXXX 

dataloop-agent_init:
  file.managed:
    {% if grains['os'] == 'Ubuntu' %}
    - name: /etc/default/dataloop-agent
    {% elif grains['os_family'] == 'RedHat' %}
    - name: /etc/sysconfig/dataloop-agent
    {% endif %}
    - source: salt://dataloop-agent/dataloop-agent.init.j2
    - template: jinja
    - context:
      deregister_onstop: yes

dataloop-agent:
  service:
    - running
    - enable: True
    - order: last
    - watch:
      - file: /etc/dataloop/agent.yaml
      - pkg: dataloop_install
