# Movie-Analytics-Platform
An end-to-end movie analytics platform built using MS SQL Server, Python, FastAPI, Streamlit, TMDB API, and Power BI. This project analyzes movie performance, bookings, revenue, and audience behavior, enriched with real movie metadata.


#  Movie Analytics Platform (BookMyShow-inspired)

An end-to-end **Movie Analytics Platform** built using **MS SQL Server, Python, FastAPI, Streamlit, Power BI, and TMDB API**.  
This project analyzes movie performance by combining **external movie metadata** with **booking and revenue data**.

---

##  Project Overview

This project simulates how platforms like **BookMyShow** or **OTT analytics teams** analyze movies using:
- Ratings & popularity (external data)
- Bookings & revenue (business data)
- City-wise and movie-wise performance
- Interactive dashboards and APIs

---

##  Architecture

TMDB API
↓
Python Enrichment Script
↓
MS SQL Server (Movies + Bookings)
↓
FastAPI (Analytics APIs)
↓
Streamlit (Search-based Analytics)
↓
Power BI (Executive Dashboards)


---

##  Tech Stack

- **Database:** MS SQL Server  
- **Backend:** Python, FastAPI  
- **APIs:** TMDB (Movie metadata)  
- **Visualization:** Streamlit, Power BI  
- **Libraries:** pandas, matplotlib, pyodbc, requests  

---

##  Power BI Dashboard (3 Pages)

###  Page 1 – Movie Overview
- Rating vs Revenue (Scatter/Bubble Chart)
- Revenue by Movie (Bar Chart)
- Bookings by Movie
- Key KPIs

###  Page 2 – Movie Deep Dive
- Movie-wise performance
- Rating, popularity & revenue comparison
- City contribution analysis

###  Page 3 – Bookings Analysis
- City-wise bookings
- Booking volume trends
- Revenue contribution by location

---

##  Streamlit Features

- Search movie by name
- View TMDB rating, votes, popularity
- Total bookings & revenue
- Top-performing city
- Rating vs Revenue interactive chart
- Revenue by city bar chart

---

##  FastAPI Endpoints

- `/movies` → List all movies  
- `/analytics/movie?name=MovieName` → Movie-level analytics  
- `/analytics/rating-vs-revenue` → Cross-movie analytics  

---

##  Data Enrichment

- Movie metadata fetched from **TMDB API**
- Ratings, votes & popularity auto-updated
- Rate-limit handling with retries & throttling
- Idempotent enrichment pipeline

---
#  Project Structure

movie_analytics/
│
├── sql/
│   └── schema_and_data.sql
│
├── backend/
│   ├── main.py               # FastAPI backend
│   ├── tmdb_enrich.py        # TMDB data enrichment
│
├── streamlit_app/
│   └── app.py                # Streamlit analytics UI
│
├── powerbi/
│   └── MovieAnalytics.pbix   # Power BI dashboard
│
└── README.md

---

##  Database Design

Tables:
- movies
- shows
- bookings
- users
- theatres
- cities

Relationships:
- movies → shows → bookings
- cities → theatres → shows
- users → bookings

---

##  Backend APIs (FastAPI)

- GET /movies  
- GET /analytics/movie?name=MovieName  
- GET /analytics/rating-vs-revenue  

The backend connects to SQL Server and returns analytics as JSON.

##  Key Insights Enabled

- Do higher-rated movies earn more?
- Identify blockbusters vs underrated films
- City-wise demand patterns
- Popularity vs actual revenue comparison

---


##  Status

✔ Backend completed  
✔ TMDB integration completed  
✔ Streamlit analytics completed  
✔ Power BI dashboards completed  

---

##  Future Enhancements

- Real-time booking simulation
- Admin UI to add movies & shows
- Automated Power BI refresh
- Predictive analytics (ML)

---

##  Author

**Siddharth Parab**  
Data Analytics | Backend | Visualization  


