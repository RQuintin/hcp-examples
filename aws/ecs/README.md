---
name: HCP Consul on AWS - Getting Started with Amazon ECS and HashiCorp Terraform
products_used:
  - consul
  - terraform
description: |-
  You'll learn how to connect Hashicorp Consul clients on Amazon ECS to servers on HCP Consul.
redirects: <former URL(s) to be redirected, e.g., tutorials/terraform/intro-gcp>
default_collection_context: <slug of primary collection, e.g., consul/datacenter-deploy>
---

In this tutorial, you will deploy HashiCorp Consul clients to Amazon Elastic Container Service (ECS) using EC2 instances
and connect them to HCP Consul with HashiCorp Terraform. The configuration will create:

- VPC
- EC2 Autoscaling Group
- ECS Cluster
- ECS Task Definition for Consul clients
- Secrets in AWS Secrets Manager
- IAM Roles and Policies for ECS task execution
- Peering 
- Security Group Rules for HCP Consul

## Challenge

> **OPTIONAL:** If this is covered in the introduction, you don't need to have this
> explicit header.

State the common business challenge. Often times, you can get this information
in the **Background** section of the RFC written by the PM. If not, reach out to
the PM and ask for an example (customer story).

## Solution

> **OPTIONAL:** If this is covered in the introduction, you don't need to have this
> explicit header.

How the product solves this challenge. This is where you explain _why you should
read this guide_.

## Personas

_If applicable_

> **OPTIONAL:** If this is covered in the introduction, you don't need to have this
> explicit section.

If the guided steps involve multiple roles, describe it here.

Example:

The end-to-end scenario described in this guide involves two personas:

- `admin` with privileged permissions to write secrets
- `apps` reads the secrets from Vault (client)

## Prerequisites

- [Hashicorp Virtual Network](https://deploy-preview-1720--hashicorp-learn.netlify.app/consul/hcp/deploy)
- [HCP Consul](https://deploy-preview-1720--hashicorp-learn.netlify.app/consul/hcp/client-vm)
- Consul **version 1.8.0** or later
- Terraform **version 0.13.0** or later

## Action title 1

Short description of this step.

If applicable, demonstrate the steps using CLI, API, and/or UI.

Leverage the [tabs component](https://github.com/hashicorp/learn/blob/master/components/tabs/README.md) to organize the content.

<Tabs>
<Tab heading="CLI command">

Step by step instruction here.

</Tab>
<Tab heading="API call using cURL">

Step by step instruction here.

</Tab>
<Tab heading="Web UI">

Step by step instruction here.

</Tab>
</Tabs>

## Action title 2

Short description of this step.

If applicable, demonstrate the steps using CLI, API, and/or UI.

Leverage the [tabs component](https://github.com/hashicorp/learn/blob/master/components/tabs/README.md) to organize the content.

<Tabs>
<Tab heading="CLI command">

Step by step instruction here.

</Tab>
<Tab heading="API call using cURL">

Step by step instruction here.

</Tab>
<Tab heading="Web UI">

Step by step instruction here.

</Tab>
</Tabs>

## Action title 3

Short description of this step.

If applicable, demonstrate the steps using CLI, API, and/or UI.

Leverage the [tabs component](https://github.com/hashicorp/learn/blob/master/components/tabs/README.md) to organize the content.

<Tabs>
<Tab heading="CLI command">

Step by step instruction here.

</Tab>
<Tab heading="API call using cURL">

Step by step instruction here.

</Tab>
<Tab heading="Web UI">

Step by step instruction here.

</Tab>
</Tabs>

...

## Additional discussion

_Optional_

Often times, support or TAMs ask you to add extra discussion to explain little
more about cloud provider specific pitfalls, etc. You can add them here if it
does not fit into anywhere else.

## Next steps

In this section, start with a brief **_summary_** of what you have learned in
this guide re-emphasizing the business value. Then provide some guideance on the
next steps to extend the user's knowledge. Briefly describe what the user will do in the next guide if the current track is sequential.

Add cross-referencing links to get more information about the feature (e.g.
product doc page, webinar links, blog post, etc.).