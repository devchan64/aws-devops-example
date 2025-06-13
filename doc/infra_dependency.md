# AWS Infra 구조 의존성
![AWS Infra 구조 의존성](./infra_dependency.png)


```mermaid
flowchart TD
ecr --> ecs_taskdef
role --> ecs_taskdef

subnet --> ecs_service
vpc --> subnet --> load_balancer

subgraph alb [ALB Group]
load_balancer --> alb_dns
load_balancer --> tg
load_balancer --> listener
end

alb_dns --> apigw
vpc --> load_balancer
vpc --> securitygroup --> load_balancer
tg --> ecs_service

ecs_cluster --> ecs_service
ecs_taskdef --> ecs_service
vpc --> ecs_service
securitygroup --> ecs_service
ecr --> ecs_service

```

