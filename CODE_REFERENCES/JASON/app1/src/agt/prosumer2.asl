/* Beliefs */

/* If we have enough available_power => accept */
+!propose(Quantity, Price)
:  available_power(Avail) & (Quantity <= Avail)
<- .print("Prosumer2: Received proposal for ", Quantity, " units at price ", Price, ".");
   .print("Prosumer2: Enough power => ACCEPTING trade!");
   .send(prosumer1, tell, propose_accept(Quantity, Price));
   OldAvail = Avail;
   NewAvail = (OldAvail - Quantity);
   -available_power(OldAvail);
   +available_power(NewAvail);
   .print("Prosumer2: Updated power from ", OldAvail, " to ", NewAvail, ".").

/* Not enough power => reject */
+!propose(Quantity, Price)
:  available_power(Avail) & (Quantity > Avail)
<- .print("Prosumer2: Received proposal for ", Quantity, " units at price ", Price, ".");
   .print("Prosumer2: Insufficient power => REJECTING trade...");
   .send(prosumer1, tell, propose_reject(Quantity, Price)).
