# E-Commerce Sales, Customer & Operations Analytics Dashboard (Power BI)

An interactive, two-page Power BI report that analyses **~15K orders and ₹10.89 Cr (108.87M) net revenue** for an Indian e-commerce business. It answers two questions: *how is the business performing commercially?* and *how well are operations and customers being served?*

## Project Overview

**1. Sales Performance Dashboard** | Revenue, profit, margin, returns | Where do we make money and where do we lose it? |
**2. Customer and Operations Detail** | Delivery, customers, support, coupons | Are we delivering well, and do discounts actually pay off? |


## Headline KPIs

**Sales Performance**
- Net Revenue: **108.87M** (▼ 3.5% vs last year)
- Net Profit: **29.25M** (▼ 2.7% vs last year)
- Profit Margin: **26.87%** (▲ 23.9 pp vs last year)
- Total Orders: **15K** (▼ 2.5%)
- Average Order Value (AOV): **9.34K** (▼ 0.7%)
- Return + Cancel Rate: **14.95%** (▲ 15.7 pp)
- Average Rating: **2.93** (▼ 0.01)

**Customer & Operations**
- Avg Delivery Days: **4.45**
- On-time Delivery: **64.46%**
- Repeat Customer: **84.77%**
- Coupon Usage: **41.37%**
- Support Tickets per Order: **0.6**

---

## Dashboard Features

### Page 1: Sales Performance Dashboard
- **Slicers:** Year, Month, State, City, Segment, Category, Channel
- KPI cards with year-over-year change indicators (green/red)
- Monthly Net Revenue (columns) vs Profit Margin % (line) combo chart
- Profit by Product Category
- Net Profit by City (Mumbai, Delhi, Bengaluru, Chennai, Pune)
- Revenue by Customer Segment (Consumer, Corporate, Small Business)
- New vs Existing customers split
- Channel table: Revenue, Profit and Margin (Organic Search, Paid Search, Social Media, Direct)
- Margin % by Discount Band
- Return reasons breakdown
- Average Rating by Delivery Time

### Page 2: Customer and Operations Detail
- **Slicers:** Year, Category, Segment, Payment
- New vs Existing customers by month (100% stacked)
- Revenue by Gender and by Age Group
- Average rating by number of support tickets
- Delivery speed, rating and shipping cost by shipping type
- Orders and rating by payment method
- Average Order Value: coupon vs no coupon
- Margin %: coupon vs no coupon
- Product-level table: Orders, Net Revenue, Net Profit

---

## Key Insights

1. **Electronics drives the business.** It contributes by far the largest share of profit; Home & Kitchen is a distant second, and categories like Toys, Grocery and Books add very little.
2. **Revenue and profit are slightly down year over year** (-3.5% and -2.7%) while margin is healthy at ~27%, so the issue is volume, not pricing.
3. **Heavy discounting hurts margin.** Margin % drops in the higher discount bands (especially 16%+), and coupon orders show a lower margin than non-coupon orders, even though 41% of orders use a coupon.
4. **Returns are a quality and fulfilment problem.** "Damaged" is the top return reason, followed by "Changed Mind" and "Wrong Item"; Late Delivery and Quality Issue also feature prominently.
5. **Delivery is a weak spot.** Only 64.46% of orders arrive on time, average delivery takes 4.45 days, and ratings are lowest for orders that take 5-6 days.
6. **Faster shipping doesn't mean faster delivery.** Same Day, Express and Standard all average about 4.4 days, yet Same Day costs the most (~260 vs ~143 for Standard), so premium shipping is not delivering on its promise.
7. **Customers are loyal but not delighted.** Repeat customer rate is high (84.77%), but the average rating is only 2.93.
8. **Payment mix:** Credit Card leads with 2,987 orders, followed by Cash on Delivery (2,167), Debit Card (2,047) and EMI (859). Cash on Delivery has the lowest average rating (2.82).
9. **Customer base:** Consumers generate ~71% of revenue; women account for ~54% of revenue; the 35-44 age group is the top revenue contributor.
10. **Acquisition:** Organic Search is the highest revenue channel, ahead of Paid Search, Social Media and Direct.

## Business Recommendations
- Cap or restructure coupons and deep discounts to protect margin.
- Audit packaging and carrier handling to cut "Damaged" returns.
- Renegotiate or fix Same Day / Express logistics so the premium price matches real delivery times.
- Focus on the 5+ day deliveries to lift on-time % and ratings.
- Double down on Electronics and Organic Search while testing growth in under-performing categories.

---

## Tools & Skills Demonstrated
- **Power BI Desktop:** data modelling, report design, slicers, conditional formatting
- **DAX:** YoY comparisons, profit margin %, on-time %, repeat customer %, coupon vs non-coupon measures
- **Data cleaning & transformation:** Power Query
- **Data modelling:** star schema with fact and dimension tables
- **Storytelling:** KPI-first layout, consistent colour coding (red for negative or at-risk, blue for neutral)
- **Business analysis:** turning metrics into actionable recommendations



---

## Dataset
- ~14,988 orders, covering product category, customer segment, city/state, channel, payment method, shipping type, discount, rating, returns and support tickets.
- Source: *[add your source, e.g. Kaggle / synthetic / company data]*
- Period: *[add date range]*

## How to Use
1. Download the `.pbix` file from this repository: *[add link]*
2. Open it in Power BI Desktop.
3. Use the slicers at the top of each page to filter the report.
