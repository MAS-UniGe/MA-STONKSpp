## Individual Project for the Symbolic and Distributed AI course, University of Genova, IT 
## Author: Lorenzo Foschi
# Teacher: Viviana Mascardi
### 05/02/2025

This project is about integrating Multi-Agent Systems (MAS) concepts into an energy prosumer simulation tool to model decentralized peer-to-peer (P2P) electricity trading. 

Objective: The project aims to transition an existing energy prosumer network simulator towards a Belief-Desire-Intention (BDI) multi-agent architecture. 

Current State: The existing simulator (STONKSpp) models prosumer energy trading but lacks a strong multi-agent system (MAS) framework. 

Enhancements Proposed: 
Implement a BDI-based prosumer model. 
Develop communication protocols among agents using a message-passing paradigm. 
Compare implementations using python-agentspeak and Jason. 
Attempt integration with the Mango MAS framework to improve interaction capabilities. 

Technology Used: 
Mosaik & OMNeT++ for co-simulation. 
Python-agentspeak and Jason for agent modeling. 
Cosima & Mango to simulate realistic decentralized MAS behaviors. 

Challenges: 
Moving from centralized optimization to fully distributed decision-making. 
Handling dynamic neighbor discovery and adapting to network conditions. 
Ensuring scalability and real-world applicability. 

Documentation:
MASprosumersFoschiReport.pdf: report   
MASprosumersFoschiReport.docx: report (it may have display problems on linux)  
SLIDES/*.*: slides in different formats  
CODE_REFERENCES: see README there  
