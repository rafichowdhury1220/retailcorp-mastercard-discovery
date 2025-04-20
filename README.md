# RetailCorp Mastercard Discovery Project

This project documents my end-to-end discovery work for a large-scale Mastercard data ingestion project. The goal was to integrate enrollment, transaction, and reconciliation data from BankCorp into RetailCorp’s enterprise data platform (EDP) to support downstream analytics, segmentation, and campaign activation.

---

## 🧠 My Role

As the Business Analyst leading this initiative, I was responsible for identifying all data sources, mapping the file flows, documenting system touchpoints, validating business requirements, and surfacing risks early — all before any ingestion work began.

---

## 🧭 Step-by-Step Breakdown

### Step 1: Kickoff + Stakeholder Alignment
I met with key stakeholders across Marketing, CDP, and Data Engineering to align on the goal:
> “We want Mastercard data flowing into our EDP, accessible to CDP and marketing systems.”

I identified the right SMEs from each domain and set up initial syncs to collect system knowledge and documentation.

---

### Step 2: Gather Source Docs and Samples
I worked with the Payments team and data engineering leads to gather:
- Sample enrollment, transaction, and reconciliation files
- Existing ETL job flows from legacy systems
- File specifications and data dictionaries from BankCorp
- Existing Confluence notes from past data feeds

---

### Step 3: Understand the Data Flows
I mapped the full journey of each file:
- **Inbound files** (from BankCorp): how they arrived, where they landed, which jobs decrypted them
- **Processing steps**: mainframe jobs, validations, intermediate tables
- **Destination**: which tables in EDW received what

---

### Step 4: Business Requirement Mapping
I took business requirements from the CDP team and mapped them to available fields in the files:
- Can we filter by Mastercard enrollment?
- Can we identify primary vs. authorized users?
- Do we know if an account is open or closed?

I logged gaps and followed up where data was missing or unclear.

---

### Step 5: Risk + Issue Logging
I documented key risks early:
- Header dates aren’t reliable for detecting duplicates
- Some required fields are missing in enrollment files
- Files can be resent with changes, creating ingestion confusion

---

### Step 6: Document the Discovery
I compiled everything into a Discovery Document — this outlined:
- What files we have
- Where they come from
- How they're processed
- What the business needs
- What’s missing or at risk

---

### Step 7: Review + Final Sign-off
I walked stakeholders through the document, clarified open questions, and got alignment for ingestion planning. This created a single source of truth for the engineering and CDP teams to move forward.

---

## 📎 Discovery Document

The full anonymized Discovery Document is below.
