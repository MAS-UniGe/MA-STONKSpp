package example;  // Ensure this matches your project's package structure

import jason.asSyntax.Literal;
import jason.asSyntax.ASSyntax;
import jason.asSyntax.Structure;
import jason.environment.Environment;
import java.util.Random;
import java.util.logging.Logger;

public class DynamicEnv extends Environment {

    private Logger logger = Logger.getLogger("app1.DynamicEnv");

    @Override
    public void init(String[] args) {
        super.init(args);
        Random rand = new Random();

        // Define agents
        String[] agents = {"prosumer1", "prosumer2"};

        for (String agent : agents) {
            // Generate random available_power between 50 and 150 for variability
            int randPower = 50 + rand.nextInt(101); // 50 to 150
            String beliefStr = "available_power(" + randPower + ")";
            Literal belief = Literal.parseLiteral(beliefStr);
            addPercept(agent, belief);
            logger.info("Added belief to " + agent + ": " + beliefStr);
        }

        // Example: Adding dynamic 'demand' belief to prosumer1
        int demand = 50 + rand.nextInt(51); // 50 to 100
        String demandStr = "demand(" + demand + ")";
        Literal demandBelief = Literal.parseLiteral(demandStr);
        addPercept("prosumer1", demandBelief);
        logger.info("Added belief to prosumer1: " + demandStr);

        // Example: Adding 'neighbor' belief to prosumer1
        String neighborStr = "neighbor(prosumer2)";
        Literal neighborBelief = Literal.parseLiteral(neighborStr);
        addPercept("prosumer1", neighborBelief);
        logger.info("Added belief to prosumer1: " + neighborStr);
    }

    @Override
    public boolean executeAction(String agName, Structure action) {
        // Implement any environment actions if necessary
        logger.info("Executing action: " + action + " by " + agName);
        // For now, simply inform agents of environment changes
        informAgsEnvironmentChanged();
        return true; // Action executed successfully
    }

    @Override
    public void stop() {
        super.stop();
        logger.info("Environment stopped.");
    }
}

