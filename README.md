## Changelog
v0.1.0 - Introduce IaC for EKS Cluster in AWS

# mastercard-sre

```mermaid
graph TD
    A[Admin] --> B(Git Push to Infrastructure Repo)
    B --> C{GitHub Repository}
    C --> D(CI/CD Pipeline)

    subgraph CI/CD Pipeline
        D --> D1[Stage 1: Validate IaC Dev Env]
        D1 -- Terraform fmt/validate, tflint, Terrascan --> D2(Stage 2: Plan IaC Changes)
        D2 --> D3{If success go to deployment}
        D3 -- Apply Terraform Plan (Dev Env) --> E(AWS Development Account)
        E -- EKS Cluster provisioning --> F(Dev App Deployment)

        F --> D4(Stage 2: Plan IaC Changes Test Env)
        D4 --> D5{Manual Approval}
        D5 -- Apply Terraform Plan (Test Env) --> G(AWS Test Account)
        G -- EKS Cluster provisioning --> H(Test App Deployment)

        H --> H1{Manual Approval} --> D6[Stage 3: Plan IaC Changes Prod Env]
        D6 --> D7{Manual Approval}
        D7 -- Apply Terraform Plan (Prod Env) --> I(AWS Production Account)
        I -- EKS Cluster provisioning --> J(Prod App Deployment)
    end

```

## TODO
- Test on live AWS account
- Improve missing bits
- Develop / deploy first application 
- Introduce observability
    - Metrics, Traces, Alerting

