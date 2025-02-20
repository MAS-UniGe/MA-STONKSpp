#!/usr/bin/env python
import os
import random
import agentspeak.runtime
import agentspeak.stdlib
from agentspeak import Literal, GoalType, Trigger
from agentspeak.runtime import Intention

# Combine standard library actions with our own custom ones.
actions = agentspeak.Actions(agentspeak.stdlib.actions)

# Custom action to set an integer belief in the agent's belief base.
@actions.add(functor="set_belief", arity=2)
def set_belief(agent, term, intention):
    belief_name = str(term.args[0])
    belief_value = int(term.args[1])
    
    agent.beliefs[belief_name].add((belief_value,))
    yield


env = agentspeak.runtime.Environment()

# Build Directory Facilitator (df.asl)
with open(os.path.join(os.path.dirname(__file__), "df.asl")) as f:
    df_agent = env.build_agent(f, actions)

# Build Prosumer1
with open(os.path.join(os.path.dirname(__file__), "prosumer1.asl")) as f:
    prosumer1 = env.build_agent(f, actions)

p1_power = random.randint(50, 120)
p1_demand = random.randint(0, 80)
prosumer1.call(
    Trigger.addition,
    GoalType.achievement,
    Literal("init_beliefs", (p1_power, p1_demand)),
    Intention()
)
prosumer1.call(
    Trigger.addition,
    GoalType.achievement,
    Literal("start_discovery"),
    Intention()
)
print(f"[PY] Prosumer1 => available_power={p1_power}, demand={p1_demand}")

# Build Prosumer2
with open(os.path.join(os.path.dirname(__file__), "prosumer2.asl")) as f:
    prosumer2 = env.build_agent(f, actions)

p2_power = random.randint(50, 120)
prosumer2.call(
    Trigger.addition,
    GoalType.achievement,
    Literal("init_beliefs", (p2_power,)),
    Intention()
)
prosumer2.call(
    Trigger.addition,
    GoalType.achievement,
    Literal("start_discovery"),
    Intention()
)
print(f"[PY] Prosumer2 => available_power={p2_power}")

if __name__ == "__main__":
    env.run()