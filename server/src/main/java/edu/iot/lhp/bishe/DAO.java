package edu.iot.lhp.bishe;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface DAO extends JpaRepository<User, Long> {

    User findOneByUsername(String username);
}
