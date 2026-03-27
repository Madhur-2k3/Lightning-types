# Custom Lightning Types — Property Search by City

> Display **custom LWC components** inside the Agentforce Employee Agent chat window using **Custom Lightning Types**.

## What's in This Repo

A complete, deployable Salesforce DX example that demonstrates:

- An **Apex invocable action** (`PropertyController`) that queries `Property__c` by city
- A **styled LWC renderer** (`propertyListRenderer`) that displays property cards inside the agent chat
- **Lightning Type configuration** (`schema.json` + `renderer.json`) that links the Apex output to the LWC

---

## Folder Structure

```
force-app/main/default/
├── classes/
│   ├── PropertyController.cls
│   └── PropertyController.cls-meta.xml
│
├── lwc/
│   └── propertyListRenderer/
│       ├── propertyListRenderer.html
│       ├── propertyListRenderer.js
│       ├── propertyListRenderer.css
│       └── propertyListRenderer.js-meta.xml
│
└── lightningTypes/
    └── propertySearchByCity/            ← Lightning Type name
        ├── schema.json
        └── lightningDesktopGenAi/
            └── renderer.json
```

---

## Prerequisites

- A Salesforce org with **Agentforce** enabled
- A custom object **`Property__c`** with these fields:
  | Field API Name | Type |
  |---|---|
  | `Name` | Text (standard) |
  | `City__c` | Text |
  | `Property_Category__c` | Text |
  | `Property_Sub_Category__c` | Text |
  | `Status__c` | Text |
  | `State__c` | Text |
- Some sample records in `Property__c`

---

## Deployment

```bash
# Authenticate to your org
sf org login web --alias my-org

# Deploy everything
sf project deploy start --source-dir force-app --target-org my-org
```

---

## Agent Configuration (Post-Deploy)

1. **Create Agent Action** → Setup → Agent Actions → point to `PropertyController`
2. **Add to Agent Topic** → Setup → Agents → Employee Agent → add the action to a topic
3. **Topic Instructions** — include these keywords so the agent uses the Lightning Type:

```
When a user asks about properties in a city,
take the input from the user using lightning types.
Use the "Fetch Properties By City" action and return the results
using the custom lightning type output.
```

> ⚠️ Without these keywords the agent will return plain text instead of your custom LWC.

---

## How It Works

```
User asks question → Agent runs Apex Action → Apex returns wrapper data
→ Lightning Type maps data to LWC → Custom component renders in chat
```

