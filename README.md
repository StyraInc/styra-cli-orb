# Styra policy-check orb for CircleCI

## What is this?

With this orb, you can quickly validate and enforce policies on Kubernetes resources in CircleCI workflows. 

Note: To use this orb you need a valid Styra account, if you do not have one already, visit https://styra.com

## How to get started

## Step 1: Create an API Token - Token will be used in below steps

Go to https://`youraccount`.styra.com -> Settings -> API Tokens ->  Add API token

## Step 2: Create a new System

Systems are displayed on the left-hand side. To add a new one, click the + next to the word "Systems" and fill

System name: a human-friendly name, so you remember which cluster is which

Description: more details about this cluster

Read-only: set to true only if you want to stop people from editing the policy in the GUI

Enable guardrails/rules you want to put in place for CircleCI checks

Note: Toggle the mode for the above rules from monitor mode to enforced

Click on publish

## Step 3: Setup a CircleCI config.yml

Setup the config.yml to call the `styra-policy-check` job.
Example:
```
version: 2.1

orbs:
  styra-orb: styra/cli@0.0.7

workflows:
  version: 2.1
  check-workflow:
    jobs:
    - styra-orb/styra-policy-check:
        context: SystemID_b6c4e9e6e9fa410991061f3fa3b3d0ca
```
Important: Specify the following Environment variables in your CircleCI project 

`$STYRA_TOKEN` (Supply the API token generated in Step 1.)
`$STYRA_TENANT` (E.g., `youraccount`.styra.com) 

## Step 4: Create styra yaml in the root directory of the git repository

System id can be retrieved from https://`youraccount`.styra.com -> System -> Settings. Specify this value for system_id variable in .styra.yaml

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





