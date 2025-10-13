package org.example.demo.repository.Implement;

import jakarta.persistence.EntityManager;
import jakarta.persistence.NoResultException;
import jakarta.persistence.TypedQuery;
import org.example.demo.config.PersistenceManager;
import org.example.demo.entities.User;
import org.example.demo.repository.Interfaces.IUserRepo;

public class UserRepoImpl implements IUserRepo {

    @Override
    public User findByEmailAndPassword(String email,String password){
        EntityManager em = PersistenceManager.getEntityManager();
        try {
            TypedQuery<User> query = em.createQuery(
                    "SELECT u FROM User u WHERE u.email = :email AND u.password = :password",
                    User.class
            );
            query.setParameter("email", email);
            query.setParameter("password", password);
            return query.getSingleResult();
        } catch (NoResultException e) {
            return null; // aucun utilisateur trouvé
        } finally {
            em.close(); // très important !
        }
    }
}
