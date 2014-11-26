{% if grains['os'] == 'Ubuntu' %}
/etc/apt/sources.list.d/dataloop.list:
  file.managed:
    - source: salt://linux/dataloop/dataloop.list
    - require_in:
      - pkg: dataloop_install
{% endif %}

dataloop_install:
  pkg.installed:
    - name: dataloop-agent 
    - refresh: True
    - skip_verify: True

/etc/dataloop/agent.conf:
  file.managed:
    - source: salt://linux/dataloop/agent.conf

/etc/dataloop/.service_credentials:
  file.managed:
    - source: salt://linux/dataloop/.service_credentials
    - user: dataloop
    - mode: 600

dataloop:
  user.present:
    - groups:
      - docker

dataloop-agent:
  service:
    - running
    - enable: True
    - order: last
