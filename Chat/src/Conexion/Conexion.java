package Conexion;

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */


import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

/**
 *
 * @author Angel
 */
public class Conexion {
    private Connection conexion = null;
    //private static final String cadena = "jdbc:postgresql://192.168.1.13:5432/Chat";
    private static final String cadena = "jdbc:postgresql://localhost:5432/Chat";
    private static final String user = "postgres";
    private static final String pass = "root";
    public Connection Conexion(){
        try{
            Class.forName("org.postgresql.Driver");
            conexion = DriverManager.getConnection(cadena,user,pass);
            System.out.println(conexion);
            return conexion;
        }catch(ClassNotFoundException | SQLException e){
            return conexion;
        }
    }  
}