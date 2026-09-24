# big_garage_dataset---SQL-and-Power-BI-Analysis-Project
Building an end-to-end Data Analyst project that includes ETL, EDA, advanced data analysis, data modeling and visualization

End-to-End Data Analytics Project



Project Overview
#This project is an end-to-end data analytics project that covers the
#complete journey of data from raw source files to a final Power BI
#dashboard.

#The project uses SQL Server for data preparation and analysis and Power
#BI for data modeling, DAX calculations, and visualization. The data is
#processed through different layers so that the final output is clean,
#structured, and suitable for business reporting.

Project Structure

#The project follows a Bronze, Silver, and Gold layer architecture:
#Raw Source Data → Bronze Layer → Silver Layer → Gold Layer → Exploratory
#Data Analysis → Advanced Analysis → Power BI Data Model → Dashboard

Files in the Project

1_bronze_layer.sql
#This script is used to create and load the Bronze Layer. It contains the
#raw source data with minimal transformation and acts as the initial
#landing layer for the data.

2_silver_layer.sql

#This script creates the Silver Layer. The data is cleaned and
#standardized in this layer. It includes activities such as handling
#missing values, correcting data types, standardizing values, and
#preparing the data for further analysis.

3_gold_layer_views.sql
#This script creates the Gold Layer views. The Gold Layer contains
#business-ready data that can be used for reporting, analysis, and Power
#BI.

4_EDA_Exploratory_Data_Analysis.sql
#This script contains exploratory data analysis. It is used to understand
#the structure and quality of the data and identify important patterns,
#trends, and business-related information.

5_Advanced_Analysis.sql
#This script contains advanced SQL analysis. It focuses on extracting
#deeper business insights from the prepared data, including performance
#analysis, trends, rankings, and other analytical requirements.

big garage.pbix
#This is the Power BI report file. It contains the Power BI data model,
#relationships, DAX measures, and visualizations used to build the final
#dashboard.

dashboard
#This contains the final dashboard output and represents the reporting
#layer of the project.

data modeling
#This contains the data model documentation and shows how the tables are
#connected in Power BI, including the relationships between fact and
#dimension tables.

Data Modeling
#The Power BI model follows dimensional modeling principles. Fact and
#dimension tables are connected using primary and foreign keys.



#The model focuses on:

#-   Fact and dimension tables
#-   Primary and foreign keys
#-   Cardinality
#-   Relationships
#-   Filter direction
#-   Star schema design
#-   DAX measures
#The purpose of the model is to create a clean and efficient structure
#for reporting and analysis.



Analysis
#The project includes both exploratory and advanced analysis using SQL.
#The analysis covers areas such as:
#-   Revenue analysis
#-   Customer analysis
#-   Product and brand performance
#-   Order analysis
#-   Business trends
#-   Rankings and comparisons
#-   Data quality checks


Power BI Dashboard
#The final dashboard is created in Power BI using the prepared Gold Layer
#data.

#The dashboard provides an interactive view of the business data and
#includes KPIs, charts, filters, and other visualizations to support
#business analysis.

Technologies Used
#-   SQL Server
#-   SQL
#-   Power BI
#-   DAX
#-   Data Modeling
#-   Bronze, Silver, and Gold Layer Architecture

Project Objective

#The main objective of this project is to demonstrate an end-to-end data
#analytics workflow.

#It covers the complete process from raw data ingestion and
#transformation to SQL analysis, data modeling, DAX calculations, and
#Power BI reporting.

#This project demonstrates practical skills required for a Data Analyst
#role and can be used as part of a professional data analytics portfolio.
