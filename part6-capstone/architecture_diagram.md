# Healthcare Analytics Platform - Architecture Diagram

## System Architecture Overview

```mermaid
flowchart TB
    subgraph DataSources["Data Sources Layer"]
        TH[Treatment History]
        IV[ICU Vitals Stream]
        SI[Staff Clinical Inputs]
    end

    subgraph Storage["Storage Layer"]
        RDB[(Relational DB\nPostgreSQL)]
        TSDB[(Time-Series DB\nInfluxDB)]
        VDB[(Vector DB\nPinecone/Milvus)]
    end

    subgraph Processing["Processing Layer"]
        ETL[ETL Pipeline\nApache Airflow]
        DW[(Data Warehouse\nSnowflake)]
    end

    subgraph AI["AI & Analytics Layer"]
        PM[Predictive Models\nPatient Outcomes]
        LLM[LLM Agent\nClinical Assistant]
        BI[BI Dashboards\nTableau/PowerBI]
    end

    subgraph API["API Layer"]
        REST[REST API\nFastAPI]
        GRAPHQL[GraphQL API]
    end

    %% Data Source Connections
    TH -->|Historical Records| RDB
    IV -->|Real-time Stream| TSDB
    SI -->|Structured Entry| RDB
    SI -->|Clinical Notes| VDB

    %% Storage to Processing
    RDB -->|Batch Sync| ETL
    TSDB -->|Aggregated Metrics| ETL
    VDB -->|Semantic Context| ETL

    %% Processing to Warehouse
    ETL -->|Transformed Data| DW

    %% AI Layer Connections
    DW -->|Analytical Queries| PM
    DW -->|Reporting Data| BI
    VDB -->|Semantic Search| LLM
    PM -->|Risk Scores| REST
    LLM -->|Natural Language| GRAPHQL

    %% External Access
    REST -->|Mobile/Web Apps| UI[Clinician Dashboard]
    GRAPHQL -->|AI Chat Interface| UI
```

## Component Description

| Layer | Component | Purpose |
|-------|-----------|--------|
| Sources | Treatment History | Historical patient records, medications, procedures |
| Sources | ICU Vitals Stream | Real-time physiological data from ICU monitors |
| Sources | Staff Inputs | Clinical notes, diagnoses, care plans |
| Storage | Relational DB | Structured patient records with ACID compliance |
| Storage | Time-Series DB | High-frequency vital signs with temporal queries |
| Storage | Vector DB | Semantic search over clinical documentation |
| Processing | ETL Pipeline | Data cleaning, transformation, and orchestration |
| Processing | Data Warehouse | Aggregated data for reporting and ML training |
| AI | Predictive Models | Patient deterioration, readmission risk |
| AI | LLM Agent | Natural language clinical assistant |
| API | REST/GraphQL | Secure access to all data services |
