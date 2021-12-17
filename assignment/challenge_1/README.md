### Challenge 1

#### Problem Statement
A 3 tier environment is a common setup. Use a tool of your choosing/familiarity create these resources. Please remember we will not be judging on the outcome but more on the approach, style and reproducibility.

#### Solution
Three tier architecture consists of mainly below three components: 
1. **Business/Presentation Layer** - Frontend, which provides user interface to consumers of the application.
2. **Application Layer** - Backend, which controls the application's main functionality or computations.
3. **Data Layer** - Databases, which contains the application's and user's data along with entitlements. 

In this approach, I am using various components for individual layer.
High level architecture explained in the below image.

![](https://github.com/PVikash/Challenges/blob/main/assignment/challenge_1/resources/Three-Tier_Enviornment.png "Three Tier Environment")

###### Business/Presentation Layer
For Business Layer, I am using VPC, Subnets, Load Balancer & GKE cluster for frontend application.

###### Application Layer
For Application Layer, I am using Load Balancer & GKE cluster.

###### Data Layer
For Data Layer, I am using Cloud SQL (Postgres) with a passive node in different zone.
