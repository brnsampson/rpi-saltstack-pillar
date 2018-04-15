infra:
  '*':
    - packages
    - users
    - salt_formula
    - golang
  'roles:bootstrap':
    - match: grain
    - consul-bootstrap
    - nomad-bootstrap
