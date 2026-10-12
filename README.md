Berlin Airbnb Analytics

Is Airbnb's guest satisfaction metric telling the truth? An end-to-end analytics project on 410,000 Berlin Airbnb reviews, from raw CSV files to a tested data pipeline and a Power BI dashboard.

Status: in progress. Module 1 (platform team) is being built.

Business brief
Stakeholder

The Airbnb platform team for Berlin, who own guest trust and marketplace quality. They use review sentiment as a headline measure of how happy guests are, and use it to decide where to invest in quality improvements.

The problem

Initial profiling of the data suggests that the sentiment label attached to each review is not reliable for reviews written in languages other than English. If that is true, the platform team may be reporting a drop in guest satisfaction that did not happen, and making decisions on a flawed metric.

Business questions
#	Question	Decision it informs
P1	Can we trust the supplied sentiment label across languages?	Whether to keep using the label in quality reporting
P2	Did guest satisfaction really fall in 2020 and 2021?	Whether a quality intervention is needed, and how big
P3	Is the Superhost badge associated with better guest outcomes?	Whether the badge criteria reward the right behaviour
P4	How clean and active is the Berlin marketplace?	Which listings and review records to clean up or flag
Success looks like

The platform team can see, in one dashboard, whether satisfaction is genuinely changing, which parts of the review data they can trust, and which listings need attention. A good outcome is that they stop reporting a quality decline that is mostly a language artefact.

KPIs
KPI	Definition
Corrected negative review rate	Negative reviews as a share of genuine, labelled reviews, by language and month
Review language mix	Share of reviews written in each language, by year
Active listing rate	Share of listings with at least one review in the last 12 months of the data
Superhost gap	Difference between Superhost and other listings on reviews, activity, sentiment and price
Data quality issue count	Number of rows caught by each cleaning rule
Scope

In scope: Berlin listings, hosts and reviews from 2009 to October 2021. The three source tables are hosts (14,111 rows), listings (17,499 rows) and reviews (410,284 rows).

Out of scope for module 1: pricing recommendations for hosts, and housing policy questions. These are covered in modules 2 and 3.

Assumptions and limitations
Currency: prices are stored with a dollar sign, but Berlin prices in this source are in local currency, so they are treated as euros (price_eur).
Superhost status is a snapshot taken when the data was extracted, not the status at the time of each review. All Superhost comparisons show association, not cause.
Host CREATED_AT matches the date of each host's first listing, so it is renamed first_listing_at and is not used as an account sign-up date.
The data is a single snapshot with no history of changes to listings or hosts.