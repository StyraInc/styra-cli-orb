# Styra policy-check orb for CircleCI

## What is this?
With this orb you can easily check kubernetes policies into your CircleCI workflows

Note: To use this orb you need a valid Styra account.

## How to get started

## Create an API Token - Token will be used in below steps
Go to https://<youraccount>.styra.com -> settings -> API Tokens ->  Add API token

## Create a new System

Systems are displayed on the left-hand side. To add a new one, click the + next to the word Systems and fill
System name: a human-friendly name so you remember which cluster is which
Description: more details about this cluster
Read-only: set to true only if you want to stop people from editing policy in the GUI
Enable guardrails/rules you want to put in place for CircleCI checks

Note: Toggle the mode for the above rules from monitor mode to enforced

Click on publish

## Setup a CircleCI config.yaml

Setup the config.yaml to call the `styra-policy-check` job.
Example:
```
version: 2.1

orbs:
  styra-orb: styra/cli@dev:0.0.1

workflows:
  version: 2.1
  check-workflow:
    jobs:
      - styra-orb/styra-check
```

Important: Your CircleCI setup will need to pass an environment variable `$STYRA_TOKEN` to your CircleCI workload (the token we generated in the step above)

## Create styra yaml in the root directory of the git repository

System id can be retrieved from https://<youraccount>.styra.com -> System (from step2) -> settings

```
cat > .styra.yaml <<EOF
checks:
  foo:
    system_id: b52e42c6ab574d9ab8bc5e7a86ce72ea
    policy: admission_control
    Files:
       - k8s/prod/*.yaml
       - k8s/*/*.yaml
EOF
```





