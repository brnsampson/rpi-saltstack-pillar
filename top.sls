base:
  '*':
    - packages
    - users
  'app*':
    - salt_formula
dev:
  'seed*':
    - salt_formula
    - router
