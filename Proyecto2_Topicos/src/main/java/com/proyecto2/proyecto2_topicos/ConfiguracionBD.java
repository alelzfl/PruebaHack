/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.proyecto2.proyecto2_topicos;

/**
 *
 * @author Joela
 */

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

/**
 * Configuración centralizada de la conexión a MySQL.
 * Único archivo a editar para cambiar credenciales.
 */

public class ConfiguracionBD {

    // Datos del servidor
    public static final String SERVIDOR = "localhost";
    public static final String PUERTO   = "3306";
    public static final String BASE     = "proyecto_seguridad";

    // Credenciales
    public static final String USUARIO  = "root";
    public static final String PASSWORD = "Asgj.032917@"; // Coloca aquí tu contraseña si la tienes
    
    // URL de conexión para MySQL
    public static final String URL =
            "jdbc:mysql://" + SERVIDOR + ":" + PUERTO + "/" + BASE
            + "?useSSL=false&serverTimezone=UTC";

    private ConfiguracionBD() {
        // Constructor privado para evitar instanciación
    }

    // Método para obtener la conexión directamente
    public static Connection getConexion() throws SQLException {
        return DriverManager.getConnection(URL, USUARIO, PASSWORD);
    }
}