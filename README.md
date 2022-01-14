# DEVOPS ADMISSION TEST

## Table of Contents

- [About](#about)
- [Getting Started](#getting_started)
- [Usage](#usage)
- [API Documentation](https://app.swaggerhub.com/apis-docs/mrashad/ADMISSION/1.0.0)

## About <a name = "about"></a>

This is my answer for "DEVOPS ADMISSION TEST".

## Getting Started <a name = "getting_started"></a>

This system is divided into 3 repositories "gitOps" is the main one and "api" and "db" are submodule in it, you just need to clone the "gitOps" repo with the '--recurse-submodules' flag then run the scripts.

### Prerequisites

What things you need to be installed on the system.

- Git
- Docker
- Active Docker Swarm cluster
- jq (Command-line JSON processor for the testing script)
- Terraform (just if you going to build the infrastructure)
- Ansible (just if you going to build the infrastructure)

### Installing

A step by step series of examples that tell you how to get a development env running.

Clone the repo and move inside the directory


```
git clone --recurse-submodules https://github.com/mrashad10/admissiongitops.git
cd admissiongitops
```

If you need to build the infrastructure, copy the Terraform environment variables file from the example file then fill it with the correct information then run the infrastructure building script then redo the first step on the Swarm manager node

```
cp terraform.tfvars.example terraform.tfvars
vi terraform.tfvars
./script0_infra_setup.sh
```

Run script "script1_start_service.sh" to update the submodules, rebuild the docker images, deploy and update the Swarm stack
```
./script1_start_service.sh
```

And to test the system to insure that everything is working run the testing script

```
./script2_testing.sh
```

This should output result like this

```
Validation Test success
Valid insert    success
Record inserted success
```

## Usage <a name = "usage"></a>

The service is provided as an API, you can know more at [API Documentation](https://app.swaggerhub.com/apis-docs/mrashad/ADMISSION/1.0.0).