package org.example.demo.entities;
import jakarta.persistence.*;
import org.example.demo.entities.enums.Role;
import org.hibernate.annotations.UuidGenerator;

import java.time.Instant;
import java.util.UUID;

@Entity
@Inheritance(strategy = InheritanceType.JOINED)
@Table(name = "users")

public class User {
    @Id
    @GeneratedValue
    @UuidGenerator
    @Column(columnDefinition = "UUID")
    protected UUID id;

    @Column(nullable = false, unique = true)
    protected String email;

    @Column(nullable = false)
    protected String password;

    @Column(name = "full_name", nullable = false)
    protected String fullName;

    @Enumerated(EnumType.STRING)
    @Column(nullable = false)
    protected Role role;

    // timestamps
    @Column(name = "created_at", nullable = false, updatable = false)
    protected Instant createdAt;

    @Column(name = "updated_at", nullable = false)
    protected Instant updatedAt;

    // == Constructeurs ==
    public User() {}

    public User(UUID id,String email, String password, String fullName, Role role) {
        this.id=id;
        this.email = email;
        this.password = password;
        this.fullName = fullName;
        this.role = role;
    }

    // == Lifecycle callbacks ==
    @PrePersist
    protected void onCreate() {
        Instant now = Instant.now();
        if (id == null) {
            id = UUID.randomUUID(); // utile si Hibernate ne génère pas l'UUID (ex: ancienne version)
        }
        this.createdAt = now;
        this.updatedAt = now;
    }

    @PreUpdate
    protected void onUpdate() {
        this.updatedAt = Instant.now();
    }

    // == Getters / Setters ==
    public UUID getId() { return id; }
    public void setId(UUID id) { this.id = id; }

    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }

    public String getPassword() { return password; }
    public void setPassword(String password) { this.password = password; }

    public String getFullName() { return fullName; }
    public void setFullName(String fullName) { this.fullName = fullName; }

    public Role getRole() { return role; }
    public void setRole(Role role) { this.role = role; }

    public Instant getCreatedAt() { return createdAt; }
    public Instant getUpdatedAt() { return updatedAt; }
}
