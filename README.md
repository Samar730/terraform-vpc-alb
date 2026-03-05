# AWS VPC Load-Balanced Architecture — Terraform

## Project Summary

This project covers the build and deployment of a secure, load-balanced AWS VPC architecture using Terraform, deployed across two Availability Zones in `eu-west-2` (London).

The setup splits resources across public and private subnets to keep things properly isolated. User traffic comes in through Route 53, hits an Application Load Balancer over HTTPS, with SSL/TLS handled by ACM. Any HTTP traffic on port 80 gets redirected to HTTPS automatically.

EC2 instances sit in private subnets with no direct internet exposure. Outbound access for those instances is handled through a Regional NAT Gateway — so they can still pull updates and reach external services without being publicly accessible.

A Bastion Host in the public subnet of `eu-west-2a` is used for SSH access into the private instances when needed.

All infrastructure is written in Terraform and organised into reusable modules.

---

## Architecture Diagram

![Architecture Diagram](images/Architectural-Diagram.png)

---

## Architecture Components

| Component | Description |
|---|---|
| **VPC** | CIDR `10.0.0.0/16`, spanning two Availability Zones |
| **Public Subnets** | One per AZ — host the ALB, Bastion Host, and Regional NAT Gateway |
| **Private Subnets** | One per AZ — host EC2 instances, no direct internet access |
| **Internet Gateway (IGW)** | Allows public subnets to communicate with the internet |
| **Regional NAT Gateway** | Gives private EC2 instances outbound-only internet access |
| **Bastion Host** | Used to SSH into private instances for admin tasks |
| **EC2 Instances** | App servers running in private subnets across both AZs |
| **Application Load Balancer** | Distributes incoming HTTPS traffic across both EC2 instances |
| **AWS Certificate Manager (ACM)** | Manages the SSL/TLS cert attached to the ALB |
| **Route 53** | Alias record pointing `app.cloudbysamar.com` to the ALB |
| **Security Groups** | Configured per resource layer to control inbound/outbound traffic |

---

## Terraform Project Structure
```
terraform-vpc-alb/
│
├── main.tf
├── provider.tf
├── variable.tf
├── .gitignore
│
├── module/
│   ├── acm/
│   │   ├── main.tf
│   │   ├── output.tf
│   │   └── variable.tf
│   │
│   ├── alb/
│   │   ├── main.tf
│   │   ├── output.tf
│   │   └── variable.tf
│   │
│   ├── ec2/
│   │   ├── main.tf
│   │   ├── output.tf
│   │   ├── user_data_nginx.sh
│   │   └── variable.tf
│   │
│   ├── route53/
│   │   ├── main.tf
│   │   └── variable.tf
│   │
│   ├── sg/
│   │   ├── main.tf
│   │   ├── output.tf
│   │   └── variable.tf
│   │
│   └── vpc/
│       ├── main.tf
│       ├── output.tf
│       └── variable.tf
│
└── images/
```

---

## Prerequisites

- Terraform v1.3+ installed
- AWS CLI configured (`aws configure`)
- A registered domain in Route 53
- ACM certificate issued and validated in `eu-west-2`
- An EC2 Key Pair in the target region

---

## Usage
```bash
terraform init
terraform plan
terraform apply
```

To tear everything down:
```bash
terraform destroy
```

---

## Implementation Steps

### Phase 1 — Core Infrastructure

**Step 1: VPC**
Built a VPC with CIDR `10.0.0.0/16` across `eu-west-2a` and `eu-west-2b`. Created public and private subnets in each AZ and attached an Internet Gateway for public subnet access.

**Step 2: Routing and Regional NAT Gateway**
Deployed a Regional NAT Gateway in the public subnet of `eu-west-2a`. Set up route tables so public subnets route through the IGW and private subnets route outbound traffic through the Regional NAT Gateway.

**Step 3: Security Groups**
- **ALB SG** — allows inbound HTTP (80) and HTTPS (443) from the internet
- **EC2 SG** — only accepts traffic from the ALB, nothing directly from the internet
- **Bastion SG** — SSH (22) restricted to a trusted IP range

**Step 4: Compute**
Launched EC2 instances in private subnets across both AZs. Deployed a Bastion Host in the public subnet of `eu-west-2a` for admin access.

**Step 5: Application Load Balancer**
Set up an ALB across both public subnets with a target group and health checks pointing to the EC2 instances. HTTPS listener on port 443 with the ACM cert attached. HTTP on port 80 redirects straight to HTTPS.

#### Phase 1 Validation — ALB DNS Name

✅ Tested via the ALB DNS name before moving on — confirmed the load balancer was routing traffic to both EC2 instances across `eu-west-2a` and `eu-west-2b`.

![ALB Validation 1](images/alb-validation-1.png)

![ALB Validation 2](images/alb-validation-2.png)

---

### Phase 2 — DNS and HTTPS

**Step 6: ACM Certificate**
Requested an SSL/TLS certificate and validated it via DNS validation through Route 53.

**Step 7: Route 53**
Created an Alias record for `app.cloudbysamar.com` pointing to the ALB DNS name.

#### Phase 2 Validation — Custom Domain (HTTPS)

✅ Tested via the custom domain — confirmed HTTPS was working end to end with the cert attached and DNS resolving correctly.

![Custom Domain Validation 1](images/custom-domain-validation-1.png)

![Custom Domain Validation 2](images/custom-domain-validation-2.png)

---

## Security Posture

- EC2 instances have no public IPs — they can't be reached directly from the internet
- All traffic into the app goes through the ALB and is TLS-terminated there
- HTTP gets redirected to HTTPS — no unencrypted traffic reaches the instances
- Private instances use the Regional NAT Gateway for outbound traffic only
- The only way into a private instance is through the Bastion Host

---

## Infrastructure Teardown

All resources have been destroyed using `terraform destroy` to avoid unnecessary costs. The full architecture can be redeployed by following the steps above.