package ca.sait.lab7.dataaccess;

import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;

public class DBUtil1 {
    private static final EntityManagerFactory emf =
        Persistence.createEntityManagerFactory("UsersPU");

    public static EntityManagerFactory getEmFactory() {
        return emf;
    }
}
