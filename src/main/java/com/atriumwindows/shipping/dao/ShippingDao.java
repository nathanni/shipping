package com.atriumwindows.shipping.dao;

import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

import java.sql.Date;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

/**
 * Created by Nathan on 2/17/2016.
 */
@Repository
public class ShippingDao extends BaseDao {



    public String getSalesOrderByTrackingNumber(String trackingNumber) {
        String sql = "SELECT Sales_Order_Number FROM Tracking WHERE Tracking_Number = ?";
        return getStringBySingleParam(trackingNumber, sql);
    }

    public String getLoadNumberBySalesOrder(String salesOrder) {

        String sql = "SELECT DISTINCT BOL FROM OrderMaster WHERE SalesOrder = ?";

        return getStringBySingleParam(salesOrder, sql);
    }

    public String getTrackingNumberBySalesOrder(String salesOrder) {
        String sql = "SELECT Tracking_Number FROM Tracking WHERE Sales_Order_Number = ?";

        return getStringBySingleParam(salesOrder, sql);
    }

    private String getStringBySingleParam(String singleParam, String sql) {
        List<String> strLst = jdbcTemplate.query(sql, new RowMapper<String>() {
            public String mapRow(ResultSet resultSet, int i) throws SQLException {
                return resultSet.getString(1);
            }
        }, singleParam);

        if ( strLst.isEmpty() ){
            return null;
        }else if ( strLst.size() == 1 ) { // list contains exactly 1 element
            return strLst.get(0);
        }else{  // list contains more than 1 elements
            //your wish, you can either throw the exception or return 1st element.
            return strLst.get(0);
        }
    }






    public void saveShippingInfo(String salesOrder, String trackingNumber, String shippingMethod) {

        Date date = new Date(System.currentTimeMillis());


        String sql = "INSERT INTO tracking (Sales_Order_Number, Tracking_Number, Carrier, DateTime) VALUES (?, ?, ?, ?)";

        jdbcTemplate.update(sql, new Object[] {
                salesOrder, trackingNumber, shippingMethod, date
        });


    }

    public boolean checkAssociate(String salesOrder, String trackingNumber) {
        String sql = "SELECT tracking_Number FROM tracking WHERE Sales_Order_Number = ? AND Tracking_Number = ?";

        try {
            String result = jdbcTemplate.queryForObject(sql, new Object[]{salesOrder, trackingNumber}, java.lang.String.class);
        } catch (EmptyResultDataAccessException e) {
            return false;
        }

        return true;

    }



}
