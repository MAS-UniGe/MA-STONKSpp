/* Beliefs */
registered([]).

/* Register a new list of prosumers */
+!register(Prosumers) : true
<- registered(Current);
   New = .concat(Current, Prosumers);
   -registered(Current);
   +registered(New);
   .print("DF: Registered prosumers: ", New, ".").

/* Provide the list of registered prosumers */
+!get_prosumers : true
<- registered(Prosumers);
   .print("DF: Sending list of registered prosumers: ", Prosumers, ".");
   .send(prosumer1, tell, prosumer_list(Prosumers)).
