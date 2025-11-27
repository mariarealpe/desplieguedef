package com.microservices.desplieg.config;

import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.boot.jdbc.DataSourceBuilder;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Profile;

import javax.sql.DataSource;

@Configuration
@Profile("prod")
public class DataSourceConfig {

    @Bean
    @ConfigurationProperties(prefix = "spring.datasource")
    public DataSource dataSource() {
        // Obtener la URL de la base de datos desde la variable de entorno
        String databaseUrl = System.getenv("DATABASE_URL");

        if (databaseUrl == null) {
            throw new IllegalStateException("DATABASE_URL environment variable is not set");
        }

        // Si la URL no empieza con jdbc:, agregarla
        if (!databaseUrl.startsWith("jdbc:")) {
            databaseUrl = "jdbc:" + databaseUrl;
            System.out.println("Converted DATABASE_URL to JDBC format: " + databaseUrl.replaceAll(":[^:@]+@", ":***@"));
        }

        return DataSourceBuilder
                .create()
                .url(databaseUrl)
                .driverClassName("org.postgresql.Driver")
                .build();
    }
}

