<h1 align="center"> 🏏 IPL Data Analytics using SQL </h1>

🎯 **Project Title**: SQL Project – IPL Data Analysis              
🗂️ **Datasets Used**: ipl_matches.csv            
🎓 **Focus**: Data extraction, aggregation, and business insights through SQL

---

## 🧾 Project Overview

This project is a comprehensive SQL case study based on an **IPL (Indian Premier League) Match Data** scenario. It simulates real-world sports analytics tasks using a single relational dataset:
- 🏏 `ipl_matches.csv`: Detailed information about IPL matches, including teams, venues, scores, and outcomes.

The goal is to gain insights into team performance, player achievements, and match trends using SQL queries in **PostgreSQL**.

---

## 🗃️ Database Schema (Key Columns)

| ipl_matches.csv |
|-------------------|
| id (PK)           |
| season            |
| city              |
| date              |
| team1             |
| team2             |
| toss_winner       |
| toss_decision     |
| result            |
| dl_applied        |
| winner            |
| win_by_runs       |
| win_by_wickets    |
| player_of_match   |
| venue             |
| umpire1           |
| umpire2           |

---

## 🔍 List of SQL Queries Executed

### 🟢 Basic Queries
1.  How many total matches were played?
2.  How many seasons are included in the dataset?
3.  How many matches were played in each season?
4.  How many unique cities hosted IPL matches?
5.  Which city hosted the most matches?
6.  How many unique venues hosted IPL matches?
7.  Which venue has hosted the highest number of matches?
8.  How many matches did each team win?
9.  How many times did each team win the toss?
10. What is the frequency of each toss decision (bat vs field)?
11. How many matches were decided by D/L method?
12. Which team has won the most matches while chasing?
13. Which team has won the most matches while defending?
14. What are the top 5 matches with highest win margins by runs?
15. What are the top 5 matches with highest win margins by wickets?
16. Which players have won the most "Player of the Match" awards?
17. Which seasons had the most matches?
18. How many matches ended in a tie or no result?
19. Which team appeared in the most matches?
20. How many different umpires officiated across all matches?
21. What are the most frequent team pairings in IPL history (team1 vs team2)?

---

### 🔵 Advanced Queries
1.  Who was the top "Player of the Match" for each season?
2.  What is the win percentage of each team (based on total matches they played)?
3.  Which team had the most finals appearances?
4.  Which venue has had the most variety of winning teams (i.e., most unique winners)?
5.  Which seasons had the highest number of different winning teams?
6.  Which team has the highest average margin of victory while chasing?
7.  Which team has the highest average margin of victory while defending?
8.  Which team had the most consistent appearances per season?
9.  Which team lost the most matches after winning the toss?
10. Which season had the highest number of D/L affected matches?
11. Who are the top 3 umpires with most match appearances?
12. Find the most dominant season for any team.
13. Which toss winner had the highest win conversion rate?
14. Which city has hosted IPL matches for the most number of different seasons?

---

## 📈 Key Insights from Analysis

- 📊 A total of 756 matches were played across 12 IPL seasons.
- 🏟️ Mumbai hosted the most matches.
- 🏆 Mumbai Indians won the most matches overall (109 wins), and also while chasing.
- 🛡️ Chennai Super Kings won the most matches while defending (57 wins).
- 🌟 Lasith Malinga has won the most "Player of the Match" awards.
- 📅 The 2013 season had the highest number of matches (76 matches).
- 🏅 For the 2008 season, M.V. Boucher was the top "Player of the Match".
- 💪 Mumbai Indians and Chennai Super Kings show high win percentages.
- 🥇 Mumbai Indians had the most finals appearances.
- 📍 The M Chinnaswamy Stadium has hosted the most variety of winning teams.
- 🌆 Kolkata has hosted IPL matches for the most number of different seasons.

---

## 🛠 Tools & Technologies

- 💻 PostgreSQL (Database and query execution)
- 🧠 SQL (Joins, Aggregation, Subqueries, Filtering, Window Functions, CTEs)
- 📊 CSV file for relational schema
- 📁 Git & GitHub for version control and deployment

---

## 📂 Repository Structure
| File | Description |
|------|-------------|
| `Ipl Data Analytics using SQL.sql` | PostgreSQL queries for all given analyses |
| `IPL DATA ANALYTICS USING SQL.pdf` | Final submitted queries and analysis in PDF format |
| `IPL Matches Dataset.csv` | The raw dataset used for this analysis |
| `README.md` | This project documentation |

---

## 🎓 Learning Highlights

- Mastered real-world SQL operations using a comprehensive sports dataset.
- Practiced multi-table (implied by concepts, though one table used with combined columns) joins, subqueries, aggregation, and date-based filtering.
- Implemented advanced SQL concepts like Window Functions (e.g., `RANK()`) and Common Table Expressions (CTEs) for deeper insights.
- Enhanced data-driven thinking for team performance and match trend analytics.
- Leveraged AI tools (e.g., ChatGPT) for brainstorming, troubleshooting, and improving query efficiency, demonstrating adaptability with modern development aids.

---

## 🔗 Connect with Me
👤 **Satyam Kumar**  
🔗 [LinkedIn](https://www.linkedin.com/in/satyam-kumar-5a229222b)  
📧 *satyamkv123@gmail.com*  
