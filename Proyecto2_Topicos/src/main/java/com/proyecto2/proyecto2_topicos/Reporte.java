package com.proyecto2.proyecto2_topicos;

import org.jfree.data.category.DefaultCategoryDataset;
import javax.swing.table.DefaultTableModel;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;

public class Reporte {

    // Nombre exacto como está en tblentidades
    public static final String ENTIDAD = "Coahuila de Zaragoza";

    // Datos para la JTable
    public DefaultTableModel obtenerDatosTabla() {
        DefaultTableModel modelo = new DefaultTableModel(new String[]{"Estado", "Delito", "Año", "Casos"}, 0);
        String query = "SELECT entidad, delito, anio, total_casos FROM vw_reporte_incidencias "
                     + "ORDER BY anio DESC, delito ASC";

        try (Connection conn = ConfiguracionBD.getConexion();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(query)) {

            while (rs.next()) {
                modelo.addRow(new Object[]{
                    rs.getString("entidad"),
                    rs.getString("delito"),
                    rs.getInt("anio"),
                    rs.getInt("total_casos")
                });
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return modelo;
    }

    // Línea: una serie por delito, categorías = años
    public DefaultCategoryDataset obtenerDatosLineas() {
        return consultar(true);
    }

    // Área apilada: una serie por delito, categorías = años
    public DefaultCategoryDataset obtenerDatosArea() {
        return consultar(true);
    }

    // Radar: una serie por año, ejes = delitos
    public DefaultCategoryDataset obtenerDatosRadar() {
        return consultar(false);
    }

    private DefaultCategoryDataset consultar(boolean seriePorDelito) {
        DefaultCategoryDataset dataset = new DefaultCategoryDataset();
        String query = "SELECT delito, anio, total_casos FROM vw_reporte_incidencias "
                     + "WHERE entidad = ? ORDER BY anio, delito";

        try (Connection conn = ConfiguracionBD.getConexion();
             PreparedStatement ps = conn.prepareStatement(query)) {

            ps.setString(1, ENTIDAD);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    String delito = rs.getString("delito");
                    String anio   = String.valueOf(rs.getInt("anio"));
                    int casos     = rs.getInt("total_casos");

                    if (seriePorDelito) {
                        dataset.addValue(casos, delito, anio);
                    } else {
                        dataset.addValue(casos, anio, delito);
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return dataset;
    }
}