base:
  '*':
    - salt_formula
    - packages
dev:
  '*':
    - users
  'seed*':
    - router
