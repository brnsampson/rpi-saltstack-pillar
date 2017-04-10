base:
  '*':
    - packages
    - users
    - salt_formula
  'app*':
    - salt_formula
dev:
  'seed*':
    - router
