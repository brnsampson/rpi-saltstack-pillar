infra:
  'roles:bootstrap':
    - match: grain
    - packages
    - users
    - salt_formula
