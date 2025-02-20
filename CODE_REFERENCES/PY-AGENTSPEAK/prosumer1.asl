neighbors([]).

+!init_beliefs(Power, Demand)
<-  set_belief("available_power", Power);
    set_belief("demand", Demand).

/* Register itself with the DF */
+!start_discovery : true
<- .print("Prosumer1: Registering with DF...");
   .send(df, achieve, register([prosumer1]));
   !retrieve_neighbors.

/* Retrieve neighbors from the DF */
+!retrieve_neighbors : true
<- .print("Prosumer1: Retrieving neighbors from DF...");
   .send(df, achieve, get_prosumers).

+prosumers_list(Prosumers) : true
<- .print("Prosumer1: Received prosumer list: ", Prosumers, ".");
   -neighbors(_);
   +neighbors(Prosumers);
   !start_optimization.

+!start_optimization : true
<- .print("Prosumer1: Starting optimization process...");
   !optimize_energy.

/* Optimize energy (Surplus > 0 => propose a trade) */
+!optimize_energy
:  available_power(Avail) & demand(Dem) & Surplus = (Avail - Dem) & (Surplus > 0)
<- .print("Prosumer1: Surplus of ", Surplus, " => proposing a trade...");
   !propose_trade(prosumer2, Surplus, 10).

/* Optimize energy (Surplus <= 0 => no surplus) */
+!optimize_energy
:  available_power(Avail) & demand(Dem) & Surplus = (Avail - Dem) & (Surplus <= 0)
<- .print("Prosumer1: Not enough surplus (Surplus=", Surplus, "). No trade possible.");
   !no_surplus(Surplus).

/* Propose a trade to another agent */
+!propose_trade(Neighbor, Quantity, Price) : true
<- .print("Prosumer1: Proposing ", Quantity, " units at price ", Price, " to ", Neighbor, ".");
   .send(Neighbor, achieve, propose(Quantity, Price)).

/* If no surplus */
+!no_surplus(Surplus) : true
<- .print("Prosumer1: Surplus=", Surplus, ". No trade possible.").

/* Plans for receiving acceptance/rejection of a trade */
+propose_accept(Quantity, Price) : true
<- .print("Prosumer1: Proposal ACCEPTED for ", Quantity, " units at price ", Price, ".");
   !propose_second_trade.

+propose_reject(Quantity, Price) : true
<- .print("Prosumer1: Proposal REJECTED for ", Quantity, " units at price ", Price, ".").

+!propose_second_trade : true
<- .print("Prosumer1: Preparing a second trade proposal...");
   !propose_trade(prosumer2, 90, 15). /* A higher quantity likely to be rejected */

!start_optimization.